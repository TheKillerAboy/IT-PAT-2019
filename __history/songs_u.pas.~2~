unit songs_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, COMPONENTS, ComCtrls, ExtCtrls, StdCtrls, COMMONS, DB;

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
    procedure btnSearchClick(Sender: TObject);
  private
    procedure UpdateSongsLIST;
    procedure UpdateALLSongs;
    procedure SelectPlaylist(index: integer); overload;
    procedure SelectPlaylist(play: string); overload;
    procedure Enabled(ena: boolean);
    procedure Clear;
    function DialogsClick(name: string): TiggerComponentProc;

  var
    epDialogs: MDict<string, ExtendablePanel>;
    imageLinker: LinkedButton;
    songLinker: LinkedButton;
    allSongs: MArray<string>;
  public
    { Public declarations }
  end;

var
  frmSongs: TfrmSongs;

implementation

uses database_u;
{$R *.dfm}

procedure TfrmSongs.btnSearchClick(Sender: TObject);
begin
  SelectPlaylist(edtSearch.Text);
end;

procedure TfrmSongs.SelectPlaylist(play: string);
var
  specialIndex: integer;
begin
  SelectPlaylist(allSongs.findIf(play, Strings.Equivalent));
end;

procedure TfrmSongs.SelectPlaylist(index: integer);
var
  fieldname: string;
begin
  btnEdit.Enabled := true;
  Enabled(false);
  Clear;
  if index <> -1 then
  begin
    lbxSongs.ItemIndex := index;
    fieldname := lbxSongs.Items[index];
    MDataBase.UseFields(dmDataBase.tblPlaylists, 'name', fieldname,
      procedure(fields: TFields)begin

        end);
  end;
end;

procedure TfrmSongs.Clear;
begin

end;

function TfrmSongs.DialogsClick(name: string): TiggerComponentProc;
begin
  result := procedure var pair: MPair<string, ExtendablePanel>;
found :
  boolean;
  begin
    found := false;
    for pair in epDialogs.pairs.container do
    begin
      pair.value.Collapse;
      if found then
        pair.value.ExpandedAbove
      else
        pair.value.ExpandedBelow;
      if pair.key = name then
      begin
        pair.value.Expand;
        pair.value.expander.Caption := '';
        found := true;
      end;
    end;
  end;
end;

procedure TfrmSongs.Enabled(ena: boolean);
begin

end;

procedure TfrmSongs.FormCreate(Sender: TObject);
begin
  epDialogs := MDict<string, ExtendablePanel>.Create();
  epDialogs.append('Description', ExtendablePanel.Extend(pnlDescription,
      'Description', true, [-1, 130], DialogsClick('Description')));
  epDialogs.append('History', ExtendablePanel.Extend(pnlHistory, 'History',
      true, [-1, 130], DialogsClick('History')));
  epDialogs.append('Lyrics', ExtendablePanel.Extend(pnlLyrics, 'Lyrics', true,
      [-1, 130], DialogsClick('Lyrics')));
  epDialogs.values[0].expander.Click;

  imageLinker := LinkedButton.Extend(btnImage, lbImage, GetCurrentDir,
    procedure begin img.Picture.LoadFromFile(imageLinker.OFile); end);
  songLinker := LinkedButton.Extend(btnMusicFile, lbMusic, GetCurrentDir, nil);

  UpdateALLSongs;
  UpdateSongsLIST;
end;

procedure TfrmSongs.UpdateALLSongs;
begin
  allSongs := Converter<Variant,
    string>.convert(MDataBase.LoadFieldIntoArray(dmDataBase.tblSongs, 'name'),
    function(value: Variant): string begin result := string(value); end);
end;

procedure TfrmSongs.UpdateSongsLIST;
var
  temp: string;
begin
  lbxSongs.Items.Clear;
  for temp in allSongs.container do
    lbxSongs.Items.Add(temp);
end;

end.
