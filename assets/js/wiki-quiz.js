/* Blackmon Lab — wiki quiz generator (V5)
 *
 * Runs only on body.wiki pages under /knowledge/topics/.
 * Activates via ?quiz=1 in URL or a "Test yourself" CTA button.
 * Scans inline citations of the form [anything, Finding N](url#finding-N),
 * fetches the paper page, extracts quotes, builds multiple-choice questions.
 * Zero LLM calls, zero server dependencies.
 */
(function wikiQuiz() {
  'use strict';

  /* ── guards ─────────────────────────────────────────────────── */
  if (!document.body.classList.contains('wiki')) return;
  if (!/^\/knowledge\/topics\//.test(location.pathname)) return;

  const main = document.getElementById('content');
  if (!main) return;

  /* ── helpers ─────────────────────────────────────────────────── */
  const INLINE_CITE_RE =
    /\[([^\]]*?),\s*Finding\s+(\d+)\]\(([^)]+?#finding-(\d+))\)/gi;

  // Extract all numerics (integers, decimals, percentages) from text.
  function extractNumerics(text) {
    const nums = [];
    const re = /(\d+(?:\.\d+)?%?)/g;
    let m;
    while ((m = re.exec(text)) !== null) {
      const raw = m[1];
      nums.push(raw);
    }
    return nums;
  }

  // Seeded pseudo-random using page URL as seed (deterministic per page).
  function seededRand(seed) {
    let s = seed;
    return function () {
      s = (s * 1664525 + 1013904223) & 0xffffffff;
      return (s >>> 0) / 4294967296;
    };
  }

  const rng = seededRand(
    Array.from(location.pathname).reduce((a, c) => a + c.charCodeAt(0), 42)
  );

  function shuffle(arr) {
    const a = arr.slice();
    for (let i = a.length - 1; i > 0; i--) {
      const j = Math.floor(rng() * (i + 1));
      [a[i], a[j]] = [a[j], a[i]];
    }
    return a;
  }

  /* ── citation extraction ─────────────────────────────────────── */
  function parseCitations(html) {
    // We need to match against the rendered HTML text content, not markdown.
    // Look for anchor hrefs containing #finding- on <a> tags.
    const anchors = main.querySelectorAll('a[href*="#finding-"]');
    const seen = new Set();
    const results = [];
    anchors.forEach(function (a) {
      const href = a.getAttribute('href');
      const fMatch = href.match(/#finding-(\d+)$/i);
      if (!fMatch) return;
      const findingNum = fMatch[1];
      // Derive paper slug from the href path
      const pathMatch = href.match(/\/knowledge\/papers\/([^/]+)\//);
      if (!pathMatch) return;
      const paperSlug = pathMatch[1];
      const key = paperSlug + '#' + findingNum;
      if (seen.has(key)) return;
      seen.add(key);
      results.push({ paperSlug, findingNum, href });
    });
    return results;
  }

  /* ── fetch + parse paper page ────────────────────────────────── */
  async function loadFindingData(paperSlug) {
    const url = '/knowledge/papers/' + paperSlug + '/';
    let html;
    try {
      const resp = await fetch(url);
      if (!resp.ok) return null;
      html = await resp.text();
    } catch (e) {
      return null;
    }

    const parser = new DOMParser();
    const doc = parser.parseFromString(html, 'text/html');

    // Map findingNum -> { quote, allNumerics }
    const findings = {};
    const allNumericsForPaper = [];

    const anchors = doc.querySelectorAll('a[id^="finding-"]');
    anchors.forEach(function (anchor) {
      const id = anchor.getAttribute('id'); // "finding-N"
      const num = id.replace('finding-', '');

      // The blockquote immediately following the heading sibling is the quote.
      // Walk forward from the anchor until we hit a blockquote.
      let el = anchor.parentElement ? anchor.parentElement.nextElementSibling : null;
      let quote = null;
      for (let i = 0; i < 10 && el; i++) {
        if (el.tagName === 'BLOCKQUOTE') {
          quote = el.textContent.trim();
          break;
        }
        el = el.nextElementSibling;
      }
      if (!quote) {
        // fallback: grab the nearest blockquote after this anchor in DOM order
        const section = anchor.closest('section, div, main') || doc.body;
        const bqs = section.querySelectorAll('blockquote');
        // find the first one after this anchor
        let found = false;
        bqs.forEach(function (bq) {
          if (!found && anchor.compareDocumentPosition(bq) & Node.DOCUMENT_POSITION_FOLLOWING) {
            quote = bq.textContent.trim();
            found = true;
          }
        });
      }
      if (quote) {
        const nums = extractNumerics(quote);
        allNumericsForPaper.push(...nums);
        findings[num] = { quote, numerics: nums };
      }
    });

    return { findings, allNumericsForPaper };
  }

  /* ── distractor generation ───────────────────────────────────── */
  function generateDistractors(correct, allNumerics) {
    const isPercent = correct.endsWith('%');
    const base = parseFloat(correct);

    const candidates = new Set();

    // Pull from other numerics in the same paper
    allNumerics.forEach(function (n) {
      if (n !== correct) candidates.add(n);
    });

    // Pad with arithmetic variants if needed
    const variants = [
      (base * 1.1).toFixed(correct.includes('.') ? 1 : 0) + (isPercent ? '%' : ''),
      (base * 0.9).toFixed(correct.includes('.') ? 1 : 0) + (isPercent ? '%' : ''),
      (base * 1.2).toFixed(correct.includes('.') ? 1 : 0) + (isPercent ? '%' : ''),
      (base * 0.8).toFixed(correct.includes('.') ? 1 : 0) + (isPercent ? '%' : ''),
      String(Math.round(base) + 1) + (isPercent ? '%' : ''),
      String(Math.round(base) - 1) + (isPercent ? '%' : ''),
      String(Math.round(base * 2)) + (isPercent ? '%' : ''),
      String(Math.round(base / 2)) + (isPercent ? '%' : ''),
    ];
    variants.forEach(function (v) {
      if (v !== correct && parseFloat(v) > 0) candidates.add(v);
    });

    // Remove any that match the correct answer (string or numeric equality)
    const filtered = Array.from(candidates).filter(function (d) {
      return d !== correct && parseFloat(d) !== base;
    });

    // Shuffle and take first 3
    const shuffled = shuffle(filtered);
    return shuffled.slice(0, 3);
  }

  /* ── question building ───────────────────────────────────────── */
  function buildQuestion(citation, findingData, allNumerics) {
    const data = findingData.findings[citation.findingNum];
    if (!data || !data.numerics.length) return null;

    const quote = data.quote;
    const nums = data.numerics;

    // Pick the most "interesting" numeric — prefer percentages, else largest
    let correct = nums[0];
    const pct = nums.find(function (n) { return n.endsWith('%'); });
    if (pct) correct = pct;

    const distractors = generateDistractors(correct, allNumerics);
    if (distractors.length < 3) return null; // not enough distinct distractors

    // Build the blank version of the quote (replace first occurrence of correct)
    const blankedQuote = quote.replace(correct, '___');

    const choices = shuffle([correct].concat(distractors.slice(0, 3)));
    const labels = ['A', 'B', 'C', 'D'];
    const correctLabel = labels[choices.indexOf(correct)];

    return {
      blanked: blankedQuote,
      choices,
      labels,
      correct,
      correctLabel,
      quote,
      href: citation.href,
      findingNum: citation.findingNum,
    };
  }

  /* ── rendering ───────────────────────────────────────────────── */
  function renderQuestion(q, idx) {
    const qId = 'wq-' + idx;
    const section = document.createElement('div');
    section.className = 'wq-question';
    section.setAttribute('role', 'group');
    section.setAttribute('aria-labelledby', qId + '-heading');

    const heading = document.createElement('p');
    heading.className = 'wq-heading';
    heading.id = qId + '-heading';
    heading.textContent = 'Question ' + (idx + 1);
    section.appendChild(heading);

    const prompt = document.createElement('p');
    prompt.className = 'wq-prompt';
    prompt.textContent = q.blanked;
    section.appendChild(prompt);

    const choicesDiv = document.createElement('div');
    choicesDiv.className = 'wq-choices';
    choicesDiv.setAttribute('role', 'radiogroup');
    choicesDiv.setAttribute('aria-describedby', qId + '-heading');

    const radioName = qId + '-choice';
    q.choices.forEach(function (choice, i) {
      const label = document.createElement('label');
      label.className = 'wq-choice';
      const input = document.createElement('input');
      input.type = 'radio';
      input.name = radioName;
      input.value = choice;
      input.setAttribute('aria-label', q.labels[i] + ': ' + choice);
      label.appendChild(input);
      label.appendChild(document.createTextNode(' ' + q.labels[i] + '. ' + choice));
      choicesDiv.appendChild(label);
    });
    section.appendChild(choicesDiv);

    // Check answer button
    const checkBtn = document.createElement('button');
    checkBtn.type = 'button';
    checkBtn.className = 'wq-check-btn';
    checkBtn.textContent = 'Check answer';
    checkBtn.setAttribute('aria-controls', qId + '-answer');
    section.appendChild(checkBtn);

    // Answer reveal
    const answerDiv = document.createElement('div');
    answerDiv.className = 'wq-answer';
    answerDiv.id = qId + '-answer';
    answerDiv.setAttribute('aria-live', 'polite');
    section.appendChild(answerDiv);

    // Wire up check button
    checkBtn.addEventListener('click', function () {
      const selected = choicesDiv.querySelector('input[type="radio"]:checked');
      if (!selected) {
        answerDiv.textContent = 'Please select an answer first.';
        answerDiv.classList.add('show');
        return;
      }

      // Disable all radios
      choicesDiv.querySelectorAll('input[type="radio"]').forEach(function (r) {
        r.disabled = true;
      });
      checkBtn.disabled = true;

      const isCorrect = selected.value === q.correct;

      // Mark choices
      choicesDiv.querySelectorAll('label').forEach(function (lbl) {
        const inp = lbl.querySelector('input');
        if (inp.value === q.correct) {
          lbl.classList.add('wq-correct');
        } else if (inp.checked) {
          lbl.classList.add('wq-wrong');
        }
      });

      // Show answer reveal
      answerDiv.innerHTML = '';
      const verdict = document.createElement('strong');
      verdict.textContent = isCorrect ? 'Correct! ' : 'Not quite. ';
      answerDiv.appendChild(verdict);

      const answerText = document.createTextNode(
        'The answer is ' + q.correct + '. '
      );
      answerDiv.appendChild(answerText);

      const sourceLabel = document.createTextNode('Source: ');
      answerDiv.appendChild(sourceLabel);

      const sourceLink = document.createElement('a');
      sourceLink.href = q.href;
      sourceLink.textContent = 'Finding ' + q.findingNum;
      sourceLink.setAttribute('aria-label', 'See Finding ' + q.findingNum + ' (opens paper page)');
      answerDiv.appendChild(sourceLink);

      const quoteP = document.createElement('p');
      quoteP.className = 'wq-verbatim';
      quoteP.textContent = '\u201c' + q.quote + '\u201d';
      answerDiv.appendChild(quoteP);

      answerDiv.classList.add('show');
    });

    return section;
  }

  function renderQuiz(questions) {
    // Remove existing quiz section if present (for reset)
    const existing = document.getElementById('wiki-quiz-section');
    if (existing) existing.remove();

    const section = document.createElement('section');
    section.className = 'wiki-quiz';
    section.id = 'wiki-quiz-section';
    section.setAttribute('aria-label', 'Self-test quiz');

    if (!questions.length) {
      const msg = document.createElement('p');
      msg.className = 'wq-empty';
      msg.textContent =
        'Not enough citations on this page to generate quiz questions.';
      section.appendChild(msg);
      ctaContainer.after(section);
      return;
    }

    const header = document.createElement('h2');
    header.textContent = 'Test yourself';
    section.appendChild(header);

    questions.forEach(function (q, i) {
      section.appendChild(renderQuestion(q, i));
    });

    // Reset button
    const resetBtn = document.createElement('button');
    resetBtn.type = 'button';
    resetBtn.className = 'wiki-quiz-cta wq-reset-btn';
    resetBtn.textContent = 'Re-roll questions';
    resetBtn.setAttribute('aria-label', 'Generate a new question set');
    resetBtn.addEventListener('click', function () {
      runQuiz();
    });
    section.appendChild(resetBtn);

    ctaContainer.after(section);
  }

  /* ── CTA injection ───────────────────────────────────────────── */
  let ctaContainer;

  function injectCTA() {
    ctaContainer = document.createElement('div');
    ctaContainer.className = 'wiki-quiz-cta-wrap';

    const quizBtn = document.createElement('button');
    quizBtn.type = 'button';
    quizBtn.id = 'wiki-quiz-trigger';
    quizBtn.className = 'wiki-quiz-cta';
    quizBtn.textContent = 'Test yourself on this page';
    quizBtn.setAttribute('aria-label', 'Generate a self-test quiz from this page');
    quizBtn.addEventListener('click', function () {
      runQuiz();
    });
    ctaContainer.appendChild(quizBtn);

    // Append before the last <hr> or tealc footer block, else at end of main
    const hrs = main.querySelectorAll('hr');
    const relatedHeading = main.querySelector(
      'h2#related-on-the-blackmon-lab-site, h2#read-the-paper, h2#supporting-evidence'
    );
    const insertBefore = relatedHeading
      ? relatedHeading.previousElementSibling || relatedHeading
      : hrs.length
      ? hrs[hrs.length - 1]
      : null;

    if (insertBefore && insertBefore.parentElement === main) {
      main.insertBefore(ctaContainer, insertBefore);
    } else {
      main.appendChild(ctaContainer);
    }
  }

  /* ── main quiz runner ────────────────────────────────────────── */
  async function runQuiz() {
    // Show loading state
    let existingSection = document.getElementById('wiki-quiz-section');
    if (existingSection) existingSection.remove();

    const loadingMsg = document.createElement('section');
    loadingMsg.className = 'wiki-quiz';
    loadingMsg.id = 'wiki-quiz-section';
    loadingMsg.innerHTML = '<p class="wq-loading">Loading quiz\u2026</p>';
    ctaContainer.after(loadingMsg);

    const citations = parseCitations();

    if (!citations.length) {
      loadingMsg.innerHTML =
        '<p class="wq-empty">Not enough citations on this page to generate quiz questions.</p>';
      return;
    }

    // Limit to 5 unique citations, shuffled
    const selectedCitations = shuffle(citations).slice(0, 5);

    // Group by paperSlug to batch fetches
    const byPaper = {};
    selectedCitations.forEach(function (c) {
      if (!byPaper[c.paperSlug]) byPaper[c.paperSlug] = [];
      byPaper[c.paperSlug].push(c);
    });

    // Fetch all paper data
    const paperDataMap = {};
    await Promise.all(
      Object.keys(byPaper).map(async function (slug) {
        paperDataMap[slug] = await loadFindingData(slug);
      })
    );

    // Build questions
    const questions = [];
    selectedCitations.forEach(function (citation) {
      const paperData = paperDataMap[citation.paperSlug];
      if (!paperData) return;
      const q = buildQuestion(citation, paperData, paperData.allNumericsForPaper);
      if (q) questions.push(q);
    });

    // Limit to 3-5 questions
    const finalQuestions = questions.slice(0, 5);
    renderQuiz(finalQuestions);
  }

  /* ── boot ────────────────────────────────────────────────────── */
  function init() {
    injectCTA();
    if (/[?&]quiz=1/.test(location.search)) {
      runQuiz();
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
