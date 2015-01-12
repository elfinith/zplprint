program zplprint;

uses
  Forms,
  main in 'main.pas' {Form1},
  settings in 'settings.pas' {frmSettings},
  selectlabels in 'selectlabels.pas' {frmSelectLabels};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.CreateForm(TfrmSelectLabels, frmSelectLabels);
  Application.Run;
end.
