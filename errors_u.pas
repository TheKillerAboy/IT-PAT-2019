unit errors_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, COMMONS;

type
  TfrmError = class(TForm)
    lblError: TLabel;
    redError: TRichEdit;
    Panel1: TPanel;
    btnContinue: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ResetButtons;
  public
    { Public declarations }
  end;


type
  ErrorButtons = (hbHelp,hbCancel,hbContinue);
  HelpProc = reference to procedure;

type
  Error = class
    private
    var
      sTitle,sMessage,sHelp : string;
      hButtons : MArray<ErrorButtons>;
    public
      constructor Create(Title,oMessage:string;Buttons:MArray<ErrorButtons>;help:string);
      procedure Show;
      class procedure QuickShow(Title, oMessage:string;Buttons:MArray<ErrorButtons>;help:string); overload;
      class procedure QuickShow(Title, oMessage:string;Buttons:MArray<ErrorButtons>);overload;
      class procedure QuickShow(Title, oMessage:string;Buttons:array of ErrorButtons;help:string); overload;
      class procedure QuickShow(Title, oMessage:string;Buttons:array of ErrorButtons);overload;
      class procedure QuickShow(Title, oMessage:string);overload;
      class procedure QuickShow(Title, oMessage, help:string);overload;
      class procedure QuickShow(oMessage:string;Buttons:MArray<ErrorButtons>;help:string);overload;
      class procedure QuickShow(oMessage:string;Buttons:MArray<ErrorButtons>);overload;
      class procedure QuickShow(oMessage:string;Buttons:array of ErrorButtons;help:string);overload;
      class procedure QuickShow(oMessage:string;Buttons:array of ErrorButtons);overload;
      class procedure QuickShow(oMessage:string);overload;
  end;
var
  err : Error;
  frmError: TfrmError;

implementation

uses help_u;

{$R *.dfm}

{ THelp }

constructor Error.Create(Title, oMessage: string; Buttons: MArray<ErrorButtons>;help:string);
begin
  sTitle := Title;
  sMEssage := oMessage;
  hButtons := Buttons;
  sHelp := help;
end;

class procedure Error.QuickShow(Title, oMessage: string);
begin
  QuickShow(Title, oMessage,MArray<ErrorButtons>.Create([hbCancel]));
end;

class procedure Error.QuickShow(Title, oMessage: string;
  Buttons: MArray<ErrorButtons>);
begin
  QuickShow(Title,oMessage,Buttons,'')
end;

class procedure Error.QuickShow(Title, oMessage: string;
  Buttons: MArray<ErrorButtons>; help:string);
begin
  err := Error.Create(Title,oMessage,Buttons,help);
  err.Show;
end;

class procedure Error.QuickShow(oMessage: string);
begin
  QuickShow(oMessage,MArray<ErrorButtons>.Create(TArray<ErrorButtons>.Create(hbCancel)));
end;

class procedure Error.QuickShow(Title, oMessage, help: string);
begin
  QuickShow(Title,oMessage,[hbCancel,hbHelp],help);
end;

class procedure Error.QuickShow(Title, oMessage: string;
  Buttons: array of ErrorButtons);
begin
  QuickShow(Title,oMessage,MArray<ErrorButtons>.Create(Buttons));
end;

class procedure Error.QuickShow(Title, oMessage: string;
  Buttons: array of ErrorButtons; help:string);
begin
  QuickShow(Title,oMessage,MArray<ErrorButtons>.Create(Buttons),help);
end;

class procedure Error.QuickShow(oMessage: string;
  Buttons: array of ErrorButtons);
begin
  QuickShow(oMessage,MArray<ErrorButtons>.Create(Buttons));
end;

class procedure Error.QuickShow(oMessage: string;
  Buttons: array of ErrorButtons; help:string);
begin
  QuickShow(oMessage,MArray<ErrorButtons>.Create(Buttons),help);
end;

class procedure Error.QuickShow(oMessage: string;
  Buttons: MArray<ErrorButtons>);
begin
  QuickShow(oMessage,Buttons,'');
end;

class procedure Error.QuickShow(oMessage: string;
  Buttons: MArray<ErrorButtons>; help:string);
begin
  QuickShow('',oMessage,Buttons,help);
end;

procedure Error.Show;
var
but : ErrorButtons;
x:integer;
begin
  with frmError do
  begin
    ResetButtons;
    if sTitle <> '' then
      Caption := 'Error - '+sTitle
    else
      Caption := 'Error';
    redError.Text := sMessage;
    x := 345;
    for but in hButtons.container do
    begin
      if but = hbContinue then
      begin
        btnContinue.Left := x;
        btnContinue.Visible := True;
      end
      else if but = hbCancel then
      begin
        btnCancel.Left := x;
        btnCancel.Visible := True;
      end
      else if but = hbHelp then
      begin
        btnHelp.Left := x;
        btnHelp.Visible := True;
      end;
      x := x - 81;
    end;
    Show;
  end;
end;

procedure TfrmError.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmError.btnContinueClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmError.btnHelpClick(Sender: TObject);
begin
  if err <> nil then
    frmHelp.Help(err.sHelp);
  Close;
end;

procedure TfrmError.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  err.Free;
end;

procedure TfrmError.ResetButtons;
begin
    btnContinue.Visible := False;
    btnHelp.Visible := False;
    btnCancel.Visible := False;

    btnContinue.Left := 7;
    btnHelp.Left := 7;
    btnCancel.Left := 7;
end;

end.
