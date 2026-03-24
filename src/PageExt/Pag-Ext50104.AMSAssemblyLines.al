pageextension 50104 "AMS Assembly Order Subform" extends "Assembly Order Subform" //901
{
    layout
    {
        modify("Variant Code")
        {
            Visible = false;
        }
        addafter(Description)
        {
            field("AMS Item Tracking Code"; Rec."AMS Item Tracking Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the AMS Item Tracking Code for the item.';
            }
        }
    }
}
