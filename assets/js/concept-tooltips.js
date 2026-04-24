/* concept-tooltips.js — Blackmon Lab wiki concept link scanner + hover tooltips.
 *
 * Scope: runs only on body.wiki pages inside /knowledge/ paths.
 * On first run it fetches /knowledge/data/concepts.json (cached in sessionStorage
 * under "wiki:concepts"), scans the first occurrence of each concept alias in
 * visible text nodes inside main.column, wraps it in <a class="concept-link">,
 * and renders a 350px-wide hover/focus tooltip.
 *
 * Exclusion rules (never wrap text inside):
 *   - elements with [data-no-concept-tooltips]
 *   - <a>, <code>, <pre>, <h1>, <h2>, <h3> and their descendants
 *   - the tooltip itself
 */
(function () {
  "use strict";

  /* ---- Guard: only run on wiki pages under /knowledge/ ---- */
  if (
    !document.body.classList.contains("wiki") ||
    !window.location.pathname.startsWith("/knowledge/")
  ) {
    return;
  }

  /* ---- Constants ---- */
  var CACHE_KEY = "wiki:concepts";
  var DATA_URL = "/knowledge/data/concepts.json";
  var TOOLTIP_ID = "concept-tooltip-singleton";
  var EXCLUDED_TAGS = new Set(["A", "CODE", "PRE", "H1", "H2", "H3"]);

  /* ---- Helpers ---- */

  function escapeRegex(str) {
    return str.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  }

  function isExcluded(node) {
    var el = node.nodeType === 3 ? node.parentElement : node;
    while (el && el !== document.body) {
      if (EXCLUDED_TAGS.has(el.tagName)) return true;
      if (el.hasAttribute("data-no-concept-tooltips")) return true;
      if (el.id === TOOLTIP_ID) return true;
      if (
        el.classList &&
        (el.classList.contains("concept-link") ||
          el.classList.contains("concept-tooltip"))
      )
        return true;
      el = el.parentElement;
    }
    return false;
  }

  /* ---- Tooltip DOM ---- */

  function createTooltipEl() {
    var el = document.createElement("div");
    el.id = TOOLTIP_ID;
    el.className = "concept-tooltip";
    el.setAttribute("role", "tooltip");
    el.style.display = "none";
    el.style.position = "absolute";
    document.body.appendChild(el);
    return el;
  }

  function renderTooltip(concept) {
    return (
      '<div class="ct-title">' +
      escapeHtml(concept.title) +
      "</div>" +
      '<div class="ct-def">' +
      escapeHtml(stripMarkdown(concept.definition)) +
      "</div>" +
      '<div class="ct-analogy">' +
      escapeHtml(stripMarkdown(concept.analogy)) +
      "</div>" +
      '<a class="ct-link" href="' +
      escapeHtml(concept.url) +
      '">Read the full card \u2192</a>'
    );
  }

  function escapeHtml(str) {
    return str
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;");
  }

  function stripMarkdown(str) {
    /* Remove *italic*, **bold**, and backtick markers for tooltip display */
    return str
      .replace(/\*\*(.+?)\*\*/g, "$1")
      .replace(/\*(.+?)\*/g, "$1")
      .replace(/`(.+?)`/g, "$1");
  }

  /* ---- Smart positioning ---- */

  function positionTooltip(tooltip, anchor) {
    var rect = anchor.getBoundingClientRect();
    var scrollX = window.scrollX || window.pageXOffset || 0;
    var scrollY = window.scrollY || window.pageYOffset || 0;
    var tipH = tooltip.offsetHeight || 160;
    var tipW = tooltip.offsetWidth || 350;
    var viewH = window.innerHeight;
    var viewW = window.innerWidth;

    /* prefer above if room, else below */
    var top;
    if (rect.top - tipH - 8 > 0) {
      top = rect.top + scrollY - tipH - 8;
    } else {
      top = rect.bottom + scrollY + 8;
    }

    /* horizontal: align left edge to anchor, clamped to viewport */
    var left = rect.left + scrollX;
    if (left + tipW > scrollX + viewW - 12) {
      left = scrollX + viewW - tipW - 12;
    }
    if (left < scrollX + 8) {
      left = scrollX + 8;
    }

    tooltip.style.top = top + "px";
    tooltip.style.left = left + "px";
  }

  /* ---- Text-node walking and wrapping ---- */

  function walkTextNodes(root, callback) {
    var walker = document.createTreeWalker(
      root,
      NodeFilter.SHOW_TEXT,
      {
        acceptNode: function (node) {
          if (!node.textContent.trim()) return NodeFilter.FILTER_REJECT;
          if (isExcluded(node)) return NodeFilter.FILTER_REJECT;
          return NodeFilter.FILTER_ACCEPT;
        },
      },
      false
    );
    var node;
    var nodes = [];
    while ((node = walker.nextNode())) {
      nodes.push(node);
    }
    nodes.forEach(callback);
  }

  function wrapFirstOccurrence(textNode, regex, concept) {
    var text = textNode.textContent;
    var match = regex.exec(text);
    if (!match) return false;

    var before = text.slice(0, match.index);
    var matched = match[0];
    var after = text.slice(match.index + matched.length);

    var frag = document.createDocumentFragment();
    if (before) frag.appendChild(document.createTextNode(before));

    var a = document.createElement("a");
    a.className = "concept-link";
    a.href = concept.url;
    a.setAttribute("data-concept-slug", concept.slug);
    a.setAttribute("aria-describedby", TOOLTIP_ID);
    a.textContent = matched;
    frag.appendChild(a);

    if (after) frag.appendChild(document.createTextNode(after));

    textNode.parentNode.replaceChild(frag, textNode);
    return true;
  }

  /* ---- Main scanning pass ---- */

  function scanAndWrap(concepts) {
    var container = document.querySelector("main.column");
    if (!container) return;

    concepts.forEach(function (concept) {
      if (!concept.aliases || concept.aliases.length === 0) return;

      /* Build a word-boundary regex from all aliases, longest first */
      var sorted = concept.aliases.slice().sort(function (a, b) {
        return b.length - a.length;
      });
      var pattern = sorted.map(escapeRegex).join("|");
      var re = new RegExp("\\b(" + pattern + ")\\b", "i");

      /* Collect text nodes freshly for each concept (DOM may have changed) */
      var wrapped = false;
      walkTextNodes(container, function (node) {
        if (wrapped) return;
        if (re.test(node.textContent)) {
          if (wrapFirstOccurrence(node, re, concept)) {
            wrapped = true;
          }
        }
      });
    });
  }

  /* ---- Tooltip show / hide logic ---- */

  function initTooltips(concepts) {
    /* Build a slug→concept lookup */
    var bySlug = {};
    concepts.forEach(function (c) {
      bySlug[c.slug] = c;
    });

    var tooltip = document.getElementById(TOOLTIP_ID) || createTooltipEl();
    var activeAnchor = null;
    var hideTimeout = null;

    function show(anchor) {
      var slug = anchor.getAttribute("data-concept-slug");
      var concept = bySlug[slug];
      if (!concept) return;
      clearTimeout(hideTimeout);
      tooltip.innerHTML = renderTooltip(concept);
      tooltip.style.display = "block";
      /* position after display so offsetHeight is correct */
      positionTooltip(tooltip, anchor);
      activeAnchor = anchor;
    }

    function hide() {
      hideTimeout = setTimeout(function () {
        tooltip.style.display = "none";
        activeAnchor = null;
      }, 150);
    }

    function keepOpen() {
      clearTimeout(hideTimeout);
    }

    /* delegate events on document — links are injected after DOMContentLoaded */
    document.addEventListener("mouseover", function (e) {
      var target = e.target;
      if (target && target.classList && target.classList.contains("concept-link")) {
        show(target);
      }
    });

    document.addEventListener("mouseout", function (e) {
      var target = e.target;
      if (target && target.classList && target.classList.contains("concept-link")) {
        hide();
      }
    });

    document.addEventListener("focusin", function (e) {
      var target = e.target;
      if (target && target.classList && target.classList.contains("concept-link")) {
        show(target);
      }
    });

    document.addEventListener("focusout", function (e) {
      var target = e.target;
      if (target && target.classList && target.classList.contains("concept-link")) {
        hide();
      }
    });

    tooltip.addEventListener("mouseover", keepOpen);
    tooltip.addEventListener("mouseout", hide);

    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape" && tooltip.style.display !== "none") {
        tooltip.style.display = "none";
        activeAnchor = null;
      }
    });
  }

  /* ---- Data fetching with sessionStorage cache ---- */

  function loadConcepts(callback) {
    var cached = null;
    try {
      var raw = sessionStorage.getItem(CACHE_KEY);
      if (raw) cached = JSON.parse(raw);
    } catch (e) {
      /* ignore storage errors */
    }

    if (cached && Array.isArray(cached)) {
      callback(cached);
      return;
    }

    fetch(DATA_URL)
      .then(function (r) {
        if (!r.ok) throw new Error("HTTP " + r.status);
        return r.json();
      })
      .then(function (data) {
        var concepts = (data && data.concepts) || [];
        try {
          sessionStorage.setItem(CACHE_KEY, JSON.stringify(concepts));
        } catch (e) {
          /* ignore storage full */
        }
        callback(concepts);
      })
      .catch(function (err) {
        console.warn("[concept-tooltips] failed to load concepts:", err);
      });
  }

  /* ---- Entry point ---- */

  function init() {
    loadConcepts(function (concepts) {
      if (!concepts.length) return;
      scanAndWrap(concepts);
      initTooltips(concepts);
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
