tableextension 50105 "AMS Transfer Line" extends "Transfer Line"
{
    fields
    {
        field(50100; "AMS Item Tracking Code"; Code[20])
        {
            Caption = 'AMS Item Tracking Code';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Item Tracking Code" where("No." = field("Item No.")));
        }
    }
}
