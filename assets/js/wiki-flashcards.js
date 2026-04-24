/* Blackmon Lab — Anki flashcard export (V5)
 *
 * Runs only on body.wiki pages.
 * Activates via ?flashcards=1 in URL or a "Download as Anki flashcards" button.
 * Reads /knowledge/data/concepts.json, filters by current topic slug,
 * and generates a tab-separated .txt file for Anki import.
 * Zero LLM calls, zero server dependencies.
 */
(function wikiFlashcards() {
  'use strict';

  /* ── guards ─────────────────────────────────────────────────── */
  if (!document.body.classList.contains('wiki')) return;

  const main = document.getElementById('content');
  if (!main) return;

  /* ── topic slug from URL ─────────────────────────────────────── */
  function getTopicSlug() {
    // /knowledge/topics/<slug>/  → slug
    const m = location.pathname.match(/\/knowledge\/topics\/([^/]+)\/?$/);
    return m ? m[1] : null;
  }

  /* ── fetch concepts.json ─────────────────────────────────────── */
  let conceptsCache = null;

  async function loadConcepts() {
    if (conceptsCache !== null) return conceptsCache;
    try {
      const resp = await fetch('/knowledge/data/concepts.json');
      if (!resp.ok) return [];
      conceptsCache = await resp.json();
      return conceptsCache;
    } catch (e) {
      return [];
    }
  }

  /* ── filter concepts for this page ──────────────────────────── */
  function filterConcepts(concepts, topicSlug) {
    if (!concepts || !concepts.length) return [];

    if (topicSlug) {
      // Primary: filter by appears_in_topics
      const byTopic = concepts.filter(function (c) {
        return (
          Array.isArray(c.appears_in_topics) &&
          c.appears_in_topics.some(function (t) {
            // match either exact slug or slug with hyphens/underscores interchanged
            return t === topicSlug || t.replace(/-/g, '_') === topicSlug.replace(/-/g, '_');
          })
        );
      });
      if (byTopic.length) return byTopic;
    }

    // Fallback: filter by concepts whose permalink is linked from this page
    const linked = new Set();
    main.querySelectorAll('a[href*="/knowledge/concepts/"]').forEach(function (a) {
      const m = a.getAttribute('href').match(/\/knowledge\/concepts\/([^/]+)\/?/);
      if (m) linked.add(m[1]);
    });
    if (linked.size) {
      return concepts.filter(function (c) {
        return linked.has(c.concept_slug) || linked.has(c.slug);
      });
    }

    return [];
  }

  /* ── generate TSV content ────────────────────────────────────── */
  function buildTSV(concepts) {
    const lines = ['Front\tBack'];
    concepts.forEach(function (c) {
      const front = buildFront(c);
      const back = buildBack(c);
      if (front && back) {
        // Escape tabs and newlines inside fields
        const f = front.replace(/\t/g, ' ').replace(/\r?\n/g, ' ');
        const b = back.replace(/\t/g, ' ').replace(/\r?\n/g, ' ');
        lines.push(f + '\t' + b);
      }
    });
    return lines.join('\n');
  }

  function buildFront(concept) {
    const name = concept.title || concept.name || concept.concept_slug;
    if (!name) return null;
    return 'What is ' + name.toLowerCase() + '?';
  }

  function buildBack(concept) {
    // Prefer one_sentence_definition, then summary, then definition
    const def =
      concept.one_sentence_definition ||
      concept.definition ||
      concept.summary ||
      concept.description ||
      '';

    const analogy =
      concept.one_sentence_analogy || concept.analogy || '';

    let back = def.trim();
    if (analogy) {
      back += ' (Analogy: ' + analogy.trim() + ')';
    }
    return back || null;
  }

  /* ── download trigger ────────────────────────────────────────── */
  function triggerDownload(tsv, topicSlug) {
    const filename =
      'blackmon-lab-' + (topicSlug || 'wiki') + '-flashcards.txt';

    // Use data URI with base64 to handle Unicode cleanly
    const bytes = new TextEncoder().encode(tsv);
    let binary = '';
    bytes.forEach(function (b) { binary += String.fromCharCode(b); });
    const b64 = btoa(binary);
    const uri = 'data:text/plain;charset=utf-8;base64,' + b64;

    const a = document.createElement('a');
    a.href = uri;
    a.download = filename;
    a.style.display = 'none';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);

    return filename;
  }

  /* ── toast ───────────────────────────────────────────────────── */
  function showToast(message) {
    // Remove any existing toast
    const old = document.getElementById('flashcard-toast');
    if (old) old.remove();

    const toast = document.createElement('div');
    toast.className = 'flashcard-toast';
    toast.id = 'flashcard-toast';
    toast.setAttribute('role', 'status');
    toast.setAttribute('aria-live', 'polite');
    toast.textContent = message;
    document.body.appendChild(toast);

    // Force reflow so transition fires
    toast.getBoundingClientRect();
    toast.classList.add('show');

    setTimeout(function () {
      toast.classList.remove('show');
      setTimeout(function () { toast.remove(); }, 400);
    }, 4000);
  }

  /* ── main export runner ──────────────────────────────────────── */
  async function runExport() {
    const btn = document.getElementById('flashcard-trigger');
    if (btn) {
      btn.disabled = true;
      btn.textContent = 'Preparing\u2026';
    }

    const concepts = await loadConcepts();
    const topicSlug = getTopicSlug();
    const filtered = filterConcepts(concepts, topicSlug);

    if (btn) {
      btn.disabled = false;
      btn.textContent = 'Download as Anki flashcards';
    }

    if (!filtered.length) {
      showToast(
        'No flashcards found for this topic. Try visiting a concept page directly.'
      );
      return;
    }

    const tsv = buildTSV(filtered);
    const cardCount = tsv.split('\n').length - 1; // subtract header
    const filename = triggerDownload(tsv, topicSlug);

    showToast(
      cardCount +
        ' flashcard' +
        (cardCount === 1 ? '' : 's') +
        ' downloaded \u2192 import into Anki via File \u2192 Import'
    );
  }

  /* ── CTA injection ───────────────────────────────────────────── */
  function injectCTA() {
    // Find the quiz CTA container if already present (injected by wiki-quiz.js),
    // else create our own container and insert it in the same spot.
    const quizWrap = document.querySelector('.wiki-quiz-cta-wrap');

    const btn = document.createElement('button');
    btn.type = 'button';
    btn.id = 'flashcard-trigger';
    btn.className = 'flashcard-cta';
    btn.textContent = 'Download as Anki flashcards';
    btn.setAttribute('aria-label', 'Download Anki flashcard deck for this topic');
    btn.addEventListener('click', runExport);

    if (quizWrap) {
      quizWrap.appendChild(btn);
    } else {
      // Create a standalone container at end of main content
      const wrap = document.createElement('div');
      wrap.className = 'wiki-quiz-cta-wrap';
      wrap.appendChild(btn);

      const hrs = main.querySelectorAll('hr');
      const relatedHeading = main.querySelector(
        'h2#related-on-the-blackmon-lab-site, h2#read-the-paper'
      );
      const insertBefore = relatedHeading
        ? relatedHeading.previousElementSibling || relatedHeading
        : hrs.length
        ? hrs[hrs.length - 1]
        : null;

      if (insertBefore && insertBefore.parentElement === main) {
        main.insertBefore(wrap, insertBefore);
      } else {
        main.appendChild(wrap);
      }
    }
  }

  /* ── boot ────────────────────────────────────────────────────── */
  function init() {
    injectCTA();
    if (/[?&]flashcards=1/.test(location.search)) {
      runExport();
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
