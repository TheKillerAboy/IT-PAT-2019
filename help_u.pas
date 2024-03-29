unit help_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JSON, ComCtrls, COMMONS, StdCtrls, ExtCtrls;

type
  TfrmHelp = class(TForm)
    tvwHelp: TTreeView;
    redHelp: TRichEdit;
    edtSearch: TEdit;
    btnSearch: TButton;
    Panel1: TPanel;
    btnMainMain: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure tvwHelpChange(Sender: TObject; Node: TTreeNode);
    procedure FormShow(Sender: TObject);
    procedure btnMainMainClick(Sender: TObject);
  private
    procedure Search(relevant:string);
    procedure AddToTree(Current : MArray<DictObject>; Parent : TTreeNode);
    var
      jsonHelp : DictObject;
      specialHelp : MDict<TTreeNode,string>;
      dicTree : MDict<string,TTreeNode>;
  public
    procedure Help(relevant:string);
  end;

var
  frmHelp: TfrmHelp;

implementation

uses mainmenu_u;
{$R *.dfm}

procedure TfrmHelp.AddToTree(Current: MArray<DictObject>; Parent : TTreeNode);
var
  tmpObj : DictObject;
  tmpParent : TTreeNode;
begin
  for tmpObj in Current.container do
  begin
    tmpParent := tvwHelp.Items.AddChild(Parent,tmpObj['title'].toString);
    dicTree.append(tmpObj['title'].toString,tmpParent);
    if tmpObj['hasChildren'].toBool then
    begin
      AddToTree(tmpObj['content'].toArray,tmpParent);
    end
    else
      specialHelp.append(tmpParent,tmpObj['content'].toString)
  end;
end;

procedure TfrmHelp.btnMainMainClick(Sender: TObject);
begin
  frmMainMenu.SHow;
  Hide;
end;

procedure TfrmHelp.btnSearchClick(Sender: TObject);
begin
  if edtSearch.Text <> '' then

  Search(edtSearch.Text);
end;

procedure TfrmHelp.FormCreate(Sender: TObject);
begin
  jsonHelp := JSONParser.FileParse('help.json');
  specialHelp := MDict<TTreeNOde,string>.Create();
  dicTree := MDict<string,TTreeNode>.Create();
  AddToTree(jsonHelp['help'].toArray,nil);
end;

procedure TfrmHelp.FormShow(Sender: TObject);
var
  tmpNode:TTreeNode;
begin
  for tmpNode in dicTree.values.container do
    tmpNode.Expanded := false;
  redHelp.Text := '';
end;

procedure TfrmHelp.Help(relevant: string);
begin
  Show;
  Search(relevant);
end;

procedure TfrmHelp.Search(relevant: string);
var
  searchIndex : integer;
begin
  searchIndex := dicTree.keys.findIF(relevant,Strings.Equivalent);
  if searchIndex <> -1 then
    tvwHelp.Select(dicTree.values[searchIndex]);
     dicTree.values[searchIndex].Expanded:=true;
  tvwHelp.SetFocus;
end;

procedure TfrmHelp.tvwHelpChange(Sender: TObject; Node: TTreeNode);
var
  specialIndex : integer;
begin
  specialIndex := specialHelp.keys.find(tvwHelp.Selected);
  if specialIndex <> -1 then
    redHelp.Text := specialHelp.values[specialIndex];
end;
end.
