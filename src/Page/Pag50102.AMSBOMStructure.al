page 50102 "AMS BOM Structure"
{
    ApplicationArea = All;
    Caption = 'AMS BOM Structure';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "BOM Buffer";
    SourceTableTemporary = true;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                IndentationColumn = Rec.Indentation;
                ShowAsTree = true;
                field(Type; Rec.Type)
                {
                    StyleExpr = GlobalNoStyleExpr;
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item''s position in the BOM structure. Lower-level items are indented under their parents.';
                }
                field("No."; Rec."No.")
                {
                    StyleExpr = GlobalNoStyleExpr;
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    StyleExpr = GlobalNoStyleExpr;
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the item''s description.';
                }
                field("Qty. per Parent"; Rec."Qty. per Parent")
                {
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ToolTip = 'Specifies how many units of the component are required to assemble or produce one unit of the parent.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field("AMS Inventory On Quarantine"; GlobalItem."AMS Inventory On Quarantine")
                {
                    Caption = 'On Quarantine Qty.';
                    Editable = false;
                    ApplicationArea = All;
                    StyleExpr = OnQuarantineLocationQtyStyleExpr;
                    ToolTip = 'Specifies the quantity of the item that is currently in quarantine locations.';
                }
                field("AMS Inventory On Main"; GlobalItem."AMS Inventory On Main")
                {
                    Caption = 'On Main Qty.';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity of the item that is currently in main locations.';
                }
                field("Qty. per Top Item"; Rec."Qty. per Top Item")
                {
                    Editable = false;
                    Caption = 'Qty. to Produce';
                    ToolTip = 'Specifies the Qty. to Produce of the item that can be produced based on the current inventory.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if GlobalItem.Get(Rec."No.") then
            GlobalItem.CalcFields(Inventory, "AMS Inventory On Quarantine", "AMS Inventory On Main");

        GetStyleExpr();
    end;

    procedure RecalculateBOMTree(ItemNo: Code[20]; ParentItemNo: Code[20]; var QtyToProduce: Integer; var EntryNo: Integer; Level: Integer)
    var
        Item: Record Item;
        BOMComponent: Record "BOM Component";
        ChildBOMComponent: Record "BOM Component";
        CalculateBOMTree: Codeunit "Calculate BOM Tree";
        ChildItemQtyToProduce: Integer;
        OnHoldEntryNo: Integer;
    begin
        AMSWarehouseSetup.Get();
        AMSWarehouseSetup.TestField("Default Location Code");
        AMSWarehouseSetup.TestField("Quarantine Location Code");

        QtyToProduce := -1;

        if EntryNo = 0 then begin
            Rec.Reset();
            if Rec.FindSet() then
                Rec.DeleteAll();
        end;

        BOMComponent.SetRange("Parent Item No.", ItemNo);
        BOMComponent.SetRange(Type, BOMComponent.Type::Item);
        BOMComponent.SetFilter("Quantity per", '>0');
        if BOMComponent.FindSet() then
            repeat
                EntryNo += 1;
                Item.SetRange("No.", BOMComponent."No.");
                Item.SetRange("Location Filter", AMSWarehouseSetup."Default Location Code");
                Item.FindFirst();
                Item.CalcFields(Inventory);
                Rec.Init();
                Rec.Indentation := Level;
                Rec."Entry No." := EntryNo;
                Rec.Type := Rec.Type::Item;
                Rec."No." := Item."No.";
                Rec.Description := Item.Description;
                Rec."Qty. per Parent" := BOMComponent."Quantity per";
                Rec."Production BOM No." := ParentItemNo;
                Rec."Unit of Measure Code" := BOMComponent."Unit of Measure Code";
                Rec."Qty. per BOM Line" := Item.Inventory;
                Rec."Is Leaf" := false;
                Rec.Insert();

                ChildBOMComponent.SetRange("Parent Item No.", BOMComponent."No.");
                ChildBOMComponent.SetRange(Type, ChildBOMComponent.Type::Item);
                if ChildBOMComponent.FindFirst() then begin
                    ChildItemQtyToProduce := 0;
                    OnHoldEntryNo := EntryNo;
                    RecalculateBOMTree(BOMComponent."No.", ItemNo, ChildItemQtyToProduce, EntryNo, Level + 1);
                    Rec.Get(OnHoldEntryNo);
                    Rec."Qty. per Top Item" := ChildItemQtyToProduce;
                    Rec."Is Leaf" := true;
                    Rec.Modify();
                end else begin
                    Rec."Qty. per Top Item" := Item.Inventory div BOMComponent."Quantity per";
                    Rec.Modify();
                end;

                if QtyToProduce < 0 then
                    QtyToProduce := Rec."Qty. per Top Item"
                else if Rec."Qty. per Top Item" < QtyToProduce then
                    QtyToProduce := Rec."Qty. per Top Item";

            until BOMComponent.Next() = 0;

        if Rec.FindFirst() then;
    end;

    local procedure GetStyleExpr()
    begin
        GlobalNoStyleExpr := 'Normal';
        OnQuarantineLocationQtyStyleExpr := 'Normal';

        if Rec."Is Leaf" then
            GlobalNoStyleExpr := 'Strong';

        if GlobalItem."AMS Inventory On Quarantine" > 0 then
            OnQuarantineLocationQtyStyleExpr := 'Attention';
    end;

    var
        AMSWarehouseSetup: Record "AMS Warehouse Setup";
        GlobalItem: Record Item;
        GlobalNoStyleExpr: Text[30];
        OnQuarantineLocationQtyStyleExpr: Text[30];
}
