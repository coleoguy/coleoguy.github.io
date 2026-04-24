/* Blackmon Lab — click-to-edit local dev overlay.
 *
 * Only active when ?edit=1 is present in the URL AND the page is served from
 * localhost/127.0.0.1.  Entirely inert on production (GitHub Pages).
 *
 * Architecture:
 *   - Scans rendered DOM for HTML comment nodes marking region boundaries.
 *   - USER regions (<!-- user-start/end -->) get contenteditable wrappers.
 *   - TEALC regions (<!-- tealc:NAME-start/end -->) get propose-diff modals.
 *   - On save, fetches raw markdown via GET /raw, splices in the edited
 *     content, and POSTs via PATCH /file.
 *
 * Server: python3 -m wiki_tools.edit_server  (listens on 127.0.0.1:4711)
 */
(function () {
  'use strict';

  // ------------------------------------------------------------------
  // Keyboard toggle — ⌘⇧E (macOS) / Ctrl+Shift+E toggles ?edit=1 on the
  // current URL. Registered before the guards so it works on any page,
  // even when the overlay is otherwise inert. Harmless on prod: toggling
  // `?edit=1` on GitHub Pages just reloads with a no-op overlay.
  // ------------------------------------------------------------------
  document.addEventListener('keydown', function (e) {
    if (!e.shiftKey) return;
    if ((e.key || '').toLowerCase() !== 'e') return;
    var isMac = /Mac|iPhone|iPad/.test(navigator.platform || '');
    var mod = isMac ? e.metaKey : e.ctrlKey;
    if (!mod) return;
    // Ignore when a modifier-conflict is likely (typing inside a field
    // with a composed shortcut)
    e.preventDefault();
    var url = new URL(location.href);
    if (url.searchParams.get('edit') === '1') {
      url.searchParams.delete('edit');
    } else {
      url.searchParams.set('edit', '1');
    }
    location.href = url.toString();
  });

  // ------------------------------------------------------------------
  // Guards: only run on localhost with ?edit=1
  // ------------------------------------------------------------------
  const isLocalhost = (
    location.hostname === 'localhost' ||
    location.hostname === '127.0.0.1'
  );
  if (!isLocalhost) return;

  const params = new URLSearchParams(location.search);
  if (params.get('edit') !== '1') return;

  const SERVER = 'http://127.0.0.1:4711';

  // Derive the relative path for the current page (Jekyll permalink -> .md)
  function pageRelPath() {
    // e.g. /knowledge/topics/sex_chromosome_evolution/  =>
    //       knowledge/topics/sex_chromosome_evolution.md
    let p = location.pathname.replace(/\/$/, '');
    if (!p || p === '') return null;
    // Strip leading slash
    p = p.replace(/^\//, '');
    // If it already ends in .md, use as-is; otherwise append .md
    if (!p.endsWith('.md')) p = p + '.md';
    return p;
  }

  // ------------------------------------------------------------------
  // Server health check
  // ------------------------------------------------------------------
  fetch(SERVER + '/health')
    .then(function (r) { return r.json(); })
    .then(function (data) {
      if (data.status !== 'ok') throw new Error('bad status');
      init();
    })
    .catch(function () {
      showBanner(
        'Edit server not running. Run: python3 -m wiki_tools.edit_server',
        'error'
      );
    });

  // ------------------------------------------------------------------
  // Banner
  // ------------------------------------------------------------------
  function showBanner(msg, kind) {
    var b = document.createElement('div');
    b.className = 'edit-banner edit-banner-' + (kind || 'info');
    b.textContent = msg;
    document.body.insertBefore(b, document.body.firstChild);
  }

  // ------------------------------------------------------------------
  // Main init — fetches raw markdown, scans DOM, wraps regions
  // ------------------------------------------------------------------
  function init() {
    var relPath = pageRelPath();
    if (!relPath) {
      showBanner('Edit overlay: could not determine page path.', 'error');
      return;
    }

    // Show V1 limitation notice
    showBanner(
      'Edit mode active. V1: user regions accept plain-text edits. ' +
      'Rich markdown formatting should be done in VS Code.',
      'info'
    );

    // Fetch raw markdown so we can do a proper round-trip
    fetch(SERVER + '/raw?path=' + encodeURIComponent(relPath))
      .then(function (r) {
        if (!r.ok) throw new Error('raw fetch failed: ' + r.status);
        return r.text();
      })
      .then(function (rawMd) {
        scanAndWrap(rawMd, relPath);
      })
      .catch(function (err) {
        console.warn('[edit-overlay] raw fetch failed, editing disabled:', err);
        showBanner('Edit overlay: could not fetch raw markdown (' + err.message + ').', 'error');
      });
  }

  // ------------------------------------------------------------------
  // DOM scanning: find comment nodes to locate regions
  // ------------------------------------------------------------------
  function scanAndWrap(rawMd, relPath) {
    var main = document.querySelector('main.column');
    if (!main) return;

    // Walk all child nodes collecting comment nodes
    var nodes = [];
    var walker = document.createTreeWalker(
      main,
      NodeFilter.SHOW_ALL,
      null
    );
    var node;
    while ((node = walker.nextNode())) {
      nodes.push(node);
    }

    // Parse USER regions from raw markdown for data-raw storage
    var userRegions = extractUserRegionsFromRaw(rawMd);

    // Find comment node pairs and build region descriptors
    var regions = [];
    var openStack = [];

    nodes.forEach(function (n) {
      if (n.nodeType !== Node.COMMENT_NODE) return;
      var txt = n.nodeValue.trim();

      // user-start / user-end
      if (txt === 'user-start') {
        openStack.push({ type: 'user', start: n });
        return;
      }
      if (txt === 'user-end') {
        for (var i = openStack.length - 1; i >= 0; i--) {
          if (openStack[i].type === 'user' && !openStack[i].end) {
            openStack[i].end = n;
            regions.push(openStack[i]);
            openStack.splice(i, 1);
            break;
          }
        }
        return;
      }

      // tealc:NAME-start / tealc:NAME-end
      var tsm = txt.match(/^tealc:([A-Za-z0-9_-]+)-start$/);
      if (tsm) {
        openStack.push({ type: 'tealc', name: 'tealc:' + tsm[1], start: n });
        return;
      }
      var tem = txt.match(/^tealc:([A-Za-z0-9_-]+)-end$/);
      if (tem) {
        var tName = 'tealc:' + tem[1];
        for (var j = openStack.length - 1; j >= 0; j--) {
          if (openStack[j].name === tName && !openStack[j].end) {
            openStack[j].end = n;
            regions.push(openStack[j]);
            openStack.splice(j, 1);
            break;
          }
        }
      }
    });

    var userIdx = 0;
    regions.forEach(function (region) {
      if (region.type === 'user') {
        wrapUserRegion(region.start, region.end, userIdx, userRegions[userIdx] || '', relPath);
        userIdx++;
      } else if (region.type === 'tealc') {
        wrapTealcRegion(region.start, region.end, region.name, relPath);
      }
    });
  }

  // ------------------------------------------------------------------
  // Extract user region raw content blocks from raw markdown
  // ------------------------------------------------------------------
  function extractUserRegionsFromRaw(rawMd) {
    var results = [];
    var re = /<!--\s*user-start\s*-->([\s\S]*?)<!--\s*user-end\s*-->/g;
    var m;
    while ((m = re.exec(rawMd)) !== null) {
      results.push(m[1].replace(/^\n/, '').replace(/\n$/, ''));
    }
    return results;
  }

  // ------------------------------------------------------------------
  // Collect DOM nodes between two comment nodes (exclusive)
  // ------------------------------------------------------------------
  function nodesBetween(startComment, endComment) {
    var result = [];
    var cur = startComment.nextSibling;
    while (cur && cur !== endComment) {
      result.push(cur);
      cur = cur.nextSibling;
    }
    return result;
  }

  // ------------------------------------------------------------------
  // Wrap a USER region
  // ------------------------------------------------------------------
  function wrapUserRegion(startComment, endComment, regionIndex, rawContent, relPath) {
    var between = nodesBetween(startComment, endComment);
    if (between.length === 0) return;

    var wrapper = document.createElement('div');
    wrapper.className = 'edit-user';
    wrapper.dataset.regionIndex = String(regionIndex);
    wrapper.dataset.raw = rawContent;
    wrapper.contentEditable = 'true';

    var badge = document.createElement('span');
    badge.className = 'edit-badge edit-badge-user';
    badge.textContent = 'editable \u00b7 user';
    wrapper.appendChild(badge);

    // Move DOM nodes into wrapper
    between.forEach(function (n) { wrapper.appendChild(n); });
    startComment.parentNode.insertBefore(wrapper, endComment);

    // ------------------------------------------------------------------
    // Save logic
    // ------------------------------------------------------------------
    var saveTimer = null;
    var saving = false;

    function doSave() {
      if (saving) return;
      saving = true;

      // Use innerText as the new prose content (V1 approach)
      // Badge text must be excluded from save
      var textContent = '';
      wrapper.childNodes.forEach(function (child) {
        if (child === badge) return;
        textContent += child.textContent || child.nodeValue || '';
      });
      // Trim trailing whitespace but preserve internal structure
      var newContent = textContent;

      fetch(SERVER + '/file', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          path: relPath,
          region: 'user',
          region_index: regionIndex,
          new_content: newContent,
        }),
      })
        .then(function (r) { return r.json(); })
        .then(function (data) {
          saving = false;
          if (data.ok) {
            flashRegion(wrapper, 'ok');
            wrapper.dataset.raw = newContent;
          } else {
            flashRegion(wrapper, 'err');
            console.error('[edit-overlay] save error:', data);
          }
        })
        .catch(function (err) {
          saving = false;
          flashRegion(wrapper, 'err');
          console.error('[edit-overlay] network error on save:', err);
        });
    }

    // Debounced input handler
    wrapper.addEventListener('input', function () {
      clearTimeout(saveTimer);
      saveTimer = setTimeout(doSave, 800);
    });

    // Cmd+S / Ctrl+S: immediate save
    wrapper.addEventListener('keydown', function (e) {
      if ((e.metaKey || e.ctrlKey) && e.key === 's') {
        e.preventDefault();
        clearTimeout(saveTimer);
        doSave();
      }
    });
  }

  // ------------------------------------------------------------------
  // Wrap a TEALC region (propose-diff flow)
  // ------------------------------------------------------------------
  function wrapTealcRegion(startComment, endComment, regionName, relPath) {
    var between = nodesBetween(startComment, endComment);
    if (between.length === 0) return;

    var wrapper = document.createElement('div');
    wrapper.className = 'edit-tealc';
    wrapper.dataset.region = regionName;

    var badge = document.createElement('span');
    badge.className = 'edit-badge edit-badge-tealc';
    badge.textContent = 'Tealc-managed \u00b7 propose';
    wrapper.appendChild(badge);

    between.forEach(function (n) { wrapper.appendChild(n); });
    startComment.parentNode.insertBefore(wrapper, endComment);

    // Click inside opens the propose modal (once)
    var modalOpen = false;
    wrapper.addEventListener('click', function (e) {
      if (modalOpen) return;
      if (e.target.closest('.edit-propose-modal')) return;
      modalOpen = true;
      openProposeModal(wrapper, regionName, relPath, function () { modalOpen = false; });
    });
  }

  // ------------------------------------------------------------------
  // Propose modal
  // ------------------------------------------------------------------
  function openProposeModal(wrapper, regionName, relPath, onClose) {
    var modal = document.createElement('div');
    modal.className = 'edit-propose-modal';

    var label1 = document.createElement('p');
    label1.textContent = 'Propose change to ' + regionName + ':';
    modal.appendChild(label1);

    var textarea = document.createElement('textarea');
    textarea.rows = 6;
    textarea.placeholder = 'Paste your proposed replacement content here\u2026';
    modal.appendChild(textarea);

    var label2 = document.createElement('p');
    label2.textContent = 'Rationale (why):';
    modal.appendChild(label2);

    var rationaleInput = document.createElement('input');
    rationaleInput.type = 'text';
    rationaleInput.placeholder = 'Brief reason for the change';
    modal.appendChild(rationaleInput);

    var btnRow = document.createElement('div');
    btnRow.style.cssText = 'margin-top:8px;display:flex;gap:8px;';

    var submitBtn = document.createElement('button');
    submitBtn.type = 'button';
    submitBtn.textContent = 'Propose change';
    btnRow.appendChild(submitBtn);

    var cancelBtn = document.createElement('button');
    cancelBtn.type = 'button';
    cancelBtn.textContent = 'Cancel';
    btnRow.appendChild(cancelBtn);

    modal.appendChild(btnRow);
    wrapper.appendChild(modal);

    cancelBtn.addEventListener('click', function () {
      wrapper.removeChild(modal);
      onClose();
    });

    submitBtn.addEventListener('click', function () {
      var proposed = textarea.value.trim();
      var rationale = rationaleInput.value.trim();
      if (!proposed) { textarea.focus(); return; }

      submitBtn.disabled = true;
      submitBtn.textContent = 'Sending\u2026';

      fetch(SERVER + '/propose-edit', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          path: relPath,
          region: regionName,
          proposed_content: proposed,
          rationale: rationale,
        }),
      })
        .then(function (r) { return r.json(); })
        .then(function (data) {
          if (data.ok) {
            modal.innerHTML = '';
            var msg = document.createElement('p');
            msg.style.color = '#2e7d32';
            msg.textContent = 'Proposal queued. ';
            var link = document.createElement('a');
            link.href = '#';
            link.textContent = data.file || data.proposal_id;
            link.style.fontFamily = 'monospace';
            msg.appendChild(link);
            modal.appendChild(msg);
          } else {
            submitBtn.disabled = false;
            submitBtn.textContent = 'Propose change';
            console.error('[edit-overlay] propose error:', data);
          }
        })
        .catch(function (err) {
          submitBtn.disabled = false;
          submitBtn.textContent = 'Propose change';
          console.error('[edit-overlay] network error on propose:', err);
        });
    });
  }

  // ------------------------------------------------------------------
  // Flash feedback
  // ------------------------------------------------------------------
  function flashRegion(el, kind) {
    var cls = kind === 'ok' ? 'edit-save-flash-ok' : 'edit-save-flash-err';
    el.classList.remove('edit-save-flash-ok', 'edit-save-flash-err');
    // Trigger reflow to restart animation
    void el.offsetWidth;
    el.classList.add(cls);
    setTimeout(function () { el.classList.remove(cls); }, 1200);
  }

})();
