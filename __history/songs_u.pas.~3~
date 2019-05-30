unit songs_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, COMPONENTS, ComCtrls, ExtCtrls, StdCtrls, COMMONS, DB, pngimage,
  jpeg;

type
  SaveMode = (smEdit, smNew);

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
    Label1: TLabel;
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
    Label2: TLabel;
    dtpDuration: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure lbxSongsClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure UpdateSongsLIST;
    procedure UpdateALLSongs;
    procedure SelectSong(index: integer); overload;
    procedure SelectSong(play: string); overload;
    procedure Enabled(ena: boolean);
    procedure Clear;
    function DialogsClick(name: string): TiggerComponentProc;
    procedure AnoSave(fields: TFields);
    function CorrectInputs:boolean;
  var
    epDialogs: MDict<string, ExtendablePanel>;
    imageLinker: LinkedButton;
    songLinker: LinkedButton;
    allSongs: MArray<string>;
    currentIndex: integer;
    currentMode: SaveMode;
    alwaysEnabled: MArray<TComponent>;
  public
    { Public declarations }
  end;

var
  frmSongs: TfrmSongs;

implementation

uses database_u,errors_u;
{$R *.dfm}

procedure TfrmSongs.AnoSave(fields: TFields);
begin
  fields.FieldByName('name').Value := edtName.Text;
  fields.FieldByName('description').Value := epDialogs['Description'].field.Text;
  fields.FieldByName('history').Value := epDialogs['History'].field.Text;
  fields.FieldByName('lyrics').Value := epDialogs['Lyrics'].field.Text;
  fields.FieldByName('image').Value := imageLinker.OFile;
  fields.FieldByName('directory').Value := songLinker.OFile;
  fields.FieldByName('id').Value := lbxSongs.Count;
  fields.FieldByName('release date').AsDateTime := dtpDate.DateTime;
  fields.FieldByName('duration').AsDateTime := dtpDuration.DateTime;
end;

procedure TfrmSongs.btnDeleteClick(Sender: TObject);
begin
  if currentIndex <> -1 then
  begin
    MDataBase.RemoveFields(dmDataBase.tblSongs, 'name',
      lbxSongs.Items[currentIndex]);
    while MDataBase.ContainsFields(dmDataBase.tblPofS, 'song', currentIndex) do
      MDataBase.RemoveFields(dmDataBase.tblPofS, 'song', currentIndex);
    Clear;
    UpdateALLSongs;
    UpdateSongsLIST;
    btnDelete.Enabled:=false;
  end;
end;

procedure TfrmSongs.btnEditClick(Sender: TObject);
begin
  if lbxSongs.ItemIndex <> -1 then
  begin
    Enabled(true);
    btnEdit.Enabled := false;
    currentMode := smEdit;
  end;
end;

procedure TfrmSongs.btnNewClick(Sender: TObject);
begin
  Enabled(true);
  Clear;
  btnNew.Enabled := false;
  btnEdit.Enabled := false;
  btnDelete.Enabled := false;
  currentMode := smNew;
end;

procedure TfrmSongs.btnSaveClick(Sender: TObject);
begin
  if not CorrectInputs then
    Exit;
  case currentMode of
    smEdit:
      begin
        MDataBase.EditFields(dmDataBase.tblSongs, 'id', currentIndex, AnoSave);
      end;
    smNew:
      begin
        MDataBase.WriteFields(dmDataBase.tblSongs, AnoSave);
        UpdateALLSongs;
        UpdateSongsLIST;
        lbxSongs.ItemIndex := lbxSongs.Count - 1;
      end;
  end;
end;

procedure TfrmSongs.btnSearchClick(Sender: TObject);
begin
  SelectSong(edtSearch.Text);
end;

procedure TfrmSongs.SelectSong(play: string);
var
  specialIndex: integer;
begin
  SelectSong(allSongs.findIf(play, Strings.Equivalent));
end;

procedure TfrmSongs.SelectSong(index: integer);
var
  fieldname: string;
begin
  Enabled(false);
  Clear;
  if index <> -1 then
  begin
    btnEdit.Enabled := true;
    lbxSongs.ItemIndex := index;
    fieldname := lbxSongs.Items[index];
    MDataBase.UseFields(dmDataBase.tblSongs, 'name', fieldname,
      procedure(fields: TFields)begin
  edtName.Text:= fields.FieldByName('name').Value;
  epDialogs['Description'].field.Text:=fields.FieldByName('description').Value;
  epDialogs['History'].field.Text:=fields.FieldByName('history').Value;
  epDialogs['Lyrics'].field.Text:=fields.FieldByName('lyrics').Value;
  imageLinker.OFile:=fields.FieldByName('image').Value;
  if fields.FieldByName('image')
    .AsString <> '' then begin img.Picture.LoadFromFile
    (fields.FieldByName('image').AsString);
    end;
  songLinker.OFile:=fields.FieldByName('directory').Value;
  dtpDate.Date :=fields.FieldByName('release date').AsDateTime;
  dtpDuration.Time :=fields.FieldByName('duration').AsDateTime ;

        end);
  end;
end;

procedure TfrmSongs.Clear;
var
comp :  ExtendablePanel;
begin
  edtName.Text := '';
  img.Picture := nil;
  songLinker.OFile := '';
  imageLinker.OFile := '';
  for comp in epDialogs.values.container do
    comp.field.Text:='';
  dtpDate.DateTime := Date;
  dtpDuration.DateTime := 0;
end;

function TfrmSongs.CorrectInputs: boolean;
begin
  if edtName.Text = '' then
    Error.QuickShow('Required Field Not Filled In!','Name is a required field!')
  else if MDataBase.ContainsFields(dmDataBase.tblSongs,'name',edtName.Text) then
    Error.QuickShow('Song already exists','a Song with name '+edtSearch.Text+' already exists')
  else if songLinker.OFile = '' then
    Error.QuickShow('Song Directory Not Selected','Music File is a required field!')
  else begin
    result:=true;
    Exit;
  end;
  result:=false;
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
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if alwaysEnabled.find(COMPONENTS[i]) = -1 then
      TGraphicControl(COMPONENTS[i]).Enabled := ena;
  for i := 0 to epDialogs.len - 1 do
    epDialogs.values[i].Enabled(ena);
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

  alwaysEnabled := MArray<TComponent>.create([edtSearch, btnSearch,
    btnMusicPlayer, btnMainMenu, btnSongs, lbxSongs, btnEdit, pnlNav,
    pnlPlaylist, btnNew, btnDelete, lblSongs]);

  dtpDuration.DateTime := 0;

  UpdateALLSongs;
  UpdateSongsLIST;
end;

procedure TfrmSongs.FormShow(Sender: TObject);
begin
  UpdateALLSongs;
  UpdateSongsLIST;

  Enabled(false);
end;

procedure TfrmSongs.lbxSongsClick(Sender: TObject);
begin
  currentIndex := lbxSongs.ItemIndex;
  SelectSong(currentIndex);
  if currentIndex <> -1 then
  begin
    btnEdit.Enabled := true;
    btnDelete.Enabled := true;
  end
  else
  begin
    btnEdit.Enabled := false;
    btnDelete.Enabled := false;
  end;
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
