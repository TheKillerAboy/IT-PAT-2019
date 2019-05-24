unit settings_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, COMMONS,StrUtils, ComCtrls, ExtCtrls;

type
  TfrmSettings = class(TForm)
    edtSearch: TEdit;
    btnSearch: TButton;
    lstSettings: TListBox;
    edtSettings: TLabeledEdit;
    Label1: TLabel;
    Panel1: TPanel;
    btnSave: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure lstSettingsClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    procedure SelectField(index:integer);
    procedure RefreashFields();
    procedure LoadSettings;
  var
    dicSettings : MDict<string,string>;
  public
    { Public declarations }
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.dfm}

procedure TfrmSettings.btnSaveClick(Sender: TObject);
var
  pair:MPair<string,string>;
begin
  for pair in dicSettings.pairs.container do
  begin
    ShowMessage(pair.key+' '+pair.value)
  end;
end;

procedure TfrmSettings.btnSearchClick(Sender: TObject);
var
index:integer;
begin
  index := dicSettings.keys.findIf(edtSearch.Text,function(val1,val2:string):boolean
  begin
    result:=ContainsText(val1,val2);
  end);
  if index <> -1 then
  begin
    SelectField(index);
  end;
end;

procedure TfrmSettings.FormCreate(Sender: TObject);
begin
  dicSettings := MDict<string,string>.Create();
  LoadSettings;
  RefreashFields;
end;

procedure TfrmSettings.LoadSettings;
var
  KeyValue : MArray<string>;
  TFile : textfile;
  sLine:string;
begin
  dicSettings.clear;
  AssignFile(TFile,'settings.txt');
  try
    Reset(TFile);
  except
    Exit;
  end;
  while not eof(Tfile) do
  begin
    ReadLn(TFile,sLine);
    KeyValue := Parser.parse(sLine,'#');
    dicSettings.append(KeyValue[0],KeyValue[1]);
  end;
  CloseFile(TFile);
end;

procedure TfrmSettings.lstSettingsClick(Sender: TObject);
begin
  SelectField(lstSettings.ItemIndex);
end;

procedure TfrmSettings.RefreashFields;
var
value:string;
begin
  lstSettings.Items.Clear;
  for value in dicSettings.keys.container do
    lstSettings.Items.Add(value);
  SelectField(-1);
end;

procedure TfrmSettings.SelectField(index: integer);
begin
  lstSettings.ItemIndex := index;
  if index <> -1 then
  begin
    edtSettings.EditLabel.Caption := 'Setting: '+dicSettings.keys[index];
    edtSettings.Text := dicSettings.values[index];
  end
  else
  begin
    edtSettings.EditLabel.Caption := 'Setting';
    edtSettings.Text := '';
  end;
end;

end.
