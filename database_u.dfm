object dmDataBase: TdmDataBase
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 347
  Width = 393
  object conDataBase: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\GitHub\IT-PAT-20' +
      '19\PAT2019.mdb;Persist Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 128
    Top = 160
  end
  object tblSongs: TADOTable
    Connection = conDataBase
    CursorType = ctStatic
    TableName = 'Songs'
    Left = 104
    Top = 248
  end
  object tblPlaylists: TADOTable
    Connection = conDataBase
    CursorType = ctStatic
    TableName = 'Playlists'
    Left = 160
    Top = 248
  end
  object tblPofS: TADOTable
    Connection = conDataBase
    CursorType = ctStatic
    TableName = 'PlaylistsOFSongs'
    Left = 216
    Top = 248
  end
end
