object FrmCarregaVenda: TFrmCarregaVenda
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FrmCarregaVenda'
  ClientHeight = 135
  ClientWidth = 225
  Color = clAqua
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 8
    Width = 147
    Height = 16
    Caption = 'Digite o numero da venda'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EdtNumVenda: TEdit
    Left = 64
    Top = 30
    Width = 97
    Height = 27
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyPress = EdtNumVendaKeyPress
  end
  object BtnConfirma: TButton
    Left = 16
    Top = 84
    Width = 75
    Height = 33
    Caption = '&Confirma'
    TabOrder = 1
    OnClick = BtnConfirmaClick
  end
  object BtnVoltar: TButton
    Left = 136
    Top = 84
    Width = 75
    Height = 33
    Caption = '&Voltar(ESC)'
    TabOrder = 2
    OnClick = BtnVoltarClick
  end
end
