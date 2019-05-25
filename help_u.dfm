object frmHelp: TfrmHelp
  Left = 0
  Top = 0
  Caption = 'Help'
  ClientHeight = 411
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 35
    Width = 21
    Height = 13
    Caption = 'Help'
  end
  object Label2: TLabel
    Left = 485
    Top = 35
    Width = 39
    Height = 13
    Caption = 'Content'
  end
  object tvwHelp: TTreeView
    Left = 8
    Top = 54
    Width = 465
    Height = 301
    Indent = 19
    TabOrder = 0
    OnChange = tvwHelpChange
  end
  object redHelp: TRichEdit
    Left = 479
    Top = 54
    Width = 191
    Height = 301
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object edtSearch: TEdit
    Left = 8
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object btnSearch: TButton
    Left = 144
    Top = 6
    Width = 75
    Height = 25
    Caption = 'Search'
    TabOrder = 3
    OnClick = btnSearchClick
  end
  object Panel1: TPanel
    Left = 8
    Top = 361
    Width = 662
    Height = 42
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 4
    object btnMainMain: TButton
      Left = 575
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Main Menu'
      TabOrder = 0
    end
  end
end
