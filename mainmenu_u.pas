unit mainmenu_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,IOUtils, StdCtrls, ExtCtrls, COMMONS, jpeg,JSON;

type
  TfrmMainMenu = class(TForm)
    Panel1: TPanel;
    imgSlideShow: TImage;
    tmrSlideShow: TTimer;
    btnPlaylists: TButton;
    btnSongs: TButton;
    btnSettings: TButton;
    procedure FormCreate(Sender: TObject);
    procedure tmrSlideShowTimer(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnPlaylistsClick(Sender: TObject);
    procedure btnSongsClick(Sender: TObject);
  private
    slideshow:MArray<string>;
  public
    { Public declarations }
  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

uses settings_u,playlists_u, songs_u;

{$R *.dfm}

procedure TfrmMainMenu.btnPlaylistsClick(Sender: TObject);
begin
  frmPlaylists.Show;
end;

procedure TfrmMainMenu.btnSettingsClick(Sender: TObject);
begin
  frmSettings.Show;
end;

procedure TfrmMainMenu.btnSongsClick(Sender: TObject);
begin
  frmSongs.Show;
end;

procedure TfrmMainMenu.FormCreate(Sender: TObject);
var
sPath:string;
obj:DictObject;
begin
  slideshow := MArray<string>.Create();
  for sPath in TDirectory.GetFiles(GetCurrentDir+'\SlideShow')  do
        slideshow.append(sPath);
  tmrSlideShowTimer(nil);
end;

procedure TfrmMainMenu.tmrSlideShowTimer(Sender: TObject);
begin
  imgSlideShow.Picture.LoadFromFile(slideshow.getCIndex);
  slideshow.cIndexRotate
end;

end.
