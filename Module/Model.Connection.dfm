object Dm: TDm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 403
  Width = 520
  object Fconnection: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Server=127.0.0.1'
      'Port=3306'
      'Password=@WK&Technology#123'
      'Database=teste'
      'User_Name=root')
    Left = 56
    Top = 40
  end
  object DsGrid: TDataSource
    DataSet = QryGrid
    Left = 328
    Top = 94
  end
  object QryVendaItem: TFDQuery
    Connection = Fconnection
    Left = 144
    Top = 46
  end
  object QryVenda: TFDQuery
    Connection = Fconnection
    Left = 208
    Top = 46
  end
  object QryAux: TFDQuery
    Connection = Fconnection
    Left = 264
    Top = 46
  end
  object QryGrid: TFDQuery
    Connection = Fconnection
    Left = 328
    Top = 46
  end
end
