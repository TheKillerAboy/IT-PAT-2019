object frmSongs: TfrmSongs
  Left = 0
  Top = 0
  Caption = 'Songs'
  ClientHeight = 591
  ClientWidth = 762
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
  object lblSongs: TLabel
    Left = 8
    Top = 45
    Width = 33
    Height = 13
    Caption = 'Songs:'
  end
  object edtSearch: TEdit
    Left = 8
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object btnSearch: TButton
    Left = 144
    Top = 6
    Width = 75
    Height = 25
    Caption = 'Search'
    TabOrder = 1
    OnClick = btnSearchClick
  end
  object lbxSongs: TListBox
    Left = 8
    Top = 64
    Width = 234
    Height = 209
    ItemHeight = 13
    TabOrder = 2
    OnClick = lbxSongsClick
  end
  object pnlInfo: TPanel
    Left = 248
    Top = 8
    Width = 513
    Height = 265
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 3
    object Label4: TLabel
      Left = 8
      Top = 205
      Width = 55
      Height = 13
      Caption = 'Music File*:'
    end
    object Label5: TLabel
      Left = 464
      Top = 2
      Width = 34
      Height = 13
      Caption = 'Image:'
    end
    object img: TImage
      Left = 272
      Top = 52
      Width = 225
      Height = 197
      Stretch = True
    end
    object Label1: TLabel
      Left = 8
      Top = 53
      Width = 68
      Height = 13
      Caption = 'Release Date:'
    end
    object Label2: TLabel
      Left = 8
      Top = 101
      Width = 45
      Height = 13
      Caption = 'Duration:'
    end
    object edtName: TLabeledEdit
      Left = 8
      Top = 23
      Width = 121
      Height = 21
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = 'Name*:'
      TabOrder = 0
    end
    object btnMusicFile: TButton
      Left = 8
      Top = 224
      Width = 75
      Height = 25
      Caption = 'Link'
      TabOrder = 1
    end
    object btnImage: TButton
      Left = 424
      Top = 21
      Width = 75
      Height = 25
      Caption = 'Link'
      TabOrder = 2
    end
    object dtpDate: TDateTimePicker
      Left = 8
      Top = 72
      Width = 186
      Height = 21
      Date = 43612.219026620370000000
      Time = 43612.219026620370000000
      TabOrder = 3
    end
    object dtpDuration: TDateTimePicker
      Left = 8
      Top = 120
      Width = 186
      Height = 21
      Date = 43612.219026620370000000
      Format = 'mm:ss'
      Time = 43612.219026620370000000
      Kind = dtkTime
      TabOrder = 4
    end
  end
  object pnlDescription: TPanel
    Left = 8
    Top = 279
    Width = 753
    Height = 34
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 4
  end
  object pnlHistory: TPanel
    Left = 8
    Top = 319
    Width = 752
    Height = 34
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 5
  end
  object pnlLyrics: TPanel
    Left = 8
    Top = 359
    Width = 752
    Height = 34
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 6
  end
  object pnlPlaylist: TPanel
    Left = 8
    Top = 495
    Width = 753
    Height = 42
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 7
    object btnSave: TButton
      Left = 665
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Save'
      Enabled = False
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnEdit: TButton
      Left = 503
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Edit'
      Enabled = False
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnNew: TButton
      Left = 584
      Top = 6
      Width = 75
      Height = 25
      Caption = 'New'
      TabOrder = 2
      OnClick = btnNewClick
    end
    object btnDelete: TButton
      Left = 422
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Delete'
      Enabled = False
      TabOrder = 3
      OnClick = btnDeleteClick
    end
  end
  object pnlNav: TPanel
    Left = 8
    Top = 543
    Width = 753
    Height = 42
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 8
    object btnMusicPlayer: TButton
      Left = 626
      Top = 7
      Width = 114
      Height = 25
      Caption = 'Open in Music Player'
      TabOrder = 0
    end
    object btnMainMenu: TButton
      Left = 14
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Main Menu'
      TabOrder = 1
    end
    object btnSongs: TButton
      Left = 95
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Songs'
      TabOrder = 2
    end
  end
end
