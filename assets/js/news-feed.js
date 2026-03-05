/**
 * News Feed - Loads and renders lab news/highlights
 * Data is embedded to avoid CORS issues when opening locally via file://
 */
(function () {
  const container = document.getElementById('news-feed');
  if (!container) return;

  const maxItems = parseInt(container.dataset.maxItems) || 100;
  const layout = container.dataset.layout || 'cards';

  const NEWS_DATA = [
    {
      "date": "2026-02-19",
      "title": "Dr. Megan Copeland successfully defends dissertation",
      "body": "Megan Copeland defended her PhD dissertation on February 19th, capping years of research bridging avian genomics, hybrid compatibility, and domestication biology. Congratulations, Dr. Copeland!",
      "category": "lab",
      "icon": "bi-mortarboard"
    },
    {
      "date": "2025-11-30",
      "title": "Megan Copeland wins Ashworth-Tsutsui Memorial Award for Mentoring",
      "body": "Megan Copeland was selected as the 2025\u20132026 recipient of the Ethel Ashworth-Tsutsui Memorial Award for Mentoring from the Texas A&M College of Arts & Sciences.",
      "category": "award",
      "icon": "bi-trophy"
    },
    {
      "date": "2025-08-07",
      "title": "Megan Copeland awarded U.S. Senator Phil Gramm Doctoral Fellowship",
      "body": "Megan Copeland was selected as a 2025 recipient of the prestigious U.S. Senator Phil Gramm Doctoral Fellowship Award, recognizing her outstanding contributions to teaching and research.",
      "category": "award",
      "icon": "bi-trophy"
    },
    {
      "date": "2025-04-11",
      "title": "'Wright Was Right' wins SSE Presidents' Award for Outstanding Dissertation Paper",
      "body": "Our paper on epistasis across more than 1,000 datasets from plants and animals was selected for the 2025 Society for the Study of Evolution Presidents' Award for Outstanding Dissertation Paper \u2014 one of the society's top honors.",
      "category": "award",
      "icon": "bi-trophy"
    },
    {
      "date": "2025-03-08",
      "title": "Alfieri wins AGA Outstanding Student-Authored Paper Award",
      "body": "James Alfieri's cover article in Journal of Heredity on domestication and hybrid compatibility in landfowl was unanimously selected as the Outstanding 2024 Student-Authored Paper by the American Genetic Association.",
      "category": "award",
      "icon": "bi-trophy"
    },
    {
      "date": "2024-11-15",
      "title": "Dr. Jorja Burch successfully defends dissertation",
      "body": "Jorja Burch defended her PhD dissertation on November 15th. Her work provided empirical tests of long-standing evolutionary theory, including the award-winning 'Wright Was Right' paper.",
      "category": "lab",
      "icon": "bi-mortarboard"
    }
  ];

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
              <i class="bi ${item.icon}" style="color: ${color}"></i>
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
              <i class="bi ${item.icon}" style="color: ${color}"></i>
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

  // Sort by date descending
  let items = NEWS_DATA.slice().sort((a, b) => new Date(b.date) - new Date(a.date));

  // Limit
  items = items.slice(0, maxItems);

  if (layout === 'timeline') {
    renderTimeline(items);
  } else {
    renderCards(items);
  }
})();
