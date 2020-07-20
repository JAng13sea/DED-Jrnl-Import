pageextension 50100 "XPE Excel Import" extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(GetStandardJournals)
        {
            action("Journal Import")
            {
                ApplicationArea = All;
                Caption = 'Journal Import';
                Image = ImportLog;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ImportFile: Codeunit "XPE Import Mgt.";
                begin
                    DED.SetRange(Type, DED.TYpe::"Generic Import");
                    If page.RunModal(1211, DED) = Action::LookupOK then
                        ImportFile.SelectAndImportDataToGL(Rec, DED.Code)
                    else
                        Error('Select an import from the provided list to proceed');
                end;
            }
        }
    }

    var
        DED: Record "Data Exch. Def";
}