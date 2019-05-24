program PAT2019;

uses
  Forms,
  mainmenu_u in 'mainmenu_u.pas' {frmMainMenu},
  COMMONS in 'COMMONS.pas',
  settings_u in 'settings_u.pas' {frmSettings},
  errors_u in 'errors_u.pas' {frmError};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.CreateForm(TfrmError, frmError);
  Application.Run;
end.
