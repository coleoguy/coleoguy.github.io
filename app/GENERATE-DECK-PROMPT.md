# BioDesk Deck Generator Prompt
# Copy everything below the line and paste into Claude, then paste your source material

---

You are generating a study deck JSON file for BioDesk, an evidence-based learning app used by university students. Your output must be valid, parseable JSON — nothing else. No explanation, no markdown fences, no commentary. Just the raw JSON object.

## Card Type Rules

Generate cards in this exact ratio:
- **50% flashcard** — direct recall of definitions, concepts, mechanisms
- **30% fitb** — fill-in-the-blank targeting key terms, relationships, quantitative values
- **20% mcq** — multiple choice with one clearly correct answer and a substantive explanation

Aim for **15–25 cards total** unless the source material is very thin (minimum 10) or very rich (maximum 40).

## JSON Schema

```json
{
  "deck": {
    "title": "Short descriptive title",
    "source": "Author Year or textbook chapter",
    "posted": "YYYY-MM-DD",
    "points": 10
  },
  "cards": [
    {
      "type": "flashcard",
      "front": "The question or prompt on the front of the card",
      "back": "The complete answer — 1 to 3 sentences, enough for a student to self-evaluate"
    },
    {
      "type": "fitb",
      "prompt": "A sentence with exactly one blank represented by ______.",
      "answer": "the exact missing term",
      "alternates": ["acceptable variant 1", "acceptable variant 2"]
    },
    {
      "type": "mcq",
      "question": "A question with one definitively correct answer",
      "options": [
        "Correct answer here",
        "Plausible distractor",
        "Plausible distractor",
        "Plausible distractor"
      ],
      "correct": 0,
      "explanation": "2–4 sentences explaining WHY the correct answer is right and what is wrong or incomplete about the distractors. This is the most important learning moment."
    }
  ]
}
```

## Quality Rules

**Flashcards:**
- Front should ask one clear question — not a statement
- Back should be complete enough that a student can judge whether they knew it
- Avoid yes/no fronts; ask "what", "how", "why", "what is the significance of"

**Fill-in-the-blank:**
- The blank must be a single key term or short phrase (1–4 words)
- The sentence must be meaningful without the blank — not trivially guessable from grammar
- Include 1–3 alternates that capture spelling variants or synonym answers students might legitimately give
- Use exactly one blank per card, represented as ______

**Multiple choice:**
- Correct answer must always be index 0 in the options array (the app randomizes display order)
- All four options should be plausible — no obviously wrong answers
- The explanation should teach, not just confirm — explain the mechanism or principle
- Avoid "all of the above" and "none of the above"

**All cards:**
- Write at the level of an advanced undergraduate or first-year graduate student
- Use precise scientific terminology from the source material
- Do not create cards about trivial facts — focus on concepts, mechanisms, relationships, and interpretations
- Each card should be self-contained — a student with no other context can understand what is being asked

## Source Material

Paste your source material below. This can be a paper abstract + methods, a textbook section, lecture notes, or any primary source. The more complete the material, the better the deck.

[PASTE SOURCE MATERIAL HERE]

---
Output only the raw JSON. Begin your response with { and end with }
