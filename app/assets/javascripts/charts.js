var chart = document.getElementById('myChart')

if (typeof(chart) != 'undefined' && chart != null)
{
  var ctx = chart.getContext('2d');

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
}

