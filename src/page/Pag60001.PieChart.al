//JOA002+ 
page 60001 "Pie Chart"
{
    Caption = ' ';
    PageType = CardPart;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            usercontrol(PieChart; "Pie Charts AddIn")
            {
                ApplicationArea = All;
                trigger ControlReady()
                begin
                    CalculateSalesOrderStates();
                end;

                trigger FilterByOpenStatus()
                var
                    SalesHeader: Record "Sales Header";
                    SalesDocumentStatusEnum: Enum "Sales Document Status";
                    SalesDocumentTypeEnum: Enum "Sales Document Type";
                begin
                    SalesHeader.SetFilter(Status, Format(SalesDocumentStatusEnum::Open));
                    SalesHeader.SetFilter("Document Type", Format(SalesDocumentTypeEnum::Order));
                    SalesHeader.SetCurrentKey(Status);
                    SalesHeader.SetAscending(Status, true);
                    Page.RunModal(9305, SalesHeader);
                end;

                trigger FilterByReleasedStatus()
                var
                    SalesHeader: Record "Sales Header";
                    SalesDocumentStatusEnum: Enum "Sales Document Status";
                    SalesDocumentTypeEnum: Enum "Sales Document Type";
                begin
                    SalesHeader.SetFilter(Status, Format(SalesDocumentStatusEnum::Released));
                    SalesHeader.SetFilter("Document Type", Format(SalesDocumentTypeEnum::Order));
                    SalesHeader.SetCurrentKey(Status);
                    SalesHeader.SetAscending(Status, true);
                    Page.RunModal(9305, SalesHeader);
                end;
            }
        }
    }
    procedure CalculateSalesOrderStates()
    var
        SalesHeader: Record "Sales Header";
        SalesDocumentStatusEnum: Enum "Sales Document Status";
        SalesDocumentTypeEnum: Enum "Sales Document Type";
        ReleaseCounter, OpenCounter : Integer;
        JsonA: JsonArray;
        DataA: JsonArray;
    begin
        OpenCounter := 0;
        ReleaseCounter := 0;
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesDocumentTypeEnum::Order);
        if SalesHeader.FindSet() then begin
            repeat
                if SalesHeader.Status = SalesDocumentStatusEnum::Open then begin
                    OpenCounter := OpenCounter + 1;
                end;
                if SalesHeader.Status = SalesDocumentStatusEnum::Released then begin
                    ReleaseCounter := ReleaseCounter + 1;
                end;
            until SalesHeader.Next() = 0;
        end;

        Clear(JsonA);
        JsonA.Add('Status');
        JsonA.Add('Status Value');
        DataA.Add(JsonA);
        Clear(JsonA);
        JsonA.Add('Open');
        JsonA.Add(OpenCounter);
        DataA.Add(JsonA);
        Clear(JsonA);
        JsonA.Add('Released');
        JsonA.Add(ReleaseCounter);
        DataA.Add(JsonA);
        CurrPage.PieChart.PieChart(DataA);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CalculateSalesOrderStates();
    end;

}

//JOA002-