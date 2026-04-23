"""
wiki_tools.accuracy — pure deterministic accuracy functions for the Blackmon Lab wiki.

All functions are pure (no side effects, no I/O) and depend only on the Python
standard library.  They form the accuracy contract enforced by validate_surface.py
and described in AGENT_CONTRACT.md.
"""

import re


# ---------------------------------------------------------------------------
# Private helpers
# ---------------------------------------------------------------------------

def _normalize_for_compare(s: str) -> str:
    """Lowercase, collapse whitespace, remove thousand commas, en-dash → hyphen, NBSP → space.

    >>> _normalize_for_compare("10,754\\u00a0species")
    '10754\\xa0species'.replace('\\xa0', ' ')
    """
    # non-breaking space → regular space
    s = s.replace('\u00a0', ' ')
    # en-dash → hyphen
    s = s.replace('\u2013', '-')
    # remove thousand-separator commas: digits,digits
    s = re.sub(r'(\d),(\d)', r'\1\2', s)
    # collapse whitespace
    s = re.sub(r'\s+', ' ', s)
    return s.lower().strip()


# ---------------------------------------------------------------------------
# Claim pre-processing: strip non-quantitative numeric tokens before
# digit_substring_ok extracts numeric tokens to check.
# These regexes target citation-context numbers that are labels or metadata,
# not scientific measurements that belong in the quoted verbatim finding.
# ---------------------------------------------------------------------------

# Author-year citations: "Charlesworth & Charlesworth (1980)", "Li & Durbin (2009)",
# "Pennell et al. (2015)", "Herman et al. 2018", "the 2020 study", "a 2024 analysis",
# "in 1990".  The year is a bibliographic label, not a measured value.
# Author-year citation patterns.  Two separate patterns are used to avoid
# flag conflicts: patterns A and C require a leading uppercase letter (case-
# sensitive), while pattern B ("a 2024 study") is case-insensitive.

# Pattern A + C: Uppercase-initial surname(s) followed by a year.
# Requires at least 2 letters total to exclude single-letter articles ("A").
_AUTHOR_YEAR_UPPER_RE = re.compile(
    r"""
    (?:
        # Pattern A: Surname(s) + optional "et al." + optional parens + year
        # Handles: Smith (2001), Smith & Jones (2001), Smith et al. 2018, Smith et al. (2018)
        [A-Z][a-zA-Z]+               # surname: capital letter + 1+ more letters
        (?:                          # optional additional author(s)
            \s+(?:&|and)\s+[A-Z][a-zA-Z]+
        )?
        (?:\s+et\s+al\.)?           # optional "et al."
        \s*\(?                       # optional opening paren
        ((?:18|19|20)\d{2})          # 4-digit year 1800–2099
        \)?                          # optional closing paren
    |
        # Pattern C: semicolon-separated author years in parenthetical citations
        # e.g., "; Irwin 2002" or "; Irwin et al. 2001"
        [;,]\s+[A-Z][a-zA-Z]+\s+(?:et\s+al\.\s+)?((?:18|19|20)\d{2})\b
    )
    """,
    re.VERBOSE,
)

# Pattern B: prose year references, case-insensitive so "A 2024 analysis" is caught.
# Matches: "the 2020 study", "a 2024 paper", "in 1990", "A 2024 analysis".
_PROSE_YEAR_RE = re.compile(
    r'\b(?:the|a|an|in|of)\s+((?:18|19|20)\d{2})\b',
    re.IGNORECASE,
)

# CI percentage labels: "95% CI", "95% credible interval", "95% confidence interval".
# The percentage is a methodological qualifier, not a measured value in the finding.
_CI_PERCENT_LABEL_RE = re.compile(
    r'\b\d+%\s+(?:CI|credible\s+intervals?|confidence\s+intervals?)\b',
    re.IGNORECASE,
)


def _strip_claim_metadata(claim: str) -> str:
    """Remove bibliographic and methodological label tokens from a claim string
    before numeric extraction.

    Two categories are stripped:
    1. Author-year citations (e.g., ``Charlesworth & Charlesworth (1980)``,
       ``Pennell et al. 2015``, ``the 2020 study``, ``A 2024 analysis``).
       The year is a bibliographic label, not a scientific measurement.
    2. CI percentage qualifiers (e.g., ``95% credible interval``, ``95% CI``).
       The percentage labels the interval width; the actual bounds are what
       the finding quote should contain.

    This function is deliberately conservative: it only matches patterns that
    clearly identify non-measurement numbers.  When in doubt, leave the token
    in place so a genuine drift is still caught.
    """
    s = _AUTHOR_YEAR_UPPER_RE.sub('', claim)
    s = _PROSE_YEAR_RE.sub('', s)
    s = _CI_PERCENT_LABEL_RE.sub('CI', s)
    return s


_NUMERIC_RE = re.compile(r'\d+(?:\.\d+)?')

_TILDE_TRIGGERS = re.compile(r'~|approximately|about', re.IGNORECASE)


# ---------------------------------------------------------------------------
# Public functions
# ---------------------------------------------------------------------------

def digit_substring_ok(claim: str, quote: str, allow_tilde: bool = True) -> tuple[bool, str]:
    """Every numeric token in *claim* must appear as an exact decimal substring of *quote*.

    If *allow_tilde* is True **and** the claim contains '~', 'approximately', or
    'about', permit +/-10% deviation per numeric token and return
    ``(True, 'tilde_match')`` when all tokens fall within that zone.

    Returns ``(passes, reason)``.

    * On pass, *reason* is ``'exact'`` or ``'tilde_match'``.
    * On failure, *reason* names the offending numeric token.

    Normalization applied before comparison: strip whitespace, remove
    thousand-separator commas, normalize en-dashes to hyphens, fold
    non-breaking spaces to regular spaces.

    >>> digit_substring_ok("67%", "across 10,754 species... 67%...")
    (True, 'exact')

    >>> digit_substring_ok("28%", "27%...", allow_tilde=False)
    (False, '28')

    >>> digit_substring_ok("~28%", "27.8%...")
    (True, 'tilde_match')

    >>> digit_substring_ok("~50%", "27.8%...")
    (False, '50')
    """
    # Strip bibliographic and methodological label tokens from the claim before
    # extracting numeric tokens.  The quote is not modified — it remains verbatim.
    stripped_claim = _strip_claim_metadata(claim)
    norm_claim = _normalize_for_compare(stripped_claim)
    norm_quote = _normalize_for_compare(quote)

    tokens = _NUMERIC_RE.findall(norm_claim)

    if not tokens:
        # No numeric content — trivially passes
        return (True, 'exact')

    uses_tilde = allow_tilde and bool(_TILDE_TRIGGERS.search(norm_claim))

    # First pass: check if every token is an exact substring of the quote.
    all_exact = all(tok in norm_quote for tok in tokens)
    if all_exact:
        return (True, 'exact')

    # Second pass: tilde/approximate zone (+/- 10%)
    if uses_tilde:
        for tok in tokens:
            if tok in norm_quote:
                continue
            # Try approximate match
            try:
                val = float(tok)
            except ValueError:
                return (False, tok)
            lo = val * 0.9
            hi = val * 1.1
            found_in_zone = False
            for candidate in _NUMERIC_RE.findall(norm_quote):
                try:
                    cval = float(candidate)
                except ValueError:
                    continue
                if lo <= cval <= hi:
                    found_in_zone = True
                    break
            if not found_in_zone:
                return (False, tok)
        return (True, 'tilde_match')

    # Exact pass failed and no tilde — report first missing token
    for tok in tokens:
        if tok not in norm_quote:
            return (False, tok)

    return (True, 'exact')


def region_grammar_ok(markdown: str) -> tuple[bool, list[str]]:
    """Validate region markers in a topic/paper/concept page.

    Rules:
    - Every ``<!-- tealc:NAME-start -->`` has a matching ``<!-- tealc:NAME-end -->``
    - Every ``<!-- user-start -->`` has a matching ``<!-- user-end -->``
    - No nested regions of the same name
    - Markers must appear at the start of a line (possibly after leading whitespace)

    Returns ``(passes, problems)`` where *problems* is a list of human-readable
    strings.  When *passes* is True, *problems* is empty.

    >>> region_grammar_ok("<!-- tealc:auto-start -->\\ntext\\n<!-- tealc:auto-end -->")
    (True, [])

    >>> region_grammar_ok("<!-- tealc:auto-start -->\\ntext")
    (False, ['orphan start: tealc:auto (no matching end)'])

    >>> region_grammar_ok("<!-- tealc:auto-end -->\\ntext")
    (False, ['orphan end: tealc:auto (no matching start)'])
    """
    problems: list[str] = []

    # Patterns — anchored to start of line (after optional whitespace)
    tealc_start_re = re.compile(
        r'^\s*<!--\s*(tealc:[A-Za-z0-9_-]+)-start\s*-->', re.MULTILINE
    )
    tealc_end_re = re.compile(
        r'^\s*<!--\s*(tealc:[A-Za-z0-9_-]+)-end\s*-->', re.MULTILINE
    )
    user_start_re = re.compile(r'^\s*<!--\s*user-start\s*-->', re.MULTILINE)
    user_end_re = re.compile(r'^\s*<!--\s*user-end\s*-->', re.MULTILINE)

    # Collect all markers in document order with positions
    events: list[tuple[int, str, str]] = []  # (pos, 'start'|'end', name)

    for m in tealc_start_re.finditer(markdown):
        events.append((m.start(), 'start', m.group(1)))
    for m in tealc_end_re.finditer(markdown):
        events.append((m.start(), 'end', m.group(1)))
    for m in user_start_re.finditer(markdown):
        events.append((m.start(), 'start', 'user'))
    for m in user_end_re.finditer(markdown):
        events.append((m.start(), 'end', 'user'))

    events.sort(key=lambda e: e[0])

    # Stack-based validation per region name
    open_stack: list[str] = []  # names of currently open regions, in order

    for _pos, kind, name in events:
        if kind == 'start':
            if name in open_stack:
                problems.append(f'nested region of same name: {name}')
            open_stack.append(name)
        else:  # end
            if name not in open_stack:
                problems.append(f'orphan end: {name} (no matching start)')
            else:
                # Remove the most-recent open of this name
                idx = len(open_stack) - 1 - open_stack[::-1].index(name)
                open_stack.pop(idx)

    for name in open_stack:
        problems.append(f'orphan start: {name} (no matching end)')

    return (len(problems) == 0, problems)


def synthesis_rouge_ok(claim: str, quotes: list[str], threshold: float = 0.35) -> bool:
    """Pure-Python ROUGE-L F-score check for synthesis claims citing >=2 findings.

    Tokenizes by splitting on whitespace + lowercasing. Computes the Longest
    Common Subsequence (LCS) between *claim* tokens and the concatenated-quotes
    tokens. Returns True if the ROUGE-L F-score (beta=1.2) is >= *threshold*.

    LCS is computed via dynamic programming.  Empty inputs return False safely.

    >>> synthesis_rouge_ok("sex chromosomes evolve rapidly", ["sex chromosomes evolve rapidly"])
    True

    >>> synthesis_rouge_ok("completely different text here", ["sex chromosomes evolve rapidly"])
    False

    >>> synthesis_rouge_ok("", [])
    False
    """
    if not claim or not quotes:
        return False

    def _tokenize(text: str) -> list[str]:
        return text.lower().split()

    claim_tokens = _tokenize(claim)
    combined = ' '.join(quotes)
    ref_tokens = _tokenize(combined)

    if not claim_tokens or not ref_tokens:
        return False

    lcs_len = _lcs_length(claim_tokens, ref_tokens)

    if lcs_len == 0:
        return False

    precision = lcs_len / len(claim_tokens)
    recall = lcs_len / len(ref_tokens)

    # ROUGE-L F-score with beta=1.2
    beta = 1.2
    beta_sq = beta ** 2
    denom = recall + beta_sq * precision
    if denom == 0:
        return False
    f_score = (1 + beta_sq) * precision * recall / denom

    return f_score >= threshold


def _lcs_length(a: list[str], b: list[str]) -> int:
    """Dynamic-programming LCS length between token lists *a* and *b*."""
    m, n = len(a), len(b)
    # Use two-row rolling array for memory efficiency
    prev = [0] * (n + 1)
    curr = [0] * (n + 1)
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if a[i - 1] == b[j - 1]:
                curr[j] = prev[j - 1] + 1
            else:
                curr[j] = max(prev[j], curr[j - 1])
        prev, curr = curr, [0] * (n + 1)
    return prev[n]
