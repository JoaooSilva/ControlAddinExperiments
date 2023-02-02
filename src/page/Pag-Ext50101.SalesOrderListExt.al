pageextension 60001 "Sales Order List Ext" extends "Sales Order List"
{
    layout
    {
        //JOA002+ 
        addfirst(FactBoxes)
        {
            part(PieChart; "Pie Chart")
            {
                ApplicationArea = All;
            }
        }
        //JOA002-
    }
}
