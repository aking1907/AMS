table 50100 "AMS Warehouse Setup"
{
    Caption = 'AMS Warehouse Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; "Item Jnl. Template Name"; Code[10])
        {
            Caption = 'Item Jnl. Template Name';
            TableRelation = "Item Journal Template".Name where(Type = const(Item));
        }
        field(3; "Default Jnl. Batch"; Code[10])
        {
            Caption = 'Default Jnl. Batch';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Item Jnl. Template Name"));
        }
        field(5; "Default Location Code"; Code[10])
        {
            Caption = 'Default Location Code';
            TableRelation = "Location";
        }
        field(6; "Transfer Jnl. Batch"; Code[10])
        {
            Caption = 'Transfer Jnl. Batch';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Item Jnl. Template Name"));
        }
        field(7; "WIP Location Code"; Code[10])
        {
            Caption = 'WIP Location Code';
            TableRelation = "Location";
        }
        field(8; "Quarantine Location Code"; Code[10])
        {
            Caption = 'Quarantine Location Code';
            TableRelation = "Location";
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
