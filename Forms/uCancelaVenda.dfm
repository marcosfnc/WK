object FrmCancelarVenda: TFrmCancelarVenda
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Cancelar Venda'
  ClientHeight = 128
  ClientWidth = 227
  Color = clGradientActiveCaption
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
    Left = 18
    Top = 8
    Width = 188
    Height = 18
    Caption = 'Informe o n'#250'mero da Venda'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EdtNumNota: TEdit
    Left = 50
    Top = 32
    Width = 121
    Height = 33
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyPress = EdtNumNotaKeyPress
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
