page 50108 "AMS Transfer Journal"
{
    ApplicationArea = All;
    Caption = 'AMS Transfer Journal';
    PageType = List;
    SourceTable = "Item Journal Line";
    UsageCategory = Lists;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Warehouse Operations';
                field("New Item No."; TempGlobalItemJournalLine."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the unique identifier for the item.';
                    TableRelation = Item."No.";

                    trigger OnAssistEdit()
                    var
                        Item: Record "Item";
                        ItemListPage: Page "AMS Inventory";
                    begin
                        ItemListPage.Editable(false);
                        ItemListPage.SetComirmationItemButtonVisible(true);
                        ItemListPage.RunModal();

                        if not ItemListPage.IsItemConfirmed() then exit;

                        ItemListPage.GetRecord(Item);

                        if (TempGlobalItemJournalLine."Item No." <> '') and (TempGlobalItemJournalLine."Item No." <> Item."No.") then
                            if not Confirm('Do you want to overwrite the existing Item No. and related fields?', false) then exit;

                        TempGlobalItemJournalLine.Validate("Item No.", Item."No.");
                        TempGlobalItemJournalLine.Description := Item.Description;
                        TempGlobalItemJournalLine."Unit of Measure Code" := Item."Base Unit of Measure";
                        TempGlobalItemJournalLine.Quantity := 0;

                        if GlobalItem.Get(TempGlobalItemJournalLine."Item No.") then;
                    end;

                    trigger OnValidate()
                    var
                        Item: Record "Item";
                    begin
                        if TempGlobalItemJournalLine."Item No." = '' then begin
                            TempGlobalItemJournalLine.Description := '';
                            TempGlobalItemJournalLine."Unit of Measure Code" := '';
                        end else begin
                            if TempGlobalItemJournalLine.Description <> '' then
                                if not Confirm('Do you want to overwrite the existing Item No. and related fields?', false) then exit;

                            Item.Get(TempGlobalItemJournalLine."Item No.");
                            TempGlobalItemJournalLine.Description := Item.Description;
                            TempGlobalItemJournalLine."Unit of Measure Code" := Item."Base Unit of Measure";
                            TempGlobalItemJournalLine.Quantity := 0;

                            if GlobalItem.Get(TempGlobalItemJournalLine."Item No.") then;
                        end;
                    end;
                }
                field(NewDescription; TempGlobalItemJournalLine.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Specifies the description of the item.';
                }
                field("Location From"; TempGlobalItemJournalLine."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location From';
                    ToolTip = 'Specifies the code of the location where the item is stored.';
                    TableRelation = Location.Code;

                    trigger OnValidate()
                    begin
                        TempGlobalItemJournalLine."Bin Code" := '';
                    end;
                }
                field("Bin Code From"; TempGlobalItemJournalLine."Bin Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bin Code From';
                    ToolTip = 'Specifies the code of the bin where the item is stored.';
                    Editable = true;

                    trigger OnValidate()
                    var
                        Bin: Record Bin;
                    begin
                        if not Bin.Get(TempGlobalItemJournalLine."Location Code", TempGlobalItemJournalLine."Bin Code") then
                            Error('Bin "%1" does not exist in Location "%2".', TempGlobalItemJournalLine."Bin Code", TempGlobalItemJournalLine."Location Code");
                    end;

                    trigger OnDrillDown()
                    var
                        BinContent: Record "Bin Content";
                        BinContentPage: Page "Bin Content";
                    begin
                        BinContent.SetRange("Item No.", TempGlobalItemJournalLine."Item No.");
                        BinContent.SetRange("Location Code", TempGlobalItemJournalLine."Location Code");

                        BinContentPage.SetTableView(BinContent);
                        BinContentPage.LookupMode(true);
                        if BinContentPage.RunModal() <> Action::LookupOK then exit;

                        BinContentPage.GetRecord(BinContent);
                        TempGlobalItemJournalLine.Validate("Bin Code", BinContent."Bin Code");
                    end;
                }
                field("Location To"; TempGlobalItemJournalLine."New Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location To';
                    ToolTip = 'Specifies the code of the location where the item is stored.';
                    TableRelation = Location.Code;

                    trigger OnValidate()
                    begin
                        TempGlobalItemJournalLine."New Bin Code" := '';
                    end;
                }
                field("Bin Code To"; TempGlobalItemJournalLine."New Bin Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bin Code To';
                    ToolTip = 'Specifies the code of the bin where the item is stored.';
                    Editable = true;

                    trigger OnValidate()
                    var
                        Bin: Record Bin;
                    begin
                        if not Bin.Get(TempGlobalItemJournalLine."New Location Code", TempGlobalItemJournalLine."New Bin Code") then
                            Error('Bin "%1" does not exist in Location "%2".', TempGlobalItemJournalLine."New Bin Code", TempGlobalItemJournalLine."New Location Code");
                    end;

                    trigger OnDrillDown()
                    var
                        Bin: Record Bin;
                        BinListPage: Page "Bin List";
                    begin
                        Bin.SetRange("Location Code", TempGlobalItemJournalLine."New Location Code");

                        BinListPage.SetTableView(Bin);
                        BinListPage.LookupMode(true);
                        if BinListPage.RunModal() <> Action::LookupOK then exit;

                        BinListPage.GetRecord(Bin);
                        TempGlobalItemJournalLine.Validate("New Bin Code", Bin.Code);
                    end;
                }
                field("New Quantity"; TempGlobalItemJournalLine.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    ToolTip = 'Specifies the quantity of the item in the journal line.';
                }
                field("New Unit of Measure Code"; TempGlobalItemJournalLine."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Caption = 'Unit of Measure Code';
                    ToolTip = 'Specifies the unit of measure for the item.';
                }
                field("New Serial No."; TempGlobalItemJournalLine."Serial No.")
                {
                    ApplicationArea = All;
                    Caption = 'Serial No.';
                    ToolTip = 'Specifies theSerial No. for the item.';
                    Editable = SNEditable;
                    ShowMandatory = SNEditable;
                }
                field("New AMS Plate No."; TempGlobalItemJournalLine."AMS Truck No.")
                {
                    ApplicationArea = All;
                    Caption = 'AMS Plate No.';
                    ToolTip = 'Specifies the AMS Car Plate No. for the item.';
                }
            }
            repeater(Details)
            {
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of item journal line, such as a positive or negative adjustment.';
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the item.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the item.';
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location From';
                    ToolTip = 'Specifies the code of the location where the item is stored.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bin From';
                    ToolTip = 'Specifies the code of the bin where the item is stored.';

                    trigger OnDrillDown()
                    var
                        BinContent: Record "Bin Content";
                        BinContentPage: Page "Bin Content";
                    begin
                        BinContent.SetRange("Item No.", Rec."Item No.");
                        BinContent.SetRange("Location Code", Rec."Location Code");

                        BinContentPage.SetTableView(BinContent);
                        BinContentPage.LookupMode(true);
                        if BinContentPage.RunModal() <> Action::LookupOK then exit;

                        BinContentPage.GetRecord(BinContent);
                        Rec.Validate("Bin Code", BinContent."Bin Code");
                    end;
                }
                field("New Location Code"; Rec."New Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location To';
                    ToolTip = 'Specifies the code of the location where the item is stored.';
                }
                field("New Bin Code"; Rec."New Bin Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bin To';
                    ToolTip = 'Specifies the code of the bin where the item is stored.';
                }
                field("Quantity"; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity of the item in the journal line.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit of measure for the item.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Serial No. for the item.';
                    Editable = SNEditable;
                }
                field("AMS Plate No."; Rec."AMS Truck No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AMS Car Plate No. for the item.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post';
                ApplicationArea = All;
                ToolTip = 'Posts the selected items from the journal lines.';
                Image = Post;
                trigger OnAction()
                var
                    ItemJournalLine: Record "Item Journal Line";
                    CUItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
                begin
                    ItemJournalLine.SetRange("Journal Template Name", AMSWarehouseSetup."Item Jnl. Template Name");
                    ItemJournalLine.SetRange("Journal Batch Name", AMSWarehouseSetup."Transfer Jnl. Batch");

                    if not ItemJournalLine.FindSet() then exit;
                    Codeunit.Run(Codeunit::"Item Jnl.-Post", ItemJournalLine);

                    CurrPage.Update(false);
                end;
            }
            action(ConfirmSelection)
            {
                Caption = 'Confirm Selection';
                ApplicationArea = All;
                ToolTip = 'Confirms the selected items for AMS inventory processing.';
                Image = Confirm;

                trigger OnAction()
                var
                    ItemJournalLine: Record "Item Journal Line";
                    LineNo: Integer;
                begin
                    if TempGlobalItemJournalLine."Item No." = '' then Error('Item No. cannot be empty.');
                    if TempGlobalItemJournalLine."Location Code" = '' then Error('Location Code cannot be empty.');
                    if TempGlobalItemJournalLine.Quantity = 0 then Error('Quantity cannot be zero.');
                    if TempGlobalItemJournalLine."Unit of Measure Code" = '' then Error('Unit of Measure Code cannot be empty.');
                    if (TempGlobalItemJournalLine."Serial No." = '') and SNEditable then Error('Serial No. must not be empty for Item No. %1.', TempGlobalItemJournalLine."Item No.");

                    AMSWarehouseSetup.Get;
                    AMSWarehouseSetup.TestField("Item Jnl. Template Name");
                    AMSWarehouseSetup.TestField("Transfer Jnl. Batch");
                    ItemJournalLine.SetRange("Journal Template Name", AMSWarehouseSetup."Item Jnl. Template Name");
                    ItemJournalLine.SetRange("Journal Batch Name", AMSWarehouseSetup."Transfer Jnl. Batch");
                    if ItemJournalLine.FindLast() then;

                    LineNo := ItemJournalLine."Line No." + 10000;
                    ItemJournalLine.Init();
                    ItemJournalLine."Journal Template Name" := AMSWarehouseSetup."Item Jnl. Template Name";
                    ItemJournalLine."Journal Batch Name" := AMSWarehouseSetup."Transfer Jnl. Batch";
                    ItemJournalLine."Line No." := LineNo;
                    ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Transfer;
                    ItemJournalLine."Posting Date" := WorkDate();
                    ItemJournalLine."Document No." := Format(WorkDate(), 0, '<Year4><Month,2><Day,2>');
                    ItemJournalLine.Validate("Item No.", TempGlobalItemJournalLine."Item No.");
                    ItemJournalLine.Validate("Location Code", TempGlobalItemJournalLine."Location Code");
                    ItemJournalLine.Validate("Bin Code", TempGlobalItemJournalLine."Bin Code");
                    ItemJournalLine.Validate("New Location Code", TempGlobalItemJournalLine."New Location Code");
                    ItemJournalLine.Validate("New Bin Code", TempGlobalItemJournalLine."New Bin Code");
                    ItemJournalLine.Validate(Quantity, Abs(TempGlobalItemJournalLine.Quantity));
                    ItemJournalLine.Validate("Unit of Measure Code", TempGlobalItemJournalLine."Unit of Measure Code");
                    if SNEditable then
                        ItemJournalLine.Validate("Serial No.", TempGlobalItemJournalLine."Serial No.");
                    ItemJournalLine.Validate("AMS Truck No.", TempGlobalItemJournalLine."AMS Truck No.");
                    ItemJournalLine.Insert();

                    TempGlobalItemJournalLine."Item No." := '';
                    TempGlobalItemJournalLine.Description := '';
                    TempGlobalItemJournalLine."Unit of Measure Code" := '';
                    TempGlobalItemJournalLine.Quantity := 0;

                    Clear(GlobalItem);
                    CurrPage.Update(false);
                end;
            }
        }
        area(Promoted)
        {
            actionref(ConfirmSelection_Promoted; ConfirmSelection) { }
        }
    }

    trigger OnOpenPage()
    begin
        AMSWarehouseSetup.Get();
        Rec.SetRange("Journal Template Name", AMSWarehouseSetup."Item Jnl. Template Name");
        Rec.SetRange("Journal Batch Name", AMSWarehouseSetup."Transfer Jnl. Batch");

        InitTempGlobalItemJournalLine();
    end;

    trigger OnAfterGetRecord()
    begin
        if GlobalLineItem.Get(Rec."Item No.") then;
    end;

    local procedure InitTempGlobalItemJournalLine()
    begin
        TempGlobalItemJournalLine.Init();
        TempGlobalItemJournalLine."Location Code" := AMSWarehouseSetup."Default Location Code";
        TempGlobalItemJournalLine.Validate("Journal Template Name", AMSWarehouseSetup."Item Jnl. Template Name");
        TempGlobalItemJournalLine.Validate("Entry Type", TempGlobalItemJournalLine."Entry Type"::Transfer);
    end;

    var
        AMSWarehouseSetup: Record "AMS Warehouse Setup";
        GlobalItem: Record Item;
        GlobalLineItem: Record Item;
        TempGlobalItemJournalLine: Record "Item Journal Line" temporary;
        SNEditable: Boolean;
}