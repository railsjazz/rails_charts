(function() {
  window.RailsCharts = window.RailsCharts || {};
  window.RailsCharts.loadedThemes = window.RailsCharts.loadedThemes || [];

  window.RailsCharts.loadTheme = function(themeName) {
    document.addEventListener('DOMContentLoaded', () => {
      if (typeof echarts === 'undefined') {
        console.error('ECharts is not loaded. Please ensure echarts.js is included.');
        return;
      }

      if (window.RailsCharts.loadedThemes.includes(themeName)) {
        console.warn(`Theme '${themeName}' is already loaded.`);
        return;
      }

      const script = document.createElement('script');
      script.type = 'text/javascript';
      script.src = `/assets/echarts/theme/${themeName}.js`;
      script.onload = () => {
        console.log(`Theme '${themeName}' loaded successfully.`);
      };
      script.onerror = () => {
        console.error(`Failed to load theme: /assets/echarts/theme/${themeName}.js`);
      };
      document.head.appendChild(script);
    });
  };
})();
