/**
 * ORCID Publications Fetcher
 * Fetches publications with authors from the ORCID public API.
 * Uses bulk endpoint to get contributor data.
 */
(function () {
  const ORCID_ID = '0000-0002-5433-4036';
  const BASE_URL = `https://pub.orcid.org/v3.0/${ORCID_ID}`;
  const CACHE_KEY = 'blackmon_orcid_pubs_v3';
  const CACHE_TTL = 1000 * 60 * 60; // 1 hour
  const BATCH_SIZE = 25; // put-codes per bulk request

  const container = document.getElementById('publications-list');
  if (!container) return;

  function extractSummary(group) {
    const summary = group['work-summary'][0];
    if (!summary) return null;
    const putCode = summary['put-code'];
    const title = summary.title?.title?.value || '';
    const journal = summary['journal-title']?.value || '';
    const year = summary['publication-date']?.year?.value || '';
    const type = summary.type || '';

    let doi = '';
    let doiUrl = '';
    const externalIds = summary['external-ids']?.['external-id'] || [];
    for (const eid of externalIds) {
      if (eid['external-id-type'] === 'doi') {
        doi = eid['external-id-value'];
        doiUrl = eid['external-id-url']?.value || `https://doi.org/${doi}`;
        break;
      }
    }

    if (!title) return null;
    return { putCode, title, journal, year, doi, doiUrl, type, authors: '' };
  }

  function extractAuthors(workDetail) {
    const contributors = workDetail?.contributors?.contributor || [];
    const authors = contributors
      .filter(c => c['contributor-attributes']?.['contributor-role'] === 'author')
      .map(c => c['credit-name']?.value)
      .filter(Boolean);
    return authors.join(', ');
  }

  async function fetchAuthorsBatch(putCodes) {
    const url = `${BASE_URL}/works/${putCodes.join(',')}`;
    const resp = await fetch(url, {
      headers: { 'Accept': 'application/json' }
    });
    if (!resp.ok) return {};

    const json = await resp.json();
    const results = {};
    const bulk = json.bulk || [];
    for (const entry of bulk) {
      const work = entry.work;
      if (!work) continue;
      const pc = work['put-code'];
      results[pc] = extractAuthors(work);
    }
    return results;
  }

  function renderPubs(works) {
    const byYear = {};
    for (const w of works) {
      const y = w.year || 'Undated';
      if (!byYear[y]) byYear[y] = [];
      byYear[y].push(w);
    }

    const years = Object.keys(byYear).sort((a, b) => {
      if (a === 'Undated') return 1;
      if (b === 'Undated') return -1;
      return parseInt(b) - parseInt(a);
    });

    let html = '';
    for (const year of years) {
      html += `<h3 class="pub-year">${year}</h3>`;
      for (const w of byYear[year]) {
        const authorPart = w.authors ? `<span class="pub-authors">${w.authors}</span>` : '';
        const journalPart = w.journal ? `<em class="pub-journal">${w.journal}</em>.` : '';
        const typeBadge = w.type === 'preprint'
          ? ' <span class="pub-badge pub-badge-preprint">preprint</span>'
          : '';
        const doiLink = w.doiUrl
          ? ` <a href="${w.doiUrl}" target="_blank" rel="noopener" class="pub-doi">DOI</a>`
          : '';

        html += `<article class="pub-entry">
          ${authorPart}
          <span class="pub-title">${w.title}</span>${typeBadge}
          <div class="pub-meta">${journalPart}${doiLink}</div>
        </article>`;
      }
    }

    container.innerHTML = html;
  }

  function showError() {
    container.innerHTML = `
      <p class="pub-fallback">
        Publications are loaded from <a href="https://orcid.org/${ORCID_ID}" target="_blank">ORCID</a>.
        If they don't appear, view them on
        <a href="https://scholar.google.com/citations?user=ytApUl0AAAAJ&hl=en" target="_blank">Google Scholar</a>.
      </p>`;
  }

  function showLoading() {
    container.innerHTML = '<p class="pub-loading">Loading publications from ORCID<span class="loading-dots"></span></p>';
  }

  // Try the local snapshot first (fast, resilient to ORCID outages),
  // then refresh from the live ORCID API in the background.
  async function loadFromSnapshot() {
    const url = new URL('data/publications.json', document.baseURI).toString();
    const resp = await fetch(url, { cache: 'no-cache' });
    if (!resp.ok) throw new Error('snapshot HTTP ' + resp.status);
    const json = await resp.json();
    return json.works || [];
  }

  async function loadFromOrcid() {
    const resp = await fetch(`${BASE_URL}/works`, {
      headers: { 'Accept': 'application/json' }
    });
    if (!resp.ok) throw new Error(`HTTP ${resp.status}`);

    const json = await resp.json();
    const groups = json.group || [];
    const ALLOWED_TYPES = ['journal-article', 'book', 'book-chapter', 'preprint'];
    const works = groups.map(extractSummary).filter(Boolean)
      .filter(w => ALLOWED_TYPES.includes(w.type));

    const putCodes = works.map(w => w.putCode).filter(Boolean);
    const authorMap = {};
    for (let i = 0; i < putCodes.length; i += BATCH_SIZE) {
      const batch = putCodes.slice(i, i + BATCH_SIZE);
      const batchResults = await fetchAuthorsBatch(batch);
      Object.assign(authorMap, batchResults);
    }
    for (const w of works) {
      if (authorMap[w.putCode]) w.authors = authorMap[w.putCode];
    }
    return works;
  }

  async function fetchPubs() {
    // Try in-session cache first
    try {
      const cached = sessionStorage.getItem(CACHE_KEY);
      if (cached) {
        const { data, ts } = JSON.parse(cached);
        if (Date.now() - ts < CACHE_TTL) {
          renderPubs(data);
          return;
        }
      }
    } catch (e) { /* ignore cache errors */ }

    showLoading();

    // Snapshot is the primary source: fast, deterministic, resilient.
    let snapshotWorks = null;
    try {
      snapshotWorks = await loadFromSnapshot();
      renderPubs(snapshotWorks);
      try {
        sessionStorage.setItem(CACHE_KEY, JSON.stringify({ data: snapshotWorks, ts: Date.now() }));
      } catch (e) { /* storage full, ignore */ }
    } catch (e) {
      console.warn('publications snapshot unavailable, falling back to live ORCID:', e);
    }

    // Fetch from ORCID in the background to pick up new pubs since the last snapshot.
    try {
      const fresh = await loadFromOrcid();
      if (!snapshotWorks || fresh.length !== snapshotWorks.length) {
        renderPubs(fresh);
        try {
          sessionStorage.setItem(CACHE_KEY, JSON.stringify({ data: fresh, ts: Date.now() }));
        } catch (e) { /* storage full, ignore */ }
      }
    } catch (err) {
      if (!snapshotWorks) {
        console.error('ORCID fetch failed and no snapshot available:', err);
        showError();
      }
      // else: snapshot already rendered; live fetch failure is silent
    }
  }

  fetchPubs();
})();
