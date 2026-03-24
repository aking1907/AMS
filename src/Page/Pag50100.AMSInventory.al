page 50100 "AMS Inventory"
{
    ApplicationArea = All;
    Caption = 'AMS Inventory';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;
    CardPageId = "Item Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the item.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the category that the item belongs to. Item categories also contain any assigned item attributes.';
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item tracking method for the item, such as serial numbers or lot numbers.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                }
                field("AMS Inventory On Quarantine"; Rec."AMS Inventory On Quarantine")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity of the item that is currently in quarantine locations.';
                    StyleExpr = OnQuarantineLocationQtyStyleExpr;
                }
                field("AMS Inventory On WIP"; Rec."AMS Inventory On WIP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity of the item that is currently in WIP locations.';
                }
                field("AMS Inventory On Main"; Rec."AMS Inventory On Main")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity of the item that is currently in main locations.';
                }
                field("AMS Family Category"; Rec."AMS Family Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AMS family category for the item.';
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the base unit used to measure the item, such as piece, box, or pallet. The base unit of measure also serves as the conversion basis for alternate units of measure.';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ConfirmSelection)
            {
                Caption = 'Confirm Selection';
                ApplicationArea = All;
                ToolTip = 'Confirms the selected items for AMS inventory processing.';
                Image = Confirm;
                Visible = ComirmationItemButtonVisible;

                trigger OnAction()
                begin
                    GlobalIsItemConfirmed := true;
                    CurrPage.Close();
                end;
            }
            action(AssemblyBOM)
            {
                AccessByPermission = TableData "BOM Component" = R;
                Caption = 'Assembly BOM';
                Image = BOM;
                RunObject = Page "Assembly BOM";
                RunPageLink = "Parent Item No." = field("No.");
                ToolTip = 'View or edit the bill of material that specifies which items and resources are required to assemble the assembly item.';
            }
            action(BinContent)
            {
                ApplicationArea = All;
                Caption = 'Bin Content';
                Image = BinContent;
                RunObject = Page "Bin Content";
                RunPageLink = "Item No." = field("No.");
                RunPageView = sorting("Item No.");
                ToolTip = 'View the quantities of the item in each bin where it exists. You can see all the important parameters relating to bin content, and you can modify certain bin content parameters in this window.';
            }
        }
        area(Promoted)
        {
            actionref(ConfirmSelection_Promoted; ConfirmSelection) { }
            actionref(AssemblyBOM_Promoted; AssemblyBOM) { }
            actionref(BinContent_Promoted; BinContent) { }
        }
    }

    procedure SetComirmationItemButtonVisible(Visible: Boolean)
    begin
        ComirmationItemButtonVisible := Visible;
    end;

    procedure IsItemConfirmed(): Boolean
    begin
        exit(GlobalIsItemConfirmed);
    end;

    local procedure GetStyleExpr()
    begin
        OnQuarantineLocationQtyStyleExpr := 'Normal';

        if Rec."AMS Inventory On Quarantine" > 0 then
            OnQuarantineLocationQtyStyleExpr := 'Attention';
    end;

    var
        GlobalIsItemConfirmed: Boolean;
        ComirmationItemButtonVisible: Boolean;
        OnQuarantineLocationQtyStyleExpr: Text[30];

}