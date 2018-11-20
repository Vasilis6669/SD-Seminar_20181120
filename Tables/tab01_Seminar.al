table 50101 "CSD Seminar"
{
    // DataClassification = ToBeClassified;
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    // Chapter 5 - Lab 2-2

    Caption = 'Seminar';

    fields
    {
        field(10; "No."; Code[10])
        {
            //DataClassification = ToBeClassified;
            Caption = 'No.';

            trigger OnValidate();
            begin
                if "No." <> xRec."No." then begin
                    SeminarSetup.GET;
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end;
            end;

        }


        field(20; Name; Text[50])
        {
            //DataClassification = ToBeClassified;
            Caption = 'Name';

            trigger OnValidate();
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or
                ("Search Name" = '') then
                    "Search Name" := Name;
            end;

        }
        field(30; "Seminar Duration"; Decimal)
        {
            //DataClassification = ToBeClassified;
            Caption = 'Seminar Duration';
            DecimalPlaces = 0 : 1;

        }
        field(40; "Minimum Participants"; Integer)
        {
            //DataClassification = ToBeClassified;
            //FieldPropertyName = FieldPropertyValue;
            Caption = 'Minimum Participants';
        }
        field(50; "Maximum Participants"; Integer)
        {
            //DataClassification = ToBeClassified;
            //FieldPropertyName = FieldPropertyValue;
            Caption = 'Maximum Participants';
        }
        field(60; "Search Name"; Code[50])
        {
            //DataClassification = ToBeClassified;
            //FieldPropertyName = FieldPropertyValue;
            Caption = 'Search Name';
        }
        field(70; Blocked; Boolean)
        {
            //DataClassification = ToBeClassified;
            //FieldPropertyName = FieldPropertyValue;
            Caption = 'Blocked';
        }
        field(80; "Last Date Modified"; Date)
        {
            //DataClassification = ToBeClassified;
            //FieldPropertyName = FieldPropertyValue;
            Caption = 'Last Date Modified';
            Editable = false;

        }
        field(90; Comment; Boolean)
        {
            //DataClassification = ToBeClassified;
            //FieldPropertyName = FieldPropertyValue;
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            //CalcFormula = Exist ("Sales Comment Line" WHERE (Document Type=FIELD(Document Type),No.=FIELD(No.),Document Line No.=CONST(0)))
            //CalcFormula=exist("CSD Seminar Comment Line" where("Table Name"= const("Seminar"),"No."=Field("No.")));

        }
        field(100; "Seminar Price"; Decimal)
        {
            //DataClassification = ToBeClassified;
            //FieldPropertyName = FieldPropertyValue;
            Caption = 'Seminar Price';
            AutoFormatType = 1;

        }
        field(110; "Gen. Prod. Posting Group"; Code[10])
        {
            //DataClassification = ToBeClassified;
            //FieldPropertyName = FieldPropertyValue;
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate();
            begin
                if (xRec."Gen. Prod. Posting Group" <>
                "Gen. Prod. Posting Group") then begin
                    if GenProdPostingGroup.ValidateVatProdPostingGroup
                    (GenProdPostingGroup, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group",
                        GenProdPostingGroup."Def. VAT Prod. Posting Group");
                end;
            end;
        }
        field(120; "VAT Prod. Posting Group"; Code[10])
        {
            //DataClassification = ToBeClassified;
            //FieldPropertyName = FieldPropertyValue;
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(130; "No. Series"; Code[10])
        {
            //DataClassification = ToBeClassified;
            //FieldPropertyName = FieldPropertyValue;
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key1; "Search Name")
        {


        }
    }

    var
        SeminarSetup: Record "CSD Seminar Setup";
        //CommentLine : record "CSD Seminar Comment Line";
        Seminar: Record "CSD Seminar";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;


    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.get;
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnDelete()
    begin
        //CommentLine.Reset;
        //CommentLine.SetRange("Table Name",
        //CommentLine."Table Name"::Seminar);
        //CommentLine.SetRange("No.","No.");
        // CommentLine.DeleteAll;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    local procedure AssistEdit(): boolean;
    begin
        with Seminar do begin
            Seminar := Rec;
            SeminarSetup.get;
            SeminarSetup.TestField("Seminar Nos.");
            if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos."
            , xRec."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := Seminar;
                exit(true);
            end;
        end;
    end;

}