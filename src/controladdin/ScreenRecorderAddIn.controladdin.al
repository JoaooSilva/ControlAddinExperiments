//JOA005+ 
controladdin "Screen Recorder AddIn"
{
    RequestedHeight = 450;
    RequestedWidth = 788;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts = 'src\script\ScreenRecorderScript.js';
    StartupScript = 'src\script\ControlReady_startup.js';

    event ControlReady()
    event ChangeButtonsStateCancelClick()
    event ChangeButtonsStateStopClick()
    event ChangeButtonsStateStartClick()
    event ChangeButtonsStateDownloadOrAttachClick()
    //retornar attachment
    event AttachmentReady(attachmentLocation: Text)


    procedure addScreenRecorder()
    procedure startRecord()
    procedure stopScreen()
    procedure downloadVideo()
    procedure receiveAttachment()
}
//JOA005-