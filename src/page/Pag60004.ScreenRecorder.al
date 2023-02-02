//JOA005+ 
page 60004 "Screen Recorder"
{
    Caption = 'Bug reporting';
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            usercontrol(ScreenRecorderControlAddIn; "Screen Recorder AddIn")
            {
                ApplicationArea = All;
                trigger ControlReady()
                begin
                end;

                trigger ChangeButtonsStateCancelClick()
                begin
                    //Se este evento for invocado é porque por algum motivo (opção cancelar incluida) não vamos começar a gravar
                    ButtonsVisibility_InitSates();
                end;

                trigger ChangeButtonsStateStartClick()
                begin
                    ButtonsVisibility_ClickedStart();
                end;

                trigger ChangeButtonsStateStopClick()
                begin
                    ButtonsVisibility_ClickedStop();
                end;

                trigger ChangeButtonsStateDownloadOrAttachClick()
                begin
                    ButtonsVisibility_ClickedDownloadOrAttach();
                end;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(ScreenRecorder)
            {
                Visible = true;
                Caption = 'Record screen';
                ToolTip = 'Record screen to show bugs and send them to Arquiconsult so we can fix them';
                action(StartRecord)
                {
                    Caption = 'Start screen recording';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Image = Start;
                    Visible = StartRecordingVisibility;
                    trigger OnAction()
                    var
                        Answer: Boolean;
                    begin
                        CurrPage.ScreenRecorderControlAddIn.startRecord();
                    end;
                }
                action(StopRecord)
                {
                    Caption = 'Stop screen recording';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Image = Stop;
                    Visible = StopRecordingVisibility;
                    trigger OnAction()
                    begin
                        CurrPage.ScreenRecorderControlAddIn.stopScreen();
                    end;
                }
                action(DownloadVideo)
                {
                    Caption = 'Download video';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Image = Download;
                    Visible = DownloadVisibility;
                    trigger OnAction()
                    begin
                        CurrPage.ScreenRecorderControlAddIn.downloadVideo();
                    end;
                }
            }
        }
    }

    procedure ButtonsVisibility_ClickedStart()
    begin
        StartRecordingVisibility := false;
        StopRecordingVisibility := true;
        AttachmentVisibility := false;
        DownloadVisibility := false;
    end;

    procedure ButtonsVisibility_ClickedStop()
    begin
        StartRecordingVisibility := true;
        StopRecordingVisibility := false;
        DownloadVisibility := true;
        AttachmentVisibility := true;
    end;

    procedure ButtonsVisibility_ClickedDownloadOrAttach()
    begin
        StartRecordingVisibility := true;
        StopRecordingVisibility := false;
        DownloadVisibility := true;
        AttachmentVisibility := true;
    end;

    procedure ButtonsVisibility_InitSates()
    begin
        StartRecordingVisibility := true;
        StopRecordingVisibility := false;
        DownloadVisibility := false;
        AttachmentVisibility := false;
    end;

    trigger OnOpenPage()
    begin
        ButtonsVisibility_InitSates();
    end;

    var
        FromDisplayName: Text;
        EditorReady: Boolean;
        LastText: Text;
        EmailSubjectField: Text[100];
        EmailCCField: Text[100];
        EmailReceiptField: Text[50];
        StartRecordingVisibility, StopRecordingVisibility, DownloadVisibility : boolean;
        AttachmentVisibility: Boolean;
        //
        EmailBody, EmailSubject : Text;
}

//JOA005-