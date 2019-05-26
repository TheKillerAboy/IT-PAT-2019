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
  TError = class
    private
    var
      sTitle,sMessage : string;
      hButtons : MArray<ErrorButtons>;
      Method : HelpProc;
    public
      constructor Create(Title,oMessage:string;Buttons:MArray<ErrorButtons>;oMethod:HelpProc);
      procedure Show;
      class procedure QuickShow(Title, oMessage:string;Buttons:MArray<ErrorButtons>;oMethod:HelpProc); overload;
      class procedure QuickShow(Title, oMessage:string;Buttons:MArray<ErrorButtons>);overload;
      class procedure QuickShow(Title, oMessage:string;Buttons:array of ErrorButtons;oMethod:HelpProc); overload;
      class procedure QuickShow(Title, oMessage:string;Buttons:array of ErrorButtons);overload;
      class procedure QuickShow(Title, oMessage:string);overload;
      class procedure QuickShow(oMessage:string;Buttons:MArray<ErrorButtons>;oMethod:HelpProc);overload;
      class procedure QuickShow(oMessage:string;Buttons:MArray<ErrorButtons>);overload;
      class procedure QuickShow(oMessage:string;Buttons:array of ErrorButtons;oMethod:HelpProc);overload;
      class procedure QuickShow(oMessage:string;Buttons:array of ErrorButtons);overload;
      class procedure QuickShow(oMessage:string);overload;
  end;
var
  error : TError;
  frmError: TfrmError;

implementation

{$R *.dfm}

{ THelp }

constructor TError.Create(Title, oMessage: string; Buttons: MArray<ErrorButtons>;oMethod:HelpProc);
begin
  sTitle := Title;
  sMEssage := oMessage;
  hButtons := Buttons;
  Method := oMethod;
end;

class procedure TError.QuickShow(Title, oMessage: string);
begin
  QuickShow(Title, oMessage,MArray<ErrorButtons>(hbCancel));
end;

class procedure TError.QuickShow(Title, oMessage: string;
  Buttons: MArray<ErrorButtons>);
begin
  QuickShow(Title,oMessage,Buttons,procedure
  begin
  end)
end;

class procedure TError.QuickShow(Title, oMessage: string;
  Buttons: MArray<ErrorButtons>; oMethod: HelpProc);
begin
  error := TError.Create(Title,oMessage,Buttons,oMethod);
  error.Show;
end;

class procedure TError.QuickShow(oMessage: string);
begin
  QuickShow(oMessage,MArray<ErrorButtons>.Create(TArray<ErrorButtons>.Create(hbCancel)));
end;

class procedure TError.QuickShow(Title, oMessage: string;
  Buttons: array of ErrorButtons);
begin
  QuickShow(Title,oMessage,MArray<ErrorButtons>.Create(Buttons));
end;

class procedure TError.QuickShow(Title, oMessage: string;
  Buttons: array of ErrorButtons; oMethod: HelpProc);
begin
  QuickShow(Title,oMessage,MArray<ErrorButtons>.Create(Buttons),oMethod);
end;

class procedure TError.QuickShow(oMessage: string;
  Buttons: array of ErrorButtons);
begin
  QuickShow(oMessage,MArray<ErrorButtons>.Create(Buttons));
end;

class procedure TError.QuickShow(oMessage: string;
  Buttons: array of ErrorButtons; oMethod: HelpProc);
begin
  QuickShow(oMessage,MArray<ErrorButtons>.Create(Buttons),oMethod);
end;

class procedure TError.QuickShow(oMessage: string;
  Buttons: MArray<ErrorButtons>);
begin
  QuickShow(oMessage,Buttons,procedure
  begin
  end);
end;

class procedure TError.QuickShow(oMessage: string;
  Buttons: MArray<ErrorButtons>; oMethod: HelpProc);
begin
  QuickShow('',oMessage,Buttons,oMethod);
end;

procedure TError.Show;
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
  if error <> nil then
    error.Method();
  Close;
end;

procedure TfrmError.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  error.Free;
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
