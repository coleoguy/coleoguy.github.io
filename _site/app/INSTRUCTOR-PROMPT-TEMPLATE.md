# StudyDeck — Instructor Question-Generation Prompt

## How to use this

1. Open Claude (claude.ai) or ChatGPT
2. Paste the prompt below
3. Replace [PASTE YOUR PAPER/READING HERE] with the actual text
4. Replace [TOPIC NAME] and [SOURCE CITATION] with appropriate values
5. Copy the JSON output to a file (e.g., `deck-week3.json`)
6. Upload to your GitHub Pages repo
7. Add the file URL to your `class.json` manifest

---

## The Prompt (copy everything between the lines)

---

You are generating a StudyDeck question file for a university course. StudyDeck is an evidence-based mobile study app grounded in cognitive science research — specifically the testing effect, generation effect, spaced repetition, and interleaving.

Your task is to read the provided text and generate a JSON question file in the exact format below.

**Pedagogical requirements:**
- Prioritize FLASHCARD and FITB question types — they produce stronger learning than MCQ
- Aim for roughly 50% flashcard, 30% fitb, 20% mcq
- Include a mix of: definition questions ("What is X"), mechanistic questions ("Why does X happen"), comparison questions ("How does X differ from Y"), and application questions ("When would you use X instead of Y")
- For FITB: the blank should require a specific term or short phrase. Always include a hint.
- For MCQ: all four options must be plausible (no obviously wrong choices). Always include an explanation that addresses why the correct answer is right AND briefly why the distractors are wrong.
- Write questions at the level of a graduate student in evolutionary biology.
- Aim for 10-15 cards total per deck.

**JSON format — follow this exactly:**

```json
{
  "deck": {
    "title": "[TOPIC NAME]",
    "source": "[SOURCE CITATION]",
    "posted": "[TODAY'S DATE IN YYYY-MM-DD]",
    "points": 10
  },
  "cards": [
    {
      "type": "flashcard",
      "front": "Question text here",
      "back": "Answer text here — complete and self-contained, 1-3 sentences"
    },
    {
      "type": "fitb",
      "question": "Sentence with a ___ where the answer goes",
      "answer": "the exact word or short phrase",
      "hint": "A helpful clue without giving away the answer"
    },
    {
      "type": "mcq",
      "question": "Question text here",
      "options": ["Option A", "Option B", "Option C", "Option D"],
      "correct": 0,
      "explanation": "Option A is correct because... Options B, C, and D are wrong because..."
    }
  ]
}
```

**Rules:**
- Output valid JSON only — no markdown fences, no commentary outside the JSON
- The "correct" field in MCQ is the zero-based index of the correct option (0=A, 1=B, 2=C, 3=D)
- Interleave the card types in the array — do not group all flashcards together, then all fitb, etc.
- Every answer must be complete and accurate on its own — a student should be able to learn the concept from the answer alone

Here is the text to convert:

[PASTE YOUR PAPER/READING HERE]

---

## Hosting your files (recommended: GitHub Pages)

1. Create a free GitHub account at github.com
2. Create a new repository, enable GitHub Pages in Settings → Pages
3. Upload your deck JSON files and your class.json manifest
4. Your files will be at: `https://YOUR-USERNAME.github.io/YOUR-REPO/filename.json`
5. GitHub Pages has CORS enabled by default — StudyDeck will fetch your files without issues

## Updating your class

When you post a new deck:
1. Add the new deck's URL to your `class.json` manifest in the `decks` array
2. Students tap "Refresh" in the app — the new deck appears automatically
3. You do not need to share a new URL with students

## Verification codes

When a student completes a deck, the app shows them an 8-character verification code.
The code is generated from: student name + deck key + date + points.
Have students submit this code to you via Canvas, a Google Form, or email.
To verify a code is genuine, just check that it matches what you'd expect for that student on that date.
(A future version of the app will include a web-based verifier tool.)
