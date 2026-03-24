tableextension 50103 "AMS Assembly Line" extends "Assembly Line"
{
    fields
    {
        field(50100; "AMS Item Tracking Code"; Code[20])
        {
            Caption = 'AMS Item Tracking Code';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Item Tracking Code" where("No." = field("No.")));
        }
    }
}
