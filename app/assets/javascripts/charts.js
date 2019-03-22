var ctx = document.getElementById('myChart').getContext('2d');

var mixedChart = new Chart(ctx, {
  type: 'bar',
  data: {
    datasets: window.__DATA__.datasets,
    labels: window.__DATA__.labels,
  },
  options: {
    tooltips: {
      mode: 'point'
    },
  }
});
