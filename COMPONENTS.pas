unit COMPONENTS;

interface

uses ExtCtrls, StdCtrls,ComCtrls,COMMONS,Dialogs,SysUtils,pngimage,jpeg;

type
  TiggerComponentFunc = reference to function : boolean;

type
  ExtendablePanel = class
    private
      procedure TriggerChange(Sender : TObject);
    public
       class function Extend(_panel:TPanel;title:string;expandable:boolean;_heights : array of integer;_trigger:TiggerComponentFunc):ExtendablePanel;overload;
       class function Extend(_panel:TPanel;title:string):ExtendablePanel;overload;
       function Expanded:boolean;
      var
        panel : TPanel;
        header : TLabel;
        expander : TButton;
        field : TRichEdit;
        trigger : TiggerComponentFunc;
        heights : MArray<Integer>;
  end;

type
  LinkedButtonType = (lbImage,lbFolder,lbMusic);
  ActivatedProc = reference to procedure;

type
  LinkedButton = class
    public
      class function Extend(_button:TButton; _type:LinkedButtonType;dir : string;_act:ActivatedProc):LinkedButton;
      procedure OnClick(Sender:Tobject);
      function TypeToFilter:string;
      function TypeToOptions:TFileDialogOptions;
      var
        button : TButton;
        startDirectory:string;
        OType : LinkedButtonType;
        OFile : TFileName;
        Activation : ActivatedProc;
  end;

implementation

{ ExtendablePanel }

class function ExtendablePanel.Extend(_panel: TPanel;title:string;expandable:boolean;_heights : array of integer;_trigger:TiggerComponentFunc):ExtendablePanel;
begin
  result := ExtendablePanel.Create;
  with result do
  begin                      
    trigger := _trigger;
    if _heights[0] = -1 then
      _heights[0] := 35;
    if _heights[1] = -1 then
      _heights[1] := _panel.Height;
    heights := MArray<Integer>.Create(_heights);
    panel := _panel;
    header := TLabel.Create(panel);
    with header do
    begin
      Parent := panel;
      Caption := title;
      Left := 8;
      Top := 8;
    end;
    if expandable then
    begin
      expander := TButton.Create(panel);
      with expander do
      begin
        Parent := panel;
        Caption := 'Collapse';
        Left := panel.Width-72-8;
        Top := 5;
          OnClick := TriggerChange;
      end;
    end;
    field := TRichEdit.Create(panel);
    with field do
    begin
      Parent := panel;
      Left := 8;
      Width := panel.Width - 16;
      Top := 26;
      Height := panel.Height - 26 - 8;
    end;
  end;
end;

function ExtendablePanel.Expanded: boolean;
begin
  result:=panel.Height = heights[1];
end;

class function ExtendablePanel.Extend(_panel: TPanel;
  title: string): ExtendablePanel;
begin
  result:= Extend(_panel,title,false,[-1,-1],nil);
end;

procedure ExtendablePanel.TriggerChange(Sender: TObject);
begin
  if Assigned(trigger) then
    if trigger() then
    begin
      field.Visible := not field.Visible;
      if field.Visible then
        panel.Height := heights[1]
      else
        panel.Height := heights[0];
    end;
end;

{ LinkedButton }

class function LinkedButton.Extend(_button: TButton; _type:LinkedButtonType; dir : string;_act:ActivatedProc): LinkedButton;
begin
  result:=LinkedButton.Create;
  with result do
  begin
    startDirectory := dir;
    _button.OnClick := OnClick;
    Activation:=_act;
    OType := _type;
  end;                         
end;

procedure LinkedButton.OnClick(Sender: Tobject);
var             
  openDialog : TFileOpenDialog;
  MAoptions : MArray<string>;
begin     
  openDialog:=TFileOpenDialog.Create(button);
  with openDialog do
  begin
    try
      DefaultFolder := startDirectory;
      Options := TypeToOptions;
      with FileTypes.Add do
      begin
         MAOptions := Parser.parse(TypeToFilter,'|');
         DisplayName := MAoptions[0];
         FileMask := MAoptions[1];
      end;
      if Execute then
        OFile := FileName;
        if Assigned(Activation) then 
          Activation();
    finally
      Free;
    end;
  end;
end;

function LinkedButton.TypeToFilter: string;
begin
  case Otype of
    lbImage: result:='Image Files|*.png;*.jpg;*.jpeg';
    lbMusic: result:='Music Files|*.mp3;*.wav';
    lbFolder: result:='Folders|*.*';
  end;
end;

function LinkedButton.TypeToOptions: TFileDialogOptions;
begin
  case Otype of
    lbImage: result:= [fdoPathMustExist, fdoForceFileSystem];
    lbMusic: result:= [fdoPathMustExist, fdoForceFileSystem];
    lbFolder: result:= [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
  end;
end;

end.
