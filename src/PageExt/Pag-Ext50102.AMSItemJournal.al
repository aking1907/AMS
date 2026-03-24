pageextension 50102 "AMS Item Journal" extends "Item Journal"
{
    layout
    {
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
