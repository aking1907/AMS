pageextension 50105 "AMS Assembly Order" extends "Assembly Order" //900
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
    actions
    {
        addafter("Order &Tracking")
        {
            action(AMSCreateTransferOrder)
            {
                ApplicationArea = All;
                Caption = 'AMS Create Transfer Order';
                Image = TransferOrder;
                ToolTip = 'Creates a transfer order for the assembly order.';

                trigger OnAction()
                var
                    AMSWarehouseSetup: Record "AMS Warehouse Setup";
                    TransferHeader: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    AssemblyLine: Record "Assembly Line";
                    LineNo: Integer;
                begin
                    AMSWarehouseSetup.Get();
                    TransferHeader.Init();
                    TransferHeader.Insert(true);
                    TransferHeader.Validate("Transfer-from Code", AMSWarehouseSetup."Default Location Code");
                    TransferHeader.Validate("Transfer-to Code", AMSWarehouseSetup."WIP Location Code");
                    TransferHeader.Validate("Direct Transfer", true);
                    TransferHeader.Modify(true);

                    AssemblyLine.SetRange("Document No.", Rec."No.");
                    AssemblyLine.SetFilter("Quantity per", '>0');
                    AssemblyLine.SetRange(Type, AssemblyLine.Type::Item);
                    if not AssemblyLine.FindSet() then
                        Error('No assembly lines with positive quantity found for assembly order.');

                    repeat
                        LineNo += 10000;
                        TransferLine.Init();
                        TransferLine.Validate("Document No.", TransferHeader."No.");
                        TransferLine.Validate("Line No.", LineNo);
                        TransferLine.Validate("Item No.", AssemblyLine."No.");
                        TransferLine.Validate("Quantity", AssemblyLine."Quantity per");
                        TransferLine.Validate("Unit of Measure Code", AssemblyLine."Unit of Measure Code");
                        TransferLine.Insert(true);
                    until AssemblyLine.Next() = 0;

                    Message('Transfer Order %1 successfully created for Assembly Order %2.', TransferHeader."No.", Rec."No.");
                end;
            }
        }
        addafter("Order &Tracking_Promoted")
        {
            actionref(AMSCreateTransferOrder_Promoted; AMSCreateTransferOrder) { }
        }
    }
}