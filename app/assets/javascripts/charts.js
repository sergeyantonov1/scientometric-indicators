var ctx = document.getElementById('myChart').getContext('2d');

/* var myChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
    datasets: [{
      label: '# of Votes',
      data: [12, 19, 3, 5, 2, 3],
      backgroundColor: [
        'rgba(255, 99, 132, 0.2)',
        'rgba(54, 162, 235, 0.2)',
        'rgba(255, 206, 86, 0.2)',
        'rgba(75, 192, 192, 0.2)',
        'rgba(153, 102, 255, 0.2)',
        'rgba(255, 159, 64, 0.2)'
      ],
      borderColor: [
        'rgba(255, 99, 132, 1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(75, 192, 192, 1)',
        'rgba(153, 102, 255, 1)',
        'rgba(255, 159, 64, 1)'
      ],
      borderWidth: 1
    }]
  },
  options: {
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero: true
        }
      }]
    }
  }
}); */

var mixedChart = new Chart(ctx, {
  type: 'bar',
  data: {
    datasets: [{
      label: 'Zuev Denis (publications)',
      data: [10, 20, 30, 40],
      type: 'bar',
    }, {
      label: 'Mish (citations)',
      data: [35, 40, 20, 10],
      type: 'bar',
      backgroundColor: "#1da2d1"
    }, {
      label: 'Antonov',
      data: [35, 40, 20, 10],
      type: 'bar',
      backgroundColor: "86878f"
    }
  ],
    labels: ['2010', '2012', '2013', '2014', '2015', '2016']
  },
  options: {
    tooltips: {
      mode: 'point'
    },
  }
});