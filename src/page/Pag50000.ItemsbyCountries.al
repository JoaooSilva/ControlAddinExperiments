//JOA001+ 
page 60000 "Items by Countries"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Item;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    Caption = 'Items by country';
    layout
    {
        area(Content)
        {
            repeater(rep)
            {
                Caption = 'Select item';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    TableRelation = Item;
                    Editable = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                    Editable = false;
                }
            }
            group(Charts2)
            {
                ShowCaption = false;
                usercontrol(Chart; "Countries Chart AddIn")
                {
                    ApplicationArea = all;
                    trigger ControlReady()
                    begin
                        CalculateItemsPerCountry(Rec."No.");
                    end;
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {

            action(Refresh)
            {
                Caption = 'Refresh';
                Image = Refresh;
                ApplicationArea = All;
                ToolTip = 'Calculates number of sold items by country';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Clear(DataA);
                    Clear(JsonA);
                    CalculateItemsPerCountry(Rec."No.");
                end;
            }
        }
    }

    procedure CalculateItemsPerCountry(itemNo: Code[20])
    var
        SalesInvHdr: Record "Sales Invoice Header";
        SalesInvLn: Record "Sales Invoice Line";
        CountryCode: Code[2];
        NrOfItems: Integer;

        tempList: Dictionary of [Code[2], Integer];
        tempNrItems: Integer;
        keys: List of [code[2]];
        counter: Integer;
    begin
        SalesInvLn.Reset();
        SalesInvLn.Init();
        SalesInvLn.SetRange("No.", itemNo);
        if SalesInvLn.FindFirst() then begin
            repeat
                SalesInvHdr.Reset();
                SalesInvHdr.Init();
                if SalesInvHdr.Get(SalesInvLn."Document No.") then begin
                    CountryCode := SalesInvHdr."Sell-to Country/Region Code";
                    NrOfItems := SalesInvLn.Quantity;
                    if tempList.ContainsKey(CountryCode) then begin
                        tempNrItems := tempList.Get(CountryCode);
                        tempList.Set(CountryCode, tempNrItems + NrOfItems);
                    end else
                        tempList.Add(CountryCode, NrOfItems);
                end
            until SalesInvLn.Next() = 0;
        end;

        clear(JsonA);
        JsonA.Add('Country');
        JsonA.Add('Nº of items');
        DataA.Add(JsonA);

        keys := tempList.Keys;
        for counter := 1 to keys.Count do begin
            Clear(JsonA);
            JsonA.Add(keys.Get(counter));
            JsonA.Add(tempList.Get(keys.Get(counter)));
            DataA.Add(JsonA);
        end;
        CurrPage.Chart.GeographicGraph(DataA);
    end;

    var
        DataA: JsonArray;
        JsonA: JsonArray;
}

//JOA001-