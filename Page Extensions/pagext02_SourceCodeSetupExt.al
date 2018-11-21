pageextension 50102 "CSD SourceCodeSetupExt" extends "Source Code Setup"
// CSD1.00 - 2012-06-15 - D. E. Veloper
// Chapter 7 - Lab 1-8
// -    Added new group: Seminar
// -    Added new field: Seminar

{
    layout
    {
        addafter("Cost Accounting")
        {
            group("CSD SeminarGroup")
            {
                Caption = 'Seminar';
                field(Seminar; "CSD Seminar")
                {
                }
            }
        }

    }
}
