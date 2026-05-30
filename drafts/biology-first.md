# Working draft — "The biology comes first"

Two pages: a short manifesto (front door), and a longer companion (workflow + risks + how this fits in the lab). Mark anything up — cross out, rewrite in line, leave notes in brackets. We'll move to HTML once you're happy with the prose.

Audience priority: funders/donors, PIs, undergrads. Tone: respectful of the pre-LLM era — the old way was right for the time it existed in.

---

## Draft 1 — The manifesto (short page)

**Title:** The biology comes first.

A research lab's job is to do biology. For decades, the path to undergraduate research ran through tool acquisition — a year or more of R, statistics, file wrangling, bioinformatics — before a student could touch a real question. That was the right path for the time it existed in. The tools didn't run themselves.

LLMs change which step is the bottleneck.

In our lab, undergraduate research now starts where it should have started all along: with the organism, the system, the question. *What's strange about this animal? What does the literature skip? What would we love to know?* No code, no laptop. Biology first.

Once the question is sharp, the LLM enters as a working colleague — given the problem, asked to propose an approach, told to write the code and run the analysis. The student and the PI stay in the seat that matters: pushing back on the plan, sanity-checking the result, asking what the counterfactual is, asking whether the answer makes biological sense.

This is a shift in roles, not a new piece of software:

- **The student** is a biologist and a critic, not a coder-in-training. Their currency is curiosity and the willingness to say "wait — that doesn't make sense."
- **The PI** is a scientific judgment partner, not a tool instructor. Mentoring shifts from "here's how to write a for-loop" to "here's why this analysis is the wrong shape for this question."
- **The LLM** is the executor — fast, tireless, frequently wrong, never the final word.

Undergraduates in our lab now reach real biological questions in their first semester instead of their senior year. They graduate with the skill that actually transfers — *judgment* — and they leave behind a trail of work that gets published.

We think this is the future of undergraduate research. We're betting our lab on it.

— Heath

[Read more about how we do it →]

*(~320 words. Designed to fit on one screen.)*

---

## Draft 2 — The deeper page

**Title:** How we do it. *(alt: "The biology comes first — in practice.")*

This is the longer companion to "The biology comes first." Below: the workflow we run with undergraduates, the failure modes the workflow is designed to defend against, and where this fits in the lab's courses and tools.

### The workflow

1. **Question first.** Whiteboard or paper, no laptop. What's interesting about this organism, system, or dataset? What would the answer look like? What would refute it? If you can't articulate refutation, you don't have a question yet.
2. **What would convince us?** Pin down the data and the pattern. "We'd be convinced by X. We'd give it up if we saw Y." Skip this and you'll let the LLM smuggle the answer into the question.
3. **Brief the LLM.** Hand over the question, the data shape, and the pass/fail criteria. The LLM is now your collaborator — not your tutor.
4. **Interrogate the plan.** Before any code runs, the student and PI grill the proposal. *Why this test? What's the assumption set? What breaks it? What's the simplest alternative?* This is where teaching happens. The PI's job is to ask harder questions than the LLM asks itself.
5. **Let it execute.** Code, data fetching, plots, model fits. Speed up — this part is no longer the bottleneck.
6. **Sanity check the output.** Does the effect size make biological sense? Are the units right? Does a different look at the same data tell the same story?
7. **Counterfactual round.** What is the analysis that would have made us conclude the opposite? Did we run it? If we didn't, why not?
8. **Student writes the draft.** Writing is where you find out whether you actually understood it.

### What can go wrong

The workflow defends against four real failure modes:

- **The credulous student.** A student who lets the LLM think for them comes out worse than a student who never used one. The discussion step is the whole game.
- **Hallucinated methods.** LLMs will confidently propose tests that don't exist, citations that aren't real, and packages that won't run. Verification is a primary skill, not an afterthought.
- **Plausible-but-wrong.** "Looks reasonable" is not the same as "is correct." Step 7 exists to defend against this.
- **Misplaced authorship.** The student and the PI own the conclusions. The LLM is a tool. We are not handing biology over to a model — we are handing it back to biologists.

### Where this lives in the lab

- **BIOL 683 — Experimental Design in Biology** trains students in vibe coding and the workflow above.
- **BIOL 498 — AI-Enabled Research** runs projects under this framework.
- **Tealc** is the in-house agent harness we use to run lab-scale work this way.
- **Prompting guide** is the practical companion for working with an LLM.
- **The lab's AI work** sets the wider context.

### For PIs reading this

The hardest adjustment isn't technical. It's accepting that a 19-year-old can do publishable work in their first semester if you let them — provided the lab takes the role of judgment partner seriously and refuses to settle for "the LLM said so." If the discussion is rigorous, the timeline collapses. If it isn't, you've just built a faster way to be wrong.

— Heath

*(~600 words.)*

---

## Open calls (for Heath)

1. **Filenames** — proposing `biology-first.html` (manifesto) and `biology-first-in-practice.html` (deeper). Open to alternatives.
2. **Where to link from** — `index.html`, `research.html`, `join.html`. Confirm or override.
3. **Gut-check one claim** — "leave behind a trail of work that gets published." Keep, soften ("a trail of work"), or replace with something specific (paper count, CURE outcomes)?
4. **Open with outcomes (funder-first) or with philosophy?** Current draft leads with philosophy. Funder-first version would open with "More biology, faster — that's the point."
