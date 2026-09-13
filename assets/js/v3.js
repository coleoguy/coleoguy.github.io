/* Blackmon Lab v3: shared behavior (theme toggle, command palette, ask-the-lab, live publications feed) */

(function () {
  const NOTEBOOK_URL = 'https://notebooklm.google.com/notebook/6a3182b5-d5fe-471e-8513-a68c672d8f28';
  const NB_TAB = 'blackmon-notebooklm';
  const WORKER_URL = 'https://blackmon-lab-chat.blackmon.workers.dev';

  // Theme toggle
  const root = document.documentElement;
  const themeBtn = document.getElementById('theme-btn');
  let stored;
  try { stored = localStorage.getItem('v3-theme'); } catch (_) {}
  if (stored === 'dark') {
    root.setAttribute('data-theme', 'dark');
    if (themeBtn) themeBtn.textContent = '☀';
  }
  if (themeBtn) {
    themeBtn.addEventListener('click', () => {
      const next = root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
      root.setAttribute('data-theme', next);
      themeBtn.textContent = next === 'dark' ? '☀' : '☾';
      try { localStorage.setItem('v3-theme', next); } catch (_) {}
    });
  }

  // Native buttons keep the navigation usable with keyboard and touch.
  const TREE_KEY = 'sidebar-open';
  function treeGetOpen() {
    try { const value = JSON.parse(localStorage.getItem(TREE_KEY)); return Array.isArray(value) ? value : []; } catch (_) { return []; }
  }
  function treeSaveOpen() {
    const names = [...document.querySelectorAll('.tree li.open > .tree-toggle')].map(b => b.textContent.trim());
    try { localStorage.setItem(TREE_KEY, JSON.stringify(names)); } catch (_) {}
  }
  const normalizeRoute = path => path.replace(/index\.html$/, '').replace(/\/$/, '') || '/';
  const currentRoute = normalizeRoute(window.location.pathname);
  document.querySelectorAll('.tree a[href]').forEach(a => {
    const link = new URL(a.getAttribute('href'), window.location.href);
    if (link.origin === window.location.origin && normalizeRoute(link.pathname) === currentRoute) {
      a.classList.add('active');
      a.setAttribute('aria-current', 'page');
    }
  });
  const savedOpen = treeGetOpen();
  document.querySelectorAll('.tree li > .tree-toggle').forEach((button, index) => {
    const li = button.parentElement;
    const list = li.querySelector(':scope > ul');
    if (!list) return;
    list.id = 'nav-branch-' + index;
    button.setAttribute('aria-controls', list.id);
    const sync = open => {
      li.classList.toggle('open', open);
      button.setAttribute('aria-expanded', String(open));
    };
    sync(!!list.querySelector('a.active') || savedOpen.includes(button.textContent.trim()));
    button.addEventListener('click', () => { sync(!li.classList.contains('open')); treeSaveOpen(); });
  });

  // Command palette
  const PAL_ITEMS = [];
  document.querySelectorAll('.tree li a[href]').forEach(a => {
    const parent = a.closest('li').parentElement.closest('li');
    const cat = parent ? (parent.querySelector(':scope > .tree-toggle')?.textContent || '') : '';
    PAL_ITEMS.push({ label: a.textContent.trim(), cat: cat, href: a.getAttribute('href') });
  });
  const overlay = document.getElementById('palette-overlay');
  const palInput = document.getElementById('palette-input');
  const palResults = document.getElementById('palette-results');
  let palSelected = 0;

  function renderPalResults(filter) {
    if (!palResults) return;
    const q = (filter || '').toLowerCase().trim();
    const matches = q
      ? PAL_ITEMS.filter(i => i.label.toLowerCase().includes(q) || i.cat.toLowerCase().includes(q))
      : PAL_ITEMS;
    palSelected = 0;
    palResults.replaceChildren();
    matches.slice(0, 30).forEach((item, index) => {
      const link = document.createElement('a');
      link.href = item.href;
      link.className = 'palette-item' + (index === 0 ? ' selected' : '');
      const category = document.createElement('span');
      category.className = 'cat'; category.textContent = item.cat;
      const label = document.createElement('span'); label.textContent = item.label;
      link.append(category, label); palResults.appendChild(link);
    });
    if (!matches.length) {
      const empty = document.createElement('p');
      empty.className = 'palette-empty'; empty.setAttribute('role', 'status');
      empty.textContent = 'No matching pages. Try another name or topic.';
      palResults.appendChild(empty);
    }
  }

  let paletteTrigger = null;
  window.openPalette = function () {
    if (!overlay || overlay.open) return;
    paletteTrigger = document.activeElement;
    if (palInput) { palInput.value = ''; renderPalResults(''); }
    overlay.showModal();
    if (palInput) palInput.focus();
  };
  window.closePalette = function () { if (overlay && overlay.open) overlay.close(); };
  if (overlay) {
    overlay.addEventListener('click', e => { if (e.target === overlay) closePalette(); });
    overlay.addEventListener('close', () => {
      if (paletteTrigger && paletteTrigger.isConnected) paletteTrigger.focus();
    });
  }

  document.addEventListener('keydown', (e) => {
    if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === 'k') {
      e.preventDefault();
      openPalette();
    } else if (e.key === 'Escape' && overlay && overlay.open) {
      closePalette();
    }
  });

  if (palInput) {
    palInput.addEventListener('input', (e) => renderPalResults(e.target.value));
    palInput.addEventListener('keydown', (e) => {
      const items = palResults.querySelectorAll('.palette-item');
      if (e.key === 'ArrowDown') { e.preventDefault(); palSelected = Math.min(palSelected + 1, items.length - 1); }
      else if (e.key === 'ArrowUp') { e.preventDefault(); palSelected = Math.max(palSelected - 1, 0); }
      else if (e.key === 'Enter') {
        e.preventDefault();
        if (items[palSelected]) window.location.href = items[palSelected].href;
        return;
      } else return;
      items.forEach((it, i) => it.classList.toggle('selected', i === palSelected));
      items[palSelected]?.scrollIntoView({ block: 'nearest' });
    });
  }

  // Ask the lab — streams answer from Cloudflare Worker (Gemini 2.0 Flash).
  // Falls back to clipboard + NotebookLM when WORKER_URL is not set.
  window.askTheLab = function (e) {
    e.preventDefault();
    const field = document.getElementById('ask-input');
    const submit = document.getElementById('ask-submit');
    const answerDiv = document.getElementById('ask-answer');
    const toast = document.getElementById('ask-toast');
    const q = (field?.value || '').trim();

    if (!q) {
      window.open(NOTEBOOK_URL, NB_TAB);
      return false;
    }

    if (!WORKER_URL) {
      const flash = (msg) => {
        if (!toast) return;
        toast.textContent = msg;
        toast.classList.add('show');
        setTimeout(() => toast.classList.remove('show'), 2400);
      };
      const openAndFlash = (copied) => {
        window.open(NOTEBOOK_URL, NB_TAB);
        flash(copied ? 'Question copied. Paste it into the NotebookLM tab.' : 'NotebookLM opened. Paste your question.');
        if (field) field.value = '';
      };
      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(q).then(() => openAndFlash(true)).catch(() => openAndFlash(false));
      } else {
        openAndFlash(false);
      }
      return false;
    }

    if (field) field.disabled = true;
    if (submit) submit.disabled = true;
    if (answerDiv) {
      answerDiv.classList.add('show');
      answerDiv.innerHTML = '<span class="ask-thinking">Thinking</span>';
    }

    fetch(WORKER_URL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ question: q })
    })
      .then(r => r.json())
      .then(data => {
        if (!answerDiv) return;
        if (data.answer) {
          const p = document.createElement('p');
          p.style.margin = '0';
          p.textContent = data.answer;
          const link = document.createElement('a');
          link.href = NOTEBOOK_URL;
          link.target = NB_TAB;
          link.rel = 'noopener';
          link.className = 'ask-nb-link';
          link.textContent = 'Go deeper in NotebookLM →';
          answerDiv.innerHTML = '';
          answerDiv.appendChild(p);
          answerDiv.appendChild(link);
        } else {
          throw new Error('empty');
        }
      })
      .catch(() => {
        if (!answerDiv) return;
        const span = document.createElement('span');
        span.className = 'ask-error';
        span.textContent = "Couldn't get a response. ";
        const link = document.createElement('a');
        link.href = NOTEBOOK_URL;
        link.target = NB_TAB;
        link.textContent = 'Open NotebookLM →';
        answerDiv.innerHTML = '';
        answerDiv.appendChild(span);
        answerDiv.appendChild(link);
      })
      .finally(() => {
        if (field) { field.disabled = false; field.value = ''; }
        if (submit) submit.disabled = false;
      });

    return false;
  };

  // Publications feed (fires only if the page has a target)
  const pubsTarget = document.getElementById('recent-pubs');
  const statPubs = document.getElementById('stat-pubs');
  if (pubsTarget || statPubs) {
    fetch('data/publications.json')
      .then(r => r.json())
      .then(data => {
        if (!data || !Array.isArray(data.works)) return;
        if (statPubs) {
          const journalCount = data.works.filter(w => w.type === 'journal-article' || w.type === 'book-chapter').length;
          statPubs.textContent = journalCount;
        }
        if (pubsTarget) {
          const recent = data.works
            .filter(w => parseInt(w.year, 10) >= 2024 && w.doi && w.doi !== '10.1101/2024.11.29.626112')
            .slice(0, 5);
          pubsTarget.innerHTML = recent.map(w => {
            const shortAuthors = (w.authors || '').split(',').slice(0, 3).map(a => a.trim()).join(', ') +
              (w.authors && w.authors.split(',').length > 3 ? ', et al.' : '');
            const journal = (w.journal || '').trim();
            const journalText = journal ? `<em>${journal}</em>` : (w.type === 'preprint' ? '<em>bioRxiv</em>' : '');
            return `
              <div class="pub-entry">
                <div class="pub-year">${w.year}</div>
                <div class="pub-body">
                  <a class="pub-title" href="${w.doiUrl || '#'}" target="_blank">${w.title}</a>
                  <div class="pub-meta">${shortAuthors}${journalText ? ' · ' + journalText : ''}</div>
                </div>
              </div>`;
          }).join('');
        }
      })
      .catch(() => {});
  }

  // Mobile navigation toggle — injected into .column on small screens
  (function() {
    const sidebar = document.querySelector('.sidebar');
    const mainCol = document.querySelector('.column');
    if (!sidebar || !mainCol) return;

    const openBtn = document.createElement('button');
    openBtn.className = 'mobile-nav-btn';
    openBtn.setAttribute('aria-label', 'Open navigation menu');
    openBtn.textContent = '\u2630 Menu';

    const closeBtn = document.createElement('button');
    closeBtn.type = 'button';
    closeBtn.className = 'mobile-nav-close';
    closeBtn.setAttribute('aria-label', 'Close navigation menu');
    closeBtn.textContent = '\u2715 Close menu';
    sidebar.insertBefore(closeBtn, sidebar.firstChild);
    openBtn.type = 'button';
    openBtn.setAttribute('aria-controls', sidebar.id);
    openBtn.setAttribute('aria-expanded', 'false');
    let previousOverflow = '';
    let wasInert = false;
    let chromeWasInert = false;
    const chrome = document.querySelector('.chrome');
    function openNav() {
      if (sidebar.classList.contains('mobile-open')) return;
      previousOverflow = document.body.style.overflow;
      wasInert = mainCol.inert; chromeWasInert = chrome ? chrome.inert : false;
      sidebar.classList.add('mobile-open');
      openBtn.setAttribute('aria-expanded', 'true');
      document.body.style.overflow = 'hidden';
      mainCol.inert = true; if (chrome) chrome.inert = true;
      closeBtn.focus();
    }
    function closeNav(restoreFocus = true) {
      if (!sidebar.classList.contains('mobile-open')) return;
      sidebar.classList.remove('mobile-open');
      openBtn.setAttribute('aria-expanded', 'false');
      document.body.style.overflow = previousOverflow;
      mainCol.inert = wasInert; if (chrome) chrome.inert = chromeWasInert;
      if (restoreFocus) openBtn.focus();
    }
    openBtn.addEventListener('click', openNav);
    closeBtn.addEventListener('click', () => closeNav());
    sidebar.addEventListener('keydown', event => {
      if (!sidebar.classList.contains('mobile-open')) return;
      if (event.key === 'Escape') { event.preventDefault(); closeNav(); }
      if (event.key === 'Tab') {
        const controls = [...sidebar.querySelectorAll('button, a[href]')].filter(el => el.getClientRects().length);
        const first = controls[0], last = controls[controls.length - 1];
        if (event.shiftKey && document.activeElement === first) { event.preventDefault(); last.focus(); }
        else if (!event.shiftKey && document.activeElement === last) { event.preventDefault(); first.focus(); }
      }
    });
    sidebar.querySelectorAll('a').forEach(a => {
      a.addEventListener('click', () => { if (window.innerWidth <= 900) closeNav(false); });
    });
    window.addEventListener('resize', () => { if (window.innerWidth > 900) closeNav(false); });

    mainCol.insertBefore(openBtn, mainCol.firstChild);
  })();

  // News feed (fires only if the page has a target)
  const newsTarget = document.getElementById('recent-news');
  if (newsTarget) {
    fetch('data/news.json')
      .then(r => r.json())
      .then(items => {
        if (!Array.isArray(items)) return;
        const limit = parseInt(newsTarget.dataset.limit || '12', 10);
        const recent = items.slice(0, limit);
        newsTarget.innerHTML = recent.map(n => `
          <div class="news-entry">
            <div class="news-date">${n.date}</div>
            <div>
              <div class="news-title">${n.title}</div>
              <div class="news-body">${n.body || ''}</div>
            </div>
          </div>
        `).join('');
      })
      .catch(() => {});
  }
})();

/* Wikipedia-feel TOC — runs only on body.wiki.
   Collects H2s inside <main>, stamps each with data-section-num
   and an id, injects a Contents box above the first section. */
(function wikiTOC() {
  if (!document.body.classList.contains('wiki')) return;
  const main = document.getElementById('content');
  if (!main) return;

  const heads = main.querySelectorAll('h2');
  if (heads.length < 2) return;

  const slugify = (s) => s.trim().toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .slice(0, 60) || 'section';

  heads.forEach((h, i) => {
    if (!h.id) h.id = 'sec-' + slugify(h.textContent);
    h.setAttribute('data-section-num', i + 1);
  });

  const toc = document.createElement('aside');
  toc.className = 'wiki-toc';
  toc.setAttribute('aria-label', 'Contents');

  const headRow = document.createElement('div');
  headRow.className = 'wiki-toc-head';
  headRow.textContent = 'Contents';

  const toggle = document.createElement('a');
  toggle.href = '#';
  toggle.className = 'wiki-toc-toggle';
  toggle.textContent = '[hide]';
  toggle.addEventListener('click', (e) => {
    e.preventDefault();
    const collapsed = toc.classList.toggle('collapsed');
    toggle.textContent = collapsed ? '[show]' : '[hide]';
  });
  headRow.appendChild(toggle);

  const ol = document.createElement('ol');
  heads.forEach((h) => {
    const li = document.createElement('li');
    const a = document.createElement('a');
    a.href = '#' + h.id;
    a.textContent = h.textContent;
    li.appendChild(a);
    ol.appendChild(li);
  });

  toc.appendChild(headRow);
  toc.appendChild(ol);
  heads[0].parentNode.insertBefore(toc, heads[0]);
})();

/* Wiki register toggle — Student / Researcher reading modes.
   Runs only on body.wiki. Looks for containers with paired
   [data-register="student"] and [data-register="researcher"]
   children (topic-page leads produced by surface_composer).
   Persists preference to localStorage, default "researcher". */
(function wikiRegisterToggle() {
  if (!document.body.classList.contains('wiki')) return;
  const main = document.getElementById('content');
  if (!main) return;

  const containers = main.querySelectorAll('.wiki-lead');
  if (containers.length === 0) return;

  const STORAGE_KEY = 'wiki-register-pref';
  let pref = 'researcher';
  try { pref = localStorage.getItem(STORAGE_KEY) || 'researcher'; } catch (_) {}
  if (pref !== 'student' && pref !== 'researcher') pref = 'researcher';

  containers.forEach((container) => {
    const hasStudent = container.querySelector('[data-register="student"]');
    const hasResearcher = container.querySelector('[data-register="researcher"]');
    if (!hasStudent || !hasResearcher) return;

    container.setAttribute('data-active', pref);

    const toggle = document.createElement('div');
    toggle.className = 'wiki-register-toggle';
    toggle.setAttribute('role', 'radiogroup');
    toggle.setAttribute('aria-label', 'Reading register');
    toggle.innerHTML =
      '<span class="wiki-register-label">Read as:</span>' +
      '<button type="button" role="radio" data-register-btn="student">Student</button>' +
      '<button type="button" role="radio" data-register-btn="researcher">Researcher</button>';

    const btns = toggle.querySelectorAll('[data-register-btn]');
    const sync = () => btns.forEach((b) => {
      const on = b.dataset.registerBtn === container.getAttribute('data-active');
      b.setAttribute('aria-pressed', on ? 'true' : 'false');
      b.setAttribute('aria-checked', on ? 'true' : 'false');
    });
    sync();

    btns.forEach((b) => b.addEventListener('click', (e) => {
      e.preventDefault();
      const next = b.dataset.registerBtn;
      document.querySelectorAll('.wiki-lead').forEach((c) => c.setAttribute('data-active', next));
      document.querySelectorAll('.wiki-register-toggle [data-register-btn]').forEach((otherBtn) => {
        const on = otherBtn.dataset.registerBtn === next;
        otherBtn.setAttribute('aria-pressed', on ? 'true' : 'false');
        otherBtn.setAttribute('aria-checked', on ? 'true' : 'false');
      });
      try { localStorage.setItem(STORAGE_KEY, next); } catch (_) {}
    }));

    container.parentNode.insertBefore(toggle, container);
  });
})();
