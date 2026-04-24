#!/usr/bin/env python3
"""
build_concepts_json.py — Regenerate knowledge/data/concepts.json from concept card frontmatter.

Usage:
    python3 knowledge/data/build_concepts_json.py

Run from the repo root. Reads all knowledge/concepts/*.md files, extracts
frontmatter (YAML) and the first two **bold** lines inside the tealc:card-start
block (definition and analogy), and writes concepts.json.
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

# Repo root is two levels up from this file
REPO_ROOT = Path(__file__).resolve().parent.parent.parent
CONCEPTS_DIR = REPO_ROOT / "knowledge" / "concepts"
OUTPUT_PATH = REPO_ROOT / "knowledge" / "data" / "concepts.json"


def parse_frontmatter(text: str) -> dict:
    """Extract YAML frontmatter (between the first two '---' lines) as a dict.

    Returns empty dict if no frontmatter is found.
    Handles only simple scalar and list YAML values (no nested maps needed here).
    """
    if not text.startswith("---"):
        return {}
    end = text.find("\n---", 3)
    if end == -1:
        return {}
    yaml_block = text[3:end].strip()
    result: dict = {}
    # Parse line by line — handles scalars and bracket-style lists.
    for line in yaml_block.splitlines():
        if ":" not in line:
            continue
        key, _, raw_value = line.partition(":")
        key = key.strip()
        raw_value = raw_value.strip()
        if not key:
            continue
        # Strip inline comments
        if raw_value.startswith("["):
            # YAML inline list: [a, b, c]
            inner = raw_value.strip("[]")
            result[key] = [v.strip().strip('"').strip("'") for v in inner.split(",") if v.strip()]
        elif raw_value.startswith('"') or raw_value.startswith("'"):
            result[key] = raw_value.strip('"').strip("'")
        elif raw_value.lower() == "null":
            result[key] = None
        else:
            result[key] = raw_value
    return result


_BOLD_RE = re.compile(r"\*\*(.+?)\*\*\s+(.*)")


def extract_definition_and_analogy(text: str) -> tuple[str, str]:
    """Extract the definition and analogy sentences from inside tealc:card-start/end block.

    The convention is:
        **One-sentence definition.** <definition text>
        **One-sentence analogy.** <analogy text>

    Returns (definition, analogy) or ("", "") if not found.
    """
    # Find the card region
    card_start = text.find("<!-- tealc:card-start -->")
    card_end = text.find("<!-- tealc:card-end -->")
    if card_start == -1 or card_end == -1:
        return "", ""
    card_body = text[card_start:card_end]

    definition = ""
    analogy = ""
    for line in card_body.splitlines():
        line = line.strip()
        m = _BOLD_RE.match(line)
        if not m:
            continue
        label = m.group(1).lower()
        sentence = m.group(2).strip()
        if "definition" in label and not definition:
            definition = sentence
        elif "analogy" in label and not analogy:
            analogy = sentence
        if definition and analogy:
            break
    return definition, analogy


def process_card(path: Path) -> dict | None:
    """Parse a concept card file and return its JSON record, or None on error."""
    try:
        text = path.read_text(encoding="utf-8")
    except OSError as exc:
        print(f"  WARNING: could not read {path}: {exc}", file=sys.stderr)
        return None

    fm = parse_frontmatter(text)
    if not fm:
        print(f"  WARNING: no frontmatter in {path}", file=sys.stderr)
        return None

    slug = fm.get("concept_slug") or path.stem
    title = fm.get("title", slug)
    aliases = fm.get("aliases") or []
    if isinstance(aliases, str):
        aliases = [aliases]
    url = fm.get("permalink") or f"/knowledge/concepts/{slug}/"

    definition, analogy = extract_definition_and_analogy(text)

    return {
        "slug": slug,
        "title": title,
        "aliases": aliases,
        "definition": definition,
        "analogy": analogy,
        "url": url,
    }


def build(concepts_dir: Path = CONCEPTS_DIR, output_path: Path = OUTPUT_PATH) -> int:
    """Build the JSON index. Returns the number of concepts processed."""
    cards = sorted(concepts_dir.glob("*.md"))
    if not cards:
        print(f"ERROR: no .md files found in {concepts_dir}", file=sys.stderr)
        sys.exit(1)

    records = []
    for card_path in cards:
        record = process_card(card_path)
        if record:
            records.append(record)

    output = {"concepts": records}
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(json.dumps(output, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    return len(records)


if __name__ == "__main__":
    n = build()
    print(f"  ok: {n} concepts written to {OUTPUT_PATH.relative_to(REPO_ROOT)}")
