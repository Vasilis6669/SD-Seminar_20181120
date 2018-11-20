page 50107 "CSD Seminar Comment List"
{
    Caption = 'Seminar Comment List';
    Editable = false;
    PageType = List;
    SourceTable = "CSD Seminar Comment Line";
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
}