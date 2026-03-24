page 50101 "AMS Assembly Overview List"
{
    ApplicationArea = All;
    Caption = 'AMS Assembly Overview List';
    PageType = ListPlus;
    SourceTable = Item;
    UsageCategory = Administration;
    SourceTableTemporary = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies a description of the item.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the code of the item category to which the item belongs.';
                }
                field(Inventory; Rec.Inventory)
                {
                    Editable = false;
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                }
                field("Maximum Inventory"; Rec."Maximum Inventory")
                {
                    Editable = false;
                    Caption = 'Qty. to Produce';
                    ToolTip = 'Specifies the Qty. to Produce of the item that can be produced based on the current inventory.';
                }
            }
            part(AMSBOMStructure; "AMS BOM Structure")
            {
                ApplicationArea = All;
                UpdatePropagation = Both;
                SubPageLink = "Production BOM No." = field("No.");
            }
        }

    }

    trigger OnOpenPage()
    begin
        AMSWarehouseSetup.Get();
        AMSWarehouseSetup.TestField("Default Location Code");
        Rec.SetRange("Location Filter", AMSWarehouseSetup."Default Location Code");

        InitItemsWithAssemblyBOM();
    end;

    local procedure InitItemsWithAssemblyBOM()
    var
        Item: Record Item;
        EntryNo: Integer;
        QtyToProduce: Integer;
    begin
        Item.SetRange("Location Filter", AMSWarehouseSetup."Default Location Code");
        Item.SetRange("AMS Assembly Monitoring", true);

        if Item.FindSet() then
            repeat
                QtyToProduce := 0;
                Rec := Item;
                Rec.Insert();
                CurrPage.AMSBOMStructure.Page.RecalculateBOMTree(Rec."No.", Rec."No.", QtyToProduce, EntryNo, 0);

                Rec."Maximum Inventory" := QtyToProduce;
                Rec.Modify();
            until Item.Next() = 0;

        if Rec.FindFirst() then;
    end;

    var
        AMSWarehouseSetup: Record "AMS Warehouse Setup";
}
