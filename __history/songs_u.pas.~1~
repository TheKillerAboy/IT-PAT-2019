unit songs_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, COMPONENTS, ComCtrls, ExtCtrls, StdCtrls, COMMONS;

type
  TfrmSongs = class(TForm)
    lblSongs: TLabel;
    edtSearch: TEdit;
    btnSearch: TButton;
    lbxSongs: TListBox;
    pnlInfo: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    img: TImage;
    edtName: TLabeledEdit;
    btnMusicFile: TButton;
    btnImage: TButton;
    dtpDate: TDateTimePicker;
    dtpDuration: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    pnlDescription: TPanel;
    pnlHistory: TPanel;
    pnlLyrics: TPanel;
    pnlPlaylist: TPanel;
    btnSave: TButton;
    btnEdit: TButton;
    btnNew: TButton;
    btnDelete: TButton;
    pnlNav: TPanel;
    btnMusicPlayer: TButton;
    btnMainMenu: TButton;
    btnSongs: TButton;
    procedure FormCreate(Sender: TObject);
  private
    procedure UpdateSongsLIST;
    procedure UpdateALLSongs;
    var
      epDialogs : MDict<string,ExtendablePanel>;
      imageLinker : LinkedButton;
      songLinker : LinkedButton;
      allSongs : MArray<string>;
  public
    { Public declarations }
  end;

var
  frmSongs: TfrmSongs;

implementation

uses database_u;

{$R *.dfm}

procedure TfrmSongs.FormCreate(Sender: TObject);
begin
  epDialogs := MDict<string,ExtendablePanel>.Create();
  epDialogs.append('Description',ExtendablePanel.Extend(pnlDescription,'Description'));
  epDialogs.append('History',ExtendablePanel.Extend(pnlHistory,'History'));
  epDialogs.append('Lyrics',ExtendablePanel.Extend(pnlLyrics,'Lyrics'));


  imageLinker := LinkedButton.Extend(btnImage,lbImage,GetCurrentDir,procedure begin
     img.Picture.LoadFromFile(imageLinker.OFile);
  end);
  songLinker := LinkedButton.Extend(btnMusicFile,lbMusic,GetCurrentDir,nil);

  UpdateALLSongs;
  UpdateSongsLIST;
end;

procedure TfrmSongs.UpdateALLSongs;
begin
    allSongs := Converter<Variant,string>.convert(
 MDataBase.LoadFieldIntoArray(dmDataBase.tblSongs,'name'),function(value:variant):string
 begin
   result:=string(value);
 end);
end;

procedure TfrmSongs.UpdateSongsLIST;
var
  temp:string;
begin
  lbxSongs.Items.Clear;
  for temp in allSongs.container do
    lbxSongs.Items.Add(temp);
end;

end.
