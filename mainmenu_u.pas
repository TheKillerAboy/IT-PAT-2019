unit mainmenu_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,IOUtils, StdCtrls, ExtCtrls, COMMONS, jpeg;

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
  private
    slideshow:MArray<string>;
  public
    { Public declarations }
  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

{$R *.dfm}

procedure TfrmMainMenu.FormCreate(Sender: TObject);
var
sPath:string;
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
