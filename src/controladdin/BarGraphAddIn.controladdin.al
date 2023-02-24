controladdin "Bar Graph Add-In"
{
    HorizontalShrink = true;
    HorizontalStretch = true;
    RequestedHeight = 500;

    StartupScript = 'src\script\ControlReady_startup.js';
    Scripts = 'src\script\BarChartsScript.js',
    'https://www.gstatic.com/charts/loader.js';

    event ControlReady();

    event OpenSalesOrders();
    event OpenSalesQuotes();
    event OpenSalesInvoices();
    event OpenPostedSalesInvoices();

    procedure barGraph(DataJson: JsonArray);
}

