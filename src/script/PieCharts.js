//JOA002+ 
function PieChart(DataJson)
{
    console.log(DataJson);
    google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable(DataJson);

        var options = {
          title:'Sales Order Status Statistics',
          fontName: 'Segoe UI',
          width: 380,
          is3D: true,
          slices: {
            0: {color: '#dc3912'},
            1: {color: '#109618', offset: 0.12}
          },
          legend: {
            textStyle: {
              fontName: 'Segoe UI',
              color: '#6f6f6f'
            }
          },
          titleTextStyle: {
            fontName: 'Segoe UI',
            color: '#6f6f6f',
            bold: true,
          }
        };

        var chart = new google.visualization.PieChart(document.getElementById('controlAddIn'));

        function selectHandler() {
            debugger;
            var selectedItem = chart.getSelection()[0];
            if (selectedItem) {
                var value = data.getValue(selectedItem.row, 0);
                if (value == 'Released') {
                    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('FilterByReleasedStatus', []);
                } else {
                    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('FilterByOpenStatus', []);
                }
            }
        }
        google.visualization.events.addListener(chart, 'select', selectHandler);
        chart.draw(data, options);
    }
}
//JOA002-