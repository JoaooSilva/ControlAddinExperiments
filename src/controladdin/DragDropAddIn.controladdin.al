//JOA004+ 
controladdin "Drag and Drop AddIn"
{
    RequestedHeight = 280;

    MinimumWidth = 100;
    MaximumWidth = 400;

    VerticalShrink = true;
    VerticalStretch = true;
    HorizontalShrink = true;
    HorizontalStretch = true;

    StartupScript = 'src\script\ControlReady_startup.js';

    Scripts = 'src\script\DragDropScript.js', 'https://code.jquery.com/jquery-3.6.0.min.js';
    StyleSheets = 'src\stylesheet\DragDrop.stylesheet.css';

    event ControlReady();
    procedure embedDragDropBox();
    procedure DeleteBox();

    event GetFileContent(curr_file: Text);
}
//JOA004-