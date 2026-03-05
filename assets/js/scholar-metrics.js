/**
 * Scholar Metrics - Displays citation data from Google Scholar
 * Data source: assets/data/scholar-metrics.json
 * To update: edit the JSON file with current Google Scholar values
 */
(function () {
  const DATA_URL = 'assets/data/scholar-metrics.json';

  // Hardcoded fallback for local file:// testing (updated from Google Scholar)
  const FALLBACK = { citationCount: 2199, hIndex: 23, i10Index: 32 };

  // Find all containers that want metrics
  const containers = document.querySelectorAll('[data-scholar-metrics]');
  if (containers.length === 0) return;

  function animateNumber(el, target, duration) {
    const start = 0;
    const startTime = performance.now();
    function update(currentTime) {
      const elapsed = currentTime - startTime;
      const progress = Math.min(elapsed / duration, 1);
      // Ease out cubic
      const eased = 1 - Math.pow(1 - progress, 3);
      const current = Math.round(start + (target - start) * eased);
      el.textContent = current.toLocaleString();
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

      // Animate numbers on scroll
      const observer = new IntersectionObserver((entries) => {
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

  async function fetchMetrics() {
    try {
      const resp = await fetch(DATA_URL);
      if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
      const data = await resp.json();
      renderMetrics(data);
    } catch (err) {
      console.warn('Scholar metrics fetch failed, using fallback:', err);
      renderMetrics(FALLBACK);
    }
  }

  fetchMetrics();
})();
