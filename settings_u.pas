unit settings_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, COMMONS,StrUtils, ComCtrls, ExtCtrls, JSON;

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
    dicSettings : DictObject;
  public
    { Public declarations }
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.dfm}

procedure TfrmSettings.btnSaveClick(Sender: TObject);
var
  pair:MPair<string,DictObject>;
begin
  for pair in dicSettings.toObject.pairs.container do
  begin
    ShowMessage(pair.key+' '+pair.value.toString)
  end;
end;

procedure TfrmSettings.btnSearchClick(Sender: TObject);
var
index:integer;
begin
  index := dicSettings.toObject.keys.findIf(edtSearch.Text,Strings.Equivalent);
  if index <> -1 then
  begin
    SelectField(index);
  end;
end;

procedure TfrmSettings.FormCreate(Sender: TObject);
begin
  LoadSettings;
  RefreashFields;
end;

procedure TfrmSettings.LoadSettings;
begin
  dicSettings := JSONParser.FileParse('settings.json');
  JSONParser.JSONSave(dicSettings,'settings.json');
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
  for value in dicSettings.toObject.keys.container do
    lstSettings.Items.Add(value);
  SelectField(-1);
end;

procedure TfrmSettings.SelectField(index: integer);
begin
  lstSettings.ItemIndex := index;
  if index <> -1 then
  begin
    edtSettings.EditLabel.Caption := 'Setting: '+dicSettings.toObject.keys[index];
    edtSettings.Text := dicSettings.toObject.values[index].toString;
  end
  else
  begin
    edtSettings.EditLabel.Caption := 'Setting';
    edtSettings.Text := '';
  end;
end;

end.
