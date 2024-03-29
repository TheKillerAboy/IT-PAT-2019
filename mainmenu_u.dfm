object frmMainMenu: TfrmMainMenu
  Left = 0
  Top = 0
  Caption = 'Main Menu'
  ClientHeight = 421
  ClientWidth = 579
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object imgSlideShow: TImage
    Left = 8
    Top = 8
    Width = 563
    Height = 310
    ParentShowHint = False
    ShowHint = False
    Stretch = True
  end
  object Panel1: TPanel
    Left = 8
    Top = 324
    Width = 563
    Height = 89
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 0
    object btnPlaylists: TButton
      Left = 480
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Playlists'
      TabOrder = 0
      OnClick = btnPlaylistsClick
    end
    object btnSongs: TButton
      Left = 480
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Songs'
      TabOrder = 1
      OnClick = btnSongsClick
    end
    object btnSettings: TButton
      Left = 8
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Settings'
      TabOrder = 2
      OnClick = btnSettingsClick
    end
    object btnHelp: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Help'
      TabOrder = 3
      OnClick = btnHelpClick
    end
  end
  object tmrSlideShow: TTimer
    Interval = 2000
    OnTimer = tmrSlideShowTimer
    Left = 400
    Top = 104
  end
end
