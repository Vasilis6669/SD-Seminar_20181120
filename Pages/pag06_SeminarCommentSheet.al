page 50106 "CSD Seminar Comment Sheet"
{
    Caption = 'Seminar Comment Sheet';

    PageType = List;
    SourceTable = "CSD Seminar Comment Line";
    AutoSplitKey = true;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Date)
                {
                }
                field(Code; Code)
                {
                    Visible = false;
                }
                field(Comment; Comment)
                {
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetupNewLine;
    end;
}