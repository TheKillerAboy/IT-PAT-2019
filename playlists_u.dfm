object frmPlaylists: TfrmPlaylists
  Left = 0
  Top = 0
  Caption = 'Playlists'
  ClientHeight = 650
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblPlaylists: TLabel
    Left = 8
    Top = 45
    Width = 42
    Height = 13
    Caption = 'Playlists:'
  end
  object Label2: TLabel
    Left = 753
    Top = 5
    Width = 33
    Height = 13
    Caption = 'Songs:'
  end
  object Label3: TLabel
    Left = 706
    Top = 253
    Width = 80
    Height = 13
    Caption = 'Songs in Playlist:'
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
  object pnlNav: TPanel
    Left = 8
    Top = 600
    Width = 778
    Height = 42
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 2
    object btnMainMenu: TButton
      Left = 14
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Main Menu'
      TabOrder = 0
      OnClick = btnMainMenuClick
    end
    object btnSongs: TButton
      Left = 95
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Songs'
      TabOrder = 1
      OnClick = btnSongsClick
    end
  end
  object pnlPlaylist: TPanel
    Left = 8
    Top = 552
    Width = 778
    Height = 42
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 3
    object btnSave: TButton
      Left = 695
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Save'
      Enabled = False
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnEdit: TButton
      Left = 533
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Edit'
      Enabled = False
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnNew: TButton
      Left = 614
      Top = 6
      Width = 75
      Height = 25
      Caption = 'New'
      TabOrder = 2
      OnClick = btnNewClick
    end
    object btnDelete: TButton
      Left = 452
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Delete'
      Enabled = False
      TabOrder = 3
      OnClick = btnDeleteClick
    end
  end
  object pnlDescription: TPanel
    Left = 9
    Top = 400
    Width = 537
    Height = 146
    BevelKind = bkTile
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 4
  end
  object lbxPlaylists: TListBox
    Left = 8
    Top = 64
    Width = 234
    Height = 330
    ItemHeight = 13
    TabOrder = 5
    OnClick = lbxPlaylistsClick
  end
  object pnlInfo: TPanel
    Left = 249
    Top = 8
    Width = 297
    Height = 386
    BevelKind = bkTile
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 6
    object Label4: TLabel
      Left = 8
      Top = 53
      Width = 61
      Height = 13
      Caption = 'Save Folder:'
    end
    object Label5: TLabel
      Left = 248
      Top = 53
      Width = 34
      Height = 13
      Caption = 'Image:'
    end
    object img: TImage
      Left = 8
      Top = 103
      Width = 273
      Height = 274
      Stretch = True
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
    object btnFolder: TButton
      Left = 8
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Link'
      TabOrder = 1
    end
    object btnImage: TButton
      Left = 208
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Link'
      TabOrder = 2
    end
  end
  object lbxSongs: TListBox
    Left = 552
    Top = 8
    Width = 234
    Height = 225
    ItemHeight = 13
    TabOrder = 7
    OnClick = lbxSongsClick
  end
  object lbxSongsinPlaylist: TListBox
    Left = 552
    Top = 272
    Width = 234
    Height = 233
    ItemHeight = 13
    TabOrder = 8
    OnClick = lbxSongsinPlaylistClick
  end
  object btnRemove: TButton
    Left = 711
    Top = 517
    Width = 75
    Height = 25
    Caption = 'Remove'
    Enabled = False
    TabOrder = 9
    OnClick = btnRemoveClick
  end
  object btnAdd: TButton
    Left = 551
    Top = 517
    Width = 75
    Height = 25
    Caption = 'Add'
    Enabled = False
    TabOrder = 10
    OnClick = btnAddClick
  end
end
