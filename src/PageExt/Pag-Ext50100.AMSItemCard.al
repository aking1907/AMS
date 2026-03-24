pageextension 50100 "AMS Item Card" extends "Item Card" //30
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
            field("AMS Assembly Monitoring"; Rec."AMS Assembly Monitoring")
            {
                ApplicationArea = All;
                Caption = 'AMS Assembly Monitoring';
                ToolTip = 'Indicates whether assembly monitoring is enabled for the item.';
            }
        }
    }
}
