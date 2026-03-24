pageextension 50101 "AMS Item List" extends "Item List"
{
    layout
    {
        addafter("Item Category Code")
        {
            field("AMS Family Category"; Rec."AMS Family Category")
            {
                ApplicationArea = All;
                Caption = 'AMS Family Category';
                ToolTip = 'Specifies the AMS family category for the item.';
            }
        }
    }
}
