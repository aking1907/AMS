pageextension 50103 "AMS Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        modify("Serial No.")
        {
            Visible = true;
        }
        addafter("Serial No.")
        {
            field("AMS Truck No."; Rec."AMS Truck No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the AMS Truck No. for the item.';
            }
        }
    }
}
