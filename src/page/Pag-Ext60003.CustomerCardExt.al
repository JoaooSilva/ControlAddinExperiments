pageextension 60003 "Customer Card Ext" extends "Customer Card"
{
    actions
    {
        addfirst(processing)
        {
            //JOA006+ 
            group(Notes)
            {
                Visible = true;
                Image = Notes;
                Caption = 'Customer Notes';
                action("New Note")
                {
                    Caption = 'New Note';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedOnly = true;
                    Image = Note;
                    Visible = true;
                    Scope = Repeater;
                    trigger OnAction()
                    var
                        CustomerNote: Record "Customer Notes";
                        SalesSetup: Record "Sales & Receivables Setup";
                        NoSeriesMgt: Codeunit NoSeriesManagement;
                    begin
                        CustomerNote.Reset();
                        CustomerNote.Init();

                        SalesSetup.Get();
                        CustomerNote."Note No." := NoSeriesMgt.GetNextNo(SalesSetup."Note Nos.", Today, true);
                        CustomerNote."Customer No." := Rec."No.";
                        CustomerNote."Modification Date" := CustomerNote."Creation Date";
                        CustomerNote.Insert();
                        Page.Run(60005, CustomerNote);
                    end;
                }
                action("Customer Notes")
                {
                    Caption = 'Customer Notes';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category9;
                    Image = Notes;
                    Visible = true;
                    Scope = Repeater;
                    trigger OnAction()
                    var
                        CustomerNotes: Record "Customer Notes";
                        CustomerNotesPage: page "Customer Notes List";
                    begin
                        CustomerNotes.SetRange("Customer No.", Rec."No.");
                        CustomerNotesPage.SetTableView(CustomerNotes);
                        CustomerNotesPage.Run();
                    end;
                }
            }
            //JOA006-
        }
    }
}
