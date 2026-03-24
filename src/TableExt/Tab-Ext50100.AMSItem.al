tableextension 50100 "AMS Item" extends Item //27
{
    fields
    {
        field(50100; "AMS Family Category"; Code[20])
        {
            Caption = 'AMS Family Category';
            DataClassification = CustomerContent;
            TableRelation = "AMS Family Category"."Code";
        }
        field(50101; "AMS Inventory On WIP"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = const('WIP'),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter"),
                                                                  "Unit of Measure Code" = field("Unit of Measure Filter"),
                                                                  "Package No." = field("Package No. Filter")));
            Caption = 'On WIP Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            AutoFormatType = 0;
        }
        field(50102; "AMS Inventory On Quarantine"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = const('QUARANTINE'),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter"),
                                                                  "Unit of Measure Code" = field("Unit of Measure Filter"),
                                                                  "Package No." = field("Package No. Filter")));
            Caption = 'On Quarantine Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            AutoFormatType = 0;
        }
        field(50103; "AMS Inventory On Main"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = const('MAIN'),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter"),
                                                                  "Unit of Measure Code" = field("Unit of Measure Filter"),
                                                                  "Package No." = field("Package No. Filter")));
            Caption = 'On Main Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            AutoFormatType = 0;
        }
        field(50104; "AMS Assembly Monitoring"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
}
