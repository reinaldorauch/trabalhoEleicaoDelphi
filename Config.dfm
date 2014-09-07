object FmConfig: TFmConfig
  Left = 0
  Top = 0
  Caption = 'Configura'#231#245'es'
  ClientHeight = 202
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 172
    Width = 102
    Height = 13
    Caption = 'Quantidade de Urnas'
  end
  object Label2: TLabel
    Left = 16
    Top = 18
    Width = 101
    Height = 13
    Caption = 'Nome do candidato 1'
  end
  object Label3: TLabel
    Left = 264
    Top = 18
    Width = 17
    Height = 13
    Caption = 'Cor'
  end
  object Cor: TLabel
    Left = 264
    Top = 46
    Width = 17
    Height = 13
    Caption = 'Cor'
  end
  object Label4: TLabel
    Left = 16
    Top = 46
    Width = 101
    Height = 13
    Caption = 'Nome do candidato 2'
  end
  object Label5: TLabel
    Left = 243
    Top = 74
    Width = 38
    Height = 13
    Caption = 'Brancos'
  end
  object Nulos: TLabel
    Left = 255
    Top = 102
    Width = 26
    Height = 13
    Caption = 'Nulos'
  end
  object Label6: TLabel
    Left = 8
    Top = 130
    Width = 156
    Height = 13
    Caption = 'Pasta para os arquivos de se'#231#227'o'
  end
  object EdUrnas: TEdit
    Left = 124
    Top = 169
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 0
    Text = '80'
  end
  object UdUrnas: TUpDown
    Left = 245
    Top = 169
    Width = 16
    Height = 21
    Associate = EdUrnas
    Min = 1
    Max = 500
    Position = 80
    TabOrder = 1
    Thousands = False
  end
  object EdCand1: TEdit
    Left = 124
    Top = 15
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object CbCand1: TColorBox
    Left = 287
    Top = 15
    Width = 145
    Height = 22
    TabOrder = 3
  end
  object CbCand2: TColorBox
    Left = 287
    Top = 43
    Width = 145
    Height = 22
    TabOrder = 4
  end
  object EdCand2: TEdit
    Left = 124
    Top = 43
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object CbBrancos: TColorBox
    Left = 287
    Top = 71
    Width = 145
    Height = 22
    TabOrder = 6
  end
  object CbNulos: TColorBox
    Left = 287
    Top = 99
    Width = 145
    Height = 22
    TabOrder = 7
  end
  object EdFileDir: TEdit
    Left = 170
    Top = 127
    Width = 262
    Height = 21
    TabOrder = 8
    OnChange = EdFileDirChange
  end
  object BtnSalvar: TButton
    Left = 357
    Top = 167
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 9
    OnClick = BtnSalvarClick
  end
end
