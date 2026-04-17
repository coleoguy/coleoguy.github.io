/**
 * News Feed - Loads and renders lab news/highlights from data/news.json.
 * Falls back to a small embedded notice if fetch fails (e.g. opened via file://).
 */
(function () {
  const container = document.getElementById('news-feed');
  if (!container) return;

  const maxItems = parseInt(container.dataset.maxItems) || 100;
  const layout = container.dataset.layout || 'cards';

  function formatDate(dateStr) {
    const d = new Date(dateStr + 'T00:00:00');
    const now = new Date();
    const diffDays = Math.floor((now - d) / (1000 * 60 * 60 * 24));
    if (diffDays === 0) return 'Today';
    if (diffDays === 1) return 'Yesterday';
    if (diffDays < 7) return `${diffDays} days ago`;
    return d.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
  }

  function categoryColor(cat) {
    const colors = {
      publication: '#4dabf7',
      funding: '#51cf66',
      award: '#fcc419',
      lab: '#c9a227',
      career: '#cc5de8',
      teaching: '#ff922b',
      service: '#868e96'
    };
    return colors[cat] || '#c9a227';
  }

  function renderCards(items) {
    let html = '<div class="news-grid">';
    for (const item of items) {
      const color = categoryColor(item.category);
      html += `
        <div class="news-card" data-aos="fade-up">
          <div class="news-card-accent" style="background: ${color}"></div>
          <div class="news-card-body">
            <div class="news-card-header">
              <i class="bi ${item.icon}" style="color: ${color}" aria-hidden="true"></i>
              <span class="news-date">${formatDate(item.date)}</span>
            </div>
            <h4 class="news-title">${item.title}</h4>
            <p class="news-body">${item.body}</p>
            <span class="news-category" style="color: ${color}; border-color: ${color}">${item.category}</span>
          </div>
        </div>
      `;
    }
    html += '</div>';
    container.innerHTML = html;
  }

  function renderTimeline(items) {
    let html = '<div class="news-timeline">';
    let currentMonth = '';
    for (const item of items) {
      const d = new Date(item.date + 'T00:00:00');
      const monthKey = d.toLocaleDateString('en-US', { month: 'long', year: 'numeric' });
      const color = categoryColor(item.category);
      if (monthKey !== currentMonth) {
        if (currentMonth) html += '</div>';
        currentMonth = monthKey;
        html += `<div class="timeline-month"><h3 class="timeline-month-label">${monthKey}</h3>`;
      }
      html += `
        <div class="timeline-item" data-aos="fade-up">
          <div class="timeline-dot" style="background: ${color}"></div>
          <div class="timeline-content">
            <div class="timeline-header">
              <i class="bi ${item.icon}" style="color: ${color}" aria-hidden="true"></i>
              <span class="news-date">${formatDate(item.date)}</span>
              <span class="news-category" style="color: ${color}; border-color: ${color}">${item.category}</span>
            </div>
            <h4 class="news-title">${item.title}</h4>
            <p class="news-body">${item.body}</p>
          </div>
        </div>
      `;
    }
    if (currentMonth) html += '</div>';
    html += '</div>';
    container.innerHTML = html;
  }

  function render(data) {
    let items = data.slice().sort((a, b) => new Date(b.date) - new Date(a.date));
    items = items.slice(0, maxItems);
    if (layout === 'timeline') renderTimeline(items);
    else renderCards(items);
  }

  // Resolve data path relative to the document so it works from subpages too.
  const dataUrl = new URL('data/news.json', document.baseURI).toString();

  fetch(dataUrl, { cache: 'no-cache' })
    .then(r => { if (!r.ok) throw new Error('HTTP ' + r.status); return r.json(); })
    .then(render)
    .catch(err => {
      console.error('news-feed: fetch failed', err);
      container.innerHTML = '<p style="opacity:0.7;font-size:0.9em">News feed unavailable. ' +
        'Try refreshing, or visit <a href="news.html">News</a>.</p>';
    });
})();
