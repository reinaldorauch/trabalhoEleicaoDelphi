object FmPrinc: TFmPrinc
  Left = 0
  Top = 0
  Caption = 'Elei'#231#227'o'
  ClientHeight = 407
  ClientWidth = 743
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  PopupMenu = PopupMenu
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    743
    407)
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge: TGauge
    Left = 129
    Top = 8
    Width = 530
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Progress = 54
  end
  object Label1: TLabel
    Left = 8
    Top = 14
    Width = 115
    Height = 13
    Caption = 'Progresso da apura'#231#227'o:'
  end
  object PageControlMain: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 40
    Width = 737
    Height = 364
    Margins.Top = 40
    ActivePage = TsLog
    Align = alClient
    TabOrder = 0
    object TsGeral: TTabSheet
      Caption = 'Geral'
      object ChGeral: TChart
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 723
        Height = 330
        AllowPanning = pmNone
        ScrollMouseButton = mbMiddle
        Title.Font.Color = clBlack
        Title.Text.Strings = (
          'Vota'#231#227'o')
        DepthTopAxis.Automatic = False
        DepthTopAxis.AutomaticMaximum = False
        DepthTopAxis.AutomaticMinimum = False
        DepthTopAxis.Maximum = 0.500000000000000000
        DepthTopAxis.Minimum = -0.500000000000000000
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Minimum = 10.000000000000000000
        Panning.MouseWheel = pmwNone
        View3D = False
        Zoom.Allow = False
        Align = alClient
        TabOrder = 0
        ColorPaletteIndex = 13
        object Series1: TBarSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Style = smsValue
          Marks.Visible = True
          Title = 'Votos'
          MultiBar = mbNone
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
          Data = {
            06040000000000000000AC8240FF000000FF0600000043616E64204100000000
            006C814000800000FF0600000043616E6420420000000000188540FFFFFF00FF
            070000004272616E636F730000000000C48840C0C0C000FF050000004E756C6F
            73}
        end
      end
    end
    object TsSecao: TTabSheet
      Caption = 'Se'#231#227'o'
      ImageIndex = 1
      DesignSize = (
        729
        336)
      object ChSecao: TChart
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 526
        Height = 330
        Margins.Right = 200
        AllowPanning = pmNone
        Legend.TextStyle = ltsValue
        Title.Font.Color = clBlack
        Title.Text.Strings = (
          'Votos v'#225'lidos por se'#231#227'o')
        Panning.MouseWheel = pmwNone
        View3D = False
        Zoom.Allow = False
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 147
        ExplicitTop = -21
        ColorPaletteIndex = 13
        object Series2: TBarSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Style = smsValue
          Marks.Visible = True
          Title = 'Cand1'
          Emboss.Color = 8684676
          Shadow.Color = 8684676
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series3: TBarSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Style = smsValue
          Marks.Visible = True
          Title = 'Cand2'
          Emboss.Color = 8487297
          Shadow.Color = 8487297
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
      end
      object PnSecao: TPanel
        Left = 535
        Top = 3
        Width = 191
        Height = 330
        Margins.Left = 535
        Anchors = [akTop, akRight, akBottom]
        Ctl3D = False
        DragKind = dkDock
        Locked = True
        ParentCtl3D = False
        TabOrder = 1
        object ClbSecao: TCheckListBox
          AlignWithMargins = True
          Left = 7
          Top = 7
          Width = 177
          Height = 316
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          OnClickCheck = ClbSecaoClickCheck
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
        end
      end
    end
    object TsValidos: TTabSheet
      Caption = 'V'#225'lidos'
      ImageIndex = 2
      object ChValidos: TChart
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 723
        Height = 330
        Title.Font.Color = -1
        Title.Text.Strings = (
          'Votos v'#225'lidos')
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        Align = alClient
        TabOrder = 0
        ColorPaletteIndex = 13
        object Series5: TPieSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = True
          Title = 'Votos'
          XValues.Order = loAscending
          YValues.Name = 'Pie'
          YValues.Order = loNone
          Frame.InnerBrush.BackColor = clRed
          Frame.InnerBrush.Gradient.EndColor = clGray
          Frame.InnerBrush.Gradient.MidColor = clWhite
          Frame.InnerBrush.Gradient.StartColor = 4210752
          Frame.InnerBrush.Gradient.Visible = True
          Frame.MiddleBrush.BackColor = clYellow
          Frame.MiddleBrush.Gradient.EndColor = 8553090
          Frame.MiddleBrush.Gradient.MidColor = clWhite
          Frame.MiddleBrush.Gradient.StartColor = clGray
          Frame.MiddleBrush.Gradient.Visible = True
          Frame.OuterBrush.BackColor = clGreen
          Frame.OuterBrush.Gradient.EndColor = 4210752
          Frame.OuterBrush.Gradient.MidColor = clWhite
          Frame.OuterBrush.Gradient.StartColor = clSilver
          Frame.OuterBrush.Gradient.Visible = True
          Frame.Visible = False
          Frame.Width = 4
          OtherSlice.Legend.Visible = False
          Data = {
            04020000000000000000707A40FF04000000436172730000000000208E40FF06
            00000050686F6E6573}
        end
      end
    end
    object TsLog: TTabSheet
      Caption = 'Log'
      ImageIndex = 3
      DesignSize = (
        729
        336)
      object LvLog: TListView
        Left = 1
        Top = 3
        Width = 725
        Height = 330
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'Hor'#225'rio do Evento'
            Width = 150
          end
          item
            Caption = 'Evento'
            Width = 570
          end>
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
  end
  object BtnPausa: TButton
    Left = 665
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Pausar'
    TabOrder = 1
    OnClick = BtnPausaClick
  end
  object MainMenu: TMainMenu
    Left = 32
    Top = 336
    object Opes1: TMenuItem
      Caption = 'Op'#231#245'es'
      object AcAbrirConfig1: TMenuItem
        Action = AcAbrirConfig
      end
      object LimparLog1: TMenuItem
        Action = AcCleanLog
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Action = AcProgExit
      end
    end
    object Atualizar1: TMenuItem
      Action = AcUpdate
    end
  end
  object PopupMenu: TPopupMenu
    Left = 104
    Top = 336
    object AcAbrirConfig2: TMenuItem
      Action = AcAbrirConfig
    end
    object LimparLog2: TMenuItem
      Action = AcCleanLog
    end
    object Atualizar2: TMenuItem
      Action = AcUpdate
    end
  end
  object ActionList: TActionList
    Left = 168
    Top = 336
    object AcAbrirConfig: TAction
      Caption = 'Configura'#231#245'es'
      OnExecute = AcAbrirConfigExecute
    end
    object AcProgExit: TAction
      Caption = 'Sair'
      OnExecute = AcProgExitExecute
    end
    object AcUpdate: TAction
      Caption = 'Atualizar'
      OnExecute = AcUpdateExecute
    end
    object AcCleanLog: TAction
      Caption = 'Limpar Log'
      OnExecute = AcCleanLogExecute
    end
  end
  object Timer: TTimer
    OnTimer = AcUpdateExecute
    Left = 224
    Top = 336
  end
end
