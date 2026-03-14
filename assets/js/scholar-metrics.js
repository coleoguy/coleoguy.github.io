/**
 * Scholar Metrics — live citation data via OpenAlex public API
 *
 * Primary source: OpenAlex (api.openalex.org) — free, no API key, ORCID lookup.
 *   Note: OpenAlex counts differ slightly from Google Scholar because Google
 *   indexes a broader document set. Both are valid; OpenAlex is open and
 *   auto-updates on every page load.
 * Fallback 1: assets/data/scholar-metrics.json  (manually maintained cache)
 * Fallback 2: hardcoded values below
 *
 * To force a manual override, edit assets/data/scholar-metrics.json.
 */
(function () {
  const ORCID        = '0000-0002-5433-4036';
  const OPENALEX_URL = `https://api.openalex.org/authors/https://orcid.org/${ORCID}`;
  const JSON_URL     = 'assets/data/scholar-metrics.json';
  const FALLBACK     = { citationCount: 2199, hIndex: 23, i10Index: 32 };

  const containers = document.querySelectorAll('[data-scholar-metrics]');
  if (containers.length === 0) return;

  function animateNumber(el, target, duration) {
    const startTime = performance.now();
    function update(now) {
      const progress = Math.min((now - startTime) / duration, 1);
      const eased    = 1 - Math.pow(1 - progress, 3);
      el.textContent = Math.round(eased * target).toLocaleString();
      if (progress < 1) requestAnimationFrame(update);
    }
    requestAnimationFrame(update);
  }

  function renderMetrics(data) {
    containers.forEach(container => {
      const style = container.dataset.scholarMetrics || 'banner';

      if (style === 'banner') {
        container.innerHTML = `
          <div class="metrics-banner">
            <div class="metric-item">
              <span class="metric-number" data-target="${data.citationCount}">0</span>
              <span class="metric-label">Citations</span>
            </div>
            <div class="metric-divider"></div>
            <div class="metric-item">
              <span class="metric-number" data-target="${data.hIndex}">0</span>
              <span class="metric-label">h-index</span>
            </div>
            <div class="metric-divider"></div>
            <div class="metric-item">
              <span class="metric-number" data-target="${data.i10Index}">0</span>
              <span class="metric-label">i10-index</span>
            </div>
          </div>
        `;
      } else if (style === 'compact') {
        container.innerHTML = `
          <div class="metrics-compact">
            <span><strong>${data.citationCount.toLocaleString()}</strong> citations</span>
            <span class="metric-dot">&middot;</span>
            <span>h-index <strong>${data.hIndex}</strong></span>
            <span class="metric-dot">&middot;</span>
            <span>i10-index <strong>${data.i10Index}</strong></span>
          </div>
        `;
      }

      // Animate numbers into view
      const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            container.querySelectorAll('[data-target]').forEach(el => {
              animateNumber(el, parseInt(el.dataset.target), 1500);
            });
            observer.unobserve(entry.target);
          }
        });
      }, { threshold: 0.3 });
      observer.observe(container);
    });
  }

  // Try OpenAlex first, then local JSON cache, then hardcoded fallback
  async function fetchMetrics() {
    // 1. OpenAlex live data (auto-updates, no key required)
    try {
      const resp = await fetch(OPENALEX_URL);
      if (!resp.ok) throw new Error(`OpenAlex HTTP ${resp.status}`);
      const author = await resp.json();
      const data = {
        citationCount: author.cited_by_count           || 0,
        hIndex:        author.summary_stats?.h_index   || 0,
        i10Index:      author.summary_stats?.i10_index || 0,
      };
      if (data.citationCount > 0 && data.hIndex > 0) {
        renderMetrics(data);
        return;
      }
      throw new Error('OpenAlex returned implausible values');
    } catch (e) {
      console.info('Scholar metrics: OpenAlex unavailable, trying local cache.', e.message);
    }

    // 2. Local JSON cache (manually updated backup)
    try {
      const resp = await fetch(JSON_URL);
      if (!resp.ok) throw new Error(`JSON cache HTTP ${resp.status}`);
      const data = await resp.json();
      renderMetrics(data);
      return;
    } catch (e) {
      console.info('Scholar metrics: local cache unavailable, using hardcoded fallback.', e.message);
    }

    // 3. Hardcoded fallback
    renderMetrics(FALLBACK);
  }

  fetchMetrics();
})();
