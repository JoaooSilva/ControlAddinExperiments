//JOA001+ 
controladdin "Countries Chart AddIn"
{
    StartupScript = 'src\script\ControlReady_startup.js';
    Scripts = 'src\script\CountriesChartScript,js', 'https://www.gstatic.com/charts/loader.js';
    HorizontalStretch = true;
    VerticalStretch = true;
    RequestedHeight = 490;
    RequestedWidth = 797;

    event ControlReady();

    procedure GeographicGraph(DataJson: JsonArray);
}
//JOA001-