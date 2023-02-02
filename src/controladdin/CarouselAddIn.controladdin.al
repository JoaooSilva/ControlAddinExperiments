//JOA003+ 
controladdin "Carousel AddIn"
{
    HorizontalStretch = true;
    RequestedHeight = 200;

    // JS files required for Bootstrap
    Scripts = 'https://code.jquery.com/jquery-3.5.1.slim.min.js',
        'https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js',
        'https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js',
        'src\script\CarouselScript.js';


    StartupScript = 'src\script\ControlReady_startup.js';

    // Bootstrap css
    StyleSheets = 'https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css';

    procedure SetCarouselData(Data: JsonObject);
    event ControlReady();
}
//JOA003-