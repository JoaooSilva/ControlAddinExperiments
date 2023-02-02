pageextension 60000 "Item List Ext" extends "Item List"
{
    layout
    {
        //JOA004+ 
        addfirst(factboxes)
        {
            part(DragAndDrop2; "Drag And Drop")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
        }
        //JOA004-
    }
    actions
    {
        addafter("Item Refe&rences")
        {
            //JOA001+ 
            action(ViewItemsByCountry)
            {
                Caption = 'Item per countries 2';
                ApplicationArea = Suite, ItemReferences;
                Image = Map;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = page "Items by Countries";
                RunPageMode = View;
                RunPageOnRec = true;
            }
            //JOA001-
        }
    }
}
