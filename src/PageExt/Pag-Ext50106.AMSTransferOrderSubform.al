pageextension 50106 "AMS Transfer Order Subform" extends "Transfer Order Subform"
{
    layout
    {
        modify("Variant Code")
        {
            Visible = false;
        }
        modify("Transfer-from Bin Code")
        {
            Visible = true;
        }
        modify("Transfer-to Bin Code")
        {
            Visible = true;
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
