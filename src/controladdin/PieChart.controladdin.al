//JOA002+ 
controladdin "Pie Charts AddIn"
{
    StartupScript = 'src\script\ControlReady_startup.js';
    Scripts = 'src\script\PieCharts.js', 'https://www.gstatic.com/charts/loader.js';
    HorizontalStretch = true;
    VerticalStretch = true;
    RequestedHeight = 200;
    RequestedWidth = 320;

    event ControlReady();
    event FilterByReleasedStatus()
    event FilterByOpenStatus()

    procedure PieChart(DataJson: JsonArray);
}
//JOA002-