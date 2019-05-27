unit playlists_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, COMPONENTS, COMMONS, DB,pngimage,jpeg;

type
  SaveMode = (smEdit,smNew);

type
  TfrmPlaylists = class(TForm)
    edtSearch: TEdit;
    btnSearch: TButton;
    pnlNav: TPanel;
    pnlPlaylist: TPanel;
    btnSave: TButton;
    pnlDescription: TPanel;
    lbxPlaylists: TListBox;
    lblPlaylists: TLabel;
    pnlInfo: TPanel;
    lbxSongs: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    lbxSongsinPlaylist: TListBox;
    btnRemove: TButton;
    btnAdd: TButton;
    edtName: TLabeledEdit;
    btnFolder: TButton;
    Label4: TLabel;
    btnImage: TButton;
    Label5: TLabel;
    img: TImage;
    btnEdit: TButton;
    btnNew: TButton;
    btnMusicPlayer: TButton;
    btnMainMenu: TButton;
    btnSongs: TButton;
    btnDelete: TButton;
    procedure FormCreate(Sender: TObject);
    procedure lbxPlaylistsClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure lbxSongsinPlaylistClick(Sender: TObject);
    procedure lbxSongsClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure UpdatePlaylistsLIST;
    procedure UpdateSongsLIST;
    procedure UpdateThisSongsLIST;
    procedure UpdateALLPlaylists;
    procedure UpdateALLSongs;
    procedure SelectPlaylist(play:string);overload;
    procedure SelectPlaylist(index:integer);overload;
    procedure Enabled(ena:boolean);
    procedure AnoSave(fields:TFields);
    procedure SavePlaylistsSongs;
    procedure Clear;
    var
      epDescription : ExtendablePanel;
      allPlaylists : MArray<string>;
      thisPlaylistsSongs : MDict<integer,string>;
      allSongs : MArray<string>;
      alwaysEnabled : MArray<TComponent>;
      imageLinker : LinkedButton;
      folderLinker : LinkedButton;
      currentMode : SaveMode;
      currentIndex : integer;
      createdDate : TDateTime;
  public
    { Public declarations }
  end;

var
  frmPlaylists: TfrmPlaylists;

implementation

uses database_u;

{$R *.dfm}

procedure TfrmPlaylists.AnoSave(fields: TFields);
begin
    fields.FieldByName('name').Value:=edtName.Text;
    fields.FieldByName('description').Value:=epDescription.field.Text;
    fields.FieldByName('image').Value:=imageLinker.OFile;
    fields.FieldByName('directory').Value:=folderLinker.OFile;
    fields.FieldByName('id').Value:=lbxPlaylists.Count;
    if createdDate = 0 then
      createdDate := Date;
    fields.FieldByName('created').AsDateTime:=createdDate;

end;

procedure TfrmPlaylists.btnAddClick(Sender: TObject);
begin
  if lbxSongs.ItemIndex <>-1 then
  begin
    if thisPlaylistsSongs.values.find(lbxSongs.Items[lbxSongs.ItemIndex]) = -1 then
    begin
      thisPlaylistsSongs.append(lbxSongs.ItemIndex,lbxSongs.Items[lbxSongs.ItemIndex]);
      UpdateThisSongsLIST;
    end;
  end;
end;

procedure TfrmPlaylists.btnDeleteClick(Sender: TObject);
begin
  if currentIndex <>-1 then
  begin
    MDataBase.RemoveFields(dmDataBase.tblPlaylists,'name',lbxPlaylists.Items[currentIndex]);
    Clear;
    UpdateALLPlaylists;
    UpdatePlaylistsLIST;
  end;
end;

procedure TfrmPlaylists.btnEditClick(Sender: TObject);
begin
  if lbxPlaylists.ItemIndex <>-1 then
  begin
    Enabled(true);
    btnEdit.Enabled:=false;
    currentMode := smEdit;
  end;
end;

procedure TfrmPlaylists.btnNewClick(Sender: TObject);
begin
  Enabled(true);
  Clear;
  btnNew.Enabled:=false;
  btnEdit.Enabled:=false;
  btnDelete.Enabled:=false;
  currentMode := smNew;
end;

procedure TfrmPlaylists.btnRemoveClick(Sender: TObject);
var
i:integer;
begin
  if lbxSongsinPlaylist.ItemIndex<>-1 then
  begin
    thisPlaylistsSongs.delete(lbxSongsinPlaylist.ItemIndex);
    for I := 0 to thisPlaylistsSongs.keys.len - 1 do
      if thisPlaylistsSongs.keys[i]>= lbxSongsinPlaylist.ItemIndex then
        thisPlaylistsSongs.keys[i] := thisPlaylistsSongs.keys[i]-1;
    MDataBase.RemoveFields(dmDataBase.tblPofS,'id',Variant(lbxSongsinPlaylist.ItemIndex));
    UpdateThisSongsLIST;
  end;
end;

procedure TfrmPlaylists.btnSaveClick(Sender: TObject);
begin
  case currentMode of
    smEdit:
    begin
      MDataBase.EditFields(dmDataBase.tblPlaylists,'id',currentIndex,AnoSave);
    end;
    smNew:
    begin
      MDataBase.WriteFields(dmDataBase.tblPlaylists,AnoSave);
      UpdateALLPlaylists;
      UpdatePlaylistsLIST;
      lbxPlaylists.ItemIndex:=lbxPlaylists.Count-1;
    end;
  end;
end;

procedure TfrmPlaylists.btnSearchClick(Sender: TObject);
begin
  SelectPlaylist(edtSearch.Text)
end;

procedure TfrmPlaylists.Clear;
begin
  edtName.Text:='';
  img.Picture := nil;
  thisPlaylistsSongs := MDict<integer,string>.create();
  folderLinker.OFile:='';
  imageLinker.OFile:='';
  epDescription.field.Text:='';
  createdDate := 0;
end;

procedure TfrmPlaylists.Enabled(ena: boolean);
var
  i:integer;
begin
  for I := 0 to ComponentCount - 1 do
    if alwaysEnabled.find(Components[i]) = -1 then
      TGraphicControl(Components[i]).enabled := ena;
end;

procedure TfrmPlaylists.FormCreate(Sender: TObject);
begin
  imageLinker := LinkedButton.Extend(btnImage,lbImage,GetCurrentDir,procedure begin
     img.Picture.LoadFromFile(imageLinker.OFile);
  end);
  folderLinker := LinkedButton.Extend(btnFolder,lbFolder,GetCurrentDir,nil);

  alwaysEnabled := MArray<TComponent>.Create([edtSearch,btnSearch,btnMusicPlayer,btnMainMenu,
  btnSongs,lbxPlaylists,btnEdit,pnlNav,pnlPlaylist,btnAdd,btnRemove,btnNew,btnDelete
  ,lblPlaylists]);

  epDescription := ExtendablePanel.Extend(pnlDescription,'Description');
end;

procedure TfrmPlaylists.FormShow(Sender: TObject);
begin
  UpdateALLPlaylists;
  UpdatePlaylistsLIST;
  UpdateALLSongs;
  UpdateSongsLIST;

  Enabled(false);
end;

procedure TfrmPlaylists.SelectPlaylist(play: string);
var
  specialIndex:integer;
begin
  SelectPlaylist(allPlaylists.findIf(play,Strings.Equivalent));
end;

procedure TfrmPlaylists.lbxPlaylistsClick(Sender: TObject);
begin
  SelectPlaylist(lbxPlaylists.ItemIndex);
    currentIndex:=lbxPlaylists.ItemIndex;
  if currentIndex <> -1 then
  begin
    btnEdit.Enabled:=true;
    btnDelete.Enabled:=true;
  end
  else
  begin
    btnEdit.Enabled:=false;
    btnDelete.Enabled:=false;
  end;
end;

procedure TfrmPlaylists.lbxSongsClick(Sender: TObject);
begin
  btnRemove.Enabled := false;
  btnAdd.Enabled := true;
  lbxSongsinPlaylist.ItemIndex:=-1;
end;

procedure TfrmPlaylists.lbxSongsinPlaylistClick(Sender: TObject);
begin
  if lbxSongsinPlaylist.Count > 0 then
  begin
    btnRemove.Enabled := true;
    btnAdd.Enabled := false;
    lbxSongs.ItemIndex:=-1;
  end
  else
    btnRemove.Enabled:=false;
end;

procedure TfrmPlaylists.SavePlaylistsSongs;
var
  maxindex : integer;
  pair : MPair<integer,string>;
begin
  maxindex := dmDataBase.tblPofS.RecordCount-1;
  for pair in thisPlaylistsSongs.pairs.container do
  begin
    if pair.key > maxindex then
    begin
      MDataBase.WriteFields(dmDataBase.tblPofS,procedure(fields:TFields)begin
        fields.FieldByName('playlist').Value := currentIndex;
        fields.FieldByName('song').Value := allSongs.find(pair.value);
      end);
    end;
  end;
end;

procedure TfrmPlaylists.SelectPlaylist(index: integer);
var
fieldname : string;
begin
  btnEdit.Enabled:=true;
  Enabled(false);
  Clear;
  if index <> -1 then
  begin
    lbxPlaylists.ItemIndex :=index;
    fieldname := lbxPlaylists.Items[index];
    MDataBase.UseFields(dmDataBase.tblPlaylists,'name',fieldname,procedure(fields:TFields)
    begin
      edtName.Text := fieldname;
      epDescription.field.Text := fields.FieldByName('description').AsString;
      if fields.FieldByName('image').AsString <> '' then
      begin
        img.Picture.LoadFromFile(fields.FieldByName('image').AsString);
        imageLinker.OFile :=  fields.FieldByName('image').AsString;
      end;
      if fields.FieldByName('directory').AsString <> '' then
      begin
        img.Picture.LoadFromFile(fields.FieldByName('directory').AsString);
        imageLinker.OFile :=  fields.FieldByName('directory').AsString;
      end;
      createdDate := fields.FieldByName('created').AsDateTime;
    end);
    thisPlaylistsSongs := MDict<integer,string>.Create;
    MDataBase.UseFields(dmDataBase.tblPofS,'playlist',index,false,procedure(fields:TFields)
    begin
      MDataBase.UseFields(dmDataBase.tblSongs,'id',fields.FieldByName('song').Value,procedure(fieldsSongs:TFields)
      begin
        thisPlaylistsSongs.append(fields.FieldByName('song').Value,fieldsSongs.FieldByName('name').AsString);
      end);
    end);
    UpdateThisSongsLIST;
  end;
end;

procedure TfrmPlaylists.UpdateALLPlaylists;
begin
allPlaylists := Converter<Variant,string>.convert(
 MDataBase.LoadFieldIntoArray(dmDataBase.tblPlaylists,'name'),function(value:variant):string
 begin
   result:=string(value);
 end);
end;

procedure TfrmPlaylists.UpdateALLSongs;
begin
    allSongs := Converter<Variant,string>.convert(
 MDataBase.LoadFieldIntoArray(dmDataBase.tblSongs,'name'),function(value:variant):string
 begin
   result:=string(value);
 end);
end;

procedure TfrmPlaylists.UpdatePlaylistsLIST;
var
  temp:string;
begin
  lbxPlaylists.Items.Clear;
  for temp in allPlaylists.container do
    lbxPlaylists.Items.Add(temp);
end;

procedure TfrmPlaylists.UpdateSongsLIST;
var
  temp:string;
begin
  lbxSongs.Items.Clear;
  for temp in allSongs.container do
    lbxSongs.Items.Add(temp);
end;

procedure TfrmPlaylists.UpdateThisSongsLIST;
var
  temp:string;
begin
  lbxSongsinPlaylist.Items.Clear;
  for temp in thisPlaylistsSongs.values.container do
    lbxSongsinPlaylist.Items.Add(temp);
end;

end.
