program PAT2019;

uses
  Forms,
  mainmenu_u in 'mainmenu_u.pas' {frmMainMenu},
  COMMONS in 'COMMONS.pas',
  settings_u in 'settings_u.pas' {frmSettings},
  errors_u in 'errors_u.pas' {frmError},
  help_u in 'help_u.pas' {frmHelp},
  JSON in 'JSON.pas',
  playlists_u in 'playlists_u.pas' {frmPlaylists},
  COMPONENTS in 'COMPONENTS.pas',
  database_u in 'database_u.pas' {dmDataBase: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.CreateForm(TfrmError, frmError);
  Application.CreateForm(TfrmHelp, frmHelp);
  Application.CreateForm(TdmDataBase, dmDataBase);
  Application.CreateForm(TfrmPlaylists, frmPlaylists);
  Application.Run;
end.
