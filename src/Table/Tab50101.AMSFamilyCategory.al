table 50101 "AMS Family Category"
{
    Caption = 'AMS Family Category';
    DataClassification = CustomerContent;
    LookupPageId = "AMS Family Category List";
    DrillDownPageId = "AMS Family Category List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
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
