page 50106 "AMS RS Posted WH Operations"
{
    ApplicationArea = All;
    Caption = 'AMS RS Posted WH Operations';
    PageType = ListPart;
    SourceTable = "Item Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the type of item ledger entry, such as a positive or negative adjustment, sale, or transfer.';
                }
                field("No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item.';
                }
                field("Posted Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the item ledger entry was posted.';
                }
                field("Quantity"; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity of items in the item ledger entry.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the code of the location where the item is stored.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter(SystemCreatedAt, '>=%1', CreateDateTime(WorkDate(), 0T));
    end;
}
