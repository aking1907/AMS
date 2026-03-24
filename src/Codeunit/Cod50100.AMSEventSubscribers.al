codeunit 50100 "AMS Event Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertItemLedgEntry, '', false, false)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
    var
        i: Integer;
    begin
        ItemLedgerEntry."AMS Truck No." := ItemJournalLine."AMS Truck No.";
        ItemLedgerEntry.Description := ItemJournalLine.Description;
    end;
}
