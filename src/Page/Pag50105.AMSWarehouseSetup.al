page 50105 "AMS Warehouse Setup"
{
    ApplicationArea = All;
    Caption = 'AMS Warehouse Setup';
    PageType = Card;
    SourceTable = "AMS Warehouse Setup";
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Item Jnl. Template Name"; Rec."Item Jnl. Template Name")
                {
                    ToolTip = 'Specifies the value of the Item Jnl. Template Name field.', Comment = '%';
                }
                field("Default Jnl. Batch"; Rec."Default Jnl. Batch")
                {
                    ToolTip = 'Specifies the value of the Default Jnl. Batch field.', Comment = '%';
                }
                field("Transfer Jnl. Batch"; Rec."Transfer Jnl. Batch")
                {
                    ToolTip = 'Specifies the value of the Transfer Jnl. Batch field.', Comment = '%';
                }
                field("Default Location Code"; Rec."Default Location Code")
                {
                    ToolTip = 'Specifies the value of the Default Location Code field.', Comment = '%';
                }
                field("WIP Location Code"; Rec."WIP Location Code")
                {
                    ToolTip = 'Specifies the value of the WIP Location Code field.', Comment = '%';
                }
                field("Quarantine Location Code"; Rec."Quarantine Location Code")
                {
                    ToolTip = 'Specifies the value of the Quarantine Location Code field.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.FindFirst() then
            Rec.Insert();
    end;
}
