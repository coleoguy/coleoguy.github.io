/* Blackmon Lab v3: shared behavior (theme toggle, command palette, ask-the-lab, live publications feed) */

(function () {
  const NOTEBOOK_URL = 'https://notebooklm.google.com/notebook/6a3182b5-d5fe-471e-8513-a68c672d8f28';
  const NB_TAB = 'blackmon-notebooklm';
  const WORKER_URL = 'https://blackmon-lab-chat.blackmon.workers.dev';

  // Theme toggle
  const root = document.documentElement;
  const themeBtn = document.getElementById('theme-btn');
  const stored = localStorage.getItem('v3-theme');
  if (stored === 'dark') {
    root.setAttribute('data-theme', 'dark');
    if (themeBtn) themeBtn.textContent = '☀';
  }
  if (themeBtn) {
    themeBtn.addEventListener('click', () => {
      const next = root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
      root.setAttribute('data-theme', next);
      themeBtn.textContent = next === 'dark' ? '☀' : '☾';
      localStorage.setItem('v3-theme', next);
    });
  }

  // Collapsible sidebar tree categories — collapsed by default, open if active link inside
  document.querySelectorAll('.tree > li > span').forEach(span => {
    const li = span.parentElement;
    const ul = li.querySelector(':scope > ul');
    if (!ul) return;
    if (ul.querySelector('a.active')) li.classList.add('open');
    span.addEventListener('click', () => li.classList.toggle('open'));
  });

  // Command palette
  const PAL_ITEMS = [];
  document.querySelectorAll('.tree li a[href]').forEach(a => {
    const parent = a.closest('li').parentElement.closest('li');
    const cat = parent ? (parent.querySelector(':scope > span')?.textContent || '') : '';
    PAL_ITEMS.push({ label: a.textContent.trim(), cat: cat, href: a.getAttribute('href') });
  });
  // Essays and other pages not carried in the sidebar tree, but worth finding via Cmd-K.
  PAL_ITEMS.push({ label: 'Both sides are right', cat: 'Essays', href: 'both-sides-are-right.html' });

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
    palResults.innerHTML = matches.slice(0, 30).map((i, idx) => `
      <a href="${i.href}" class="palette-item${idx === 0 ? ' selected' : ''}">
        <span class="cat">${i.cat}</span>
        <span>${i.label}</span>
      </a>
    `).join('');
  }

  window.openPalette = function () {
    if (!overlay) return;
    overlay.classList.add('show');
    if (palInput) { palInput.value = ''; renderPalResults(''); setTimeout(() => palInput.focus(), 10); }
  };
  window.closePalette = function () {
    if (overlay) overlay.classList.remove('show');
  };

  if (overlay) {
    overlay.addEventListener('click', (e) => { if (e.target === overlay) closePalette(); });
  }

  document.addEventListener('keydown', (e) => {
    if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === 'k') {
      e.preventDefault();
      openPalette();
    } else if (e.key === 'Escape' && overlay && overlay.classList.contains('show')) {
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
    closeBtn.className = 'mobile-nav-close';
    closeBtn.setAttribute('aria-label', 'Close navigation menu');
    closeBtn.textContent = '\u2715 Close menu';
    sidebar.insertBefore(closeBtn, sidebar.firstChild);

    function openNav() {
      sidebar.classList.add('mobile-open');
      document.body.style.overflow = 'hidden';
    }
    function closeNav() {
      sidebar.classList.remove('mobile-open');
      document.body.style.overflow = '';
    }

    openBtn.addEventListener('click', openNav);
    closeBtn.addEventListener('click', closeNav);
    sidebar.querySelectorAll('a').forEach(a => {
      a.addEventListener('click', function() { if (window.innerWidth < 900) closeNav(); });
    });

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
