program AnnekinMeyburgh_PAT2019;

uses
  Forms,
  mainmenu_u in 'mainmenu_u.pas' {frmmainmenu},
  COMMONS in 'COMMONS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrmmainmenu, frmmainmenu);
  Application.Run;
end.
