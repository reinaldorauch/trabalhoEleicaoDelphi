object FmConfig: TFmConfig
  Left = 0
  Top = 0
  Caption = 'Configura'#231#245'es'
  ClientHeight = 213
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 102
    Height = 13
    Caption = 'Quantidade de Urnas'
  end
  object EdUrnas: TEdit
    Left = 124
    Top = 13
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '1'
  end
  object UdUrnas: TUpDown
    Left = 245
    Top = 13
    Width = 16
    Height = 21
    Associate = EdUrnas
    Min = 1
    Max = 500
    Position = 1
    TabOrder = 1
    Thousands = False
  end
end
