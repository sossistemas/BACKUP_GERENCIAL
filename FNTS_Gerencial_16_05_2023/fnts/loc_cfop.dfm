object frmloc_cfop: Tfrmloc_cfop
  Left = 233
  Top = 183
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'CFOP | Localizar'
  ClientHeight = 407
  ClientWidth = 569
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 41
    Width = 569
    Height = 2
    Align = alTop
  end
  object DBGRID1: TwwDBGrid
    Left = 0
    Top = 43
    Width = 569
    Height = 346
    Selected.Strings = (
      'CFOP'#9'7'#9'CFOP'
      'NATUREZA'#9'50'#9'NATUREZA DA OPERA'#199#195'O'
      'SIMPLIFICADO'#9'30'#9'SIMPLIFICADO')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dscfop
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnDblClick = DBGrid1DblClick
    OnKeyPress = DBGrid1KeyPress
    PaintOptions.AlternatingRowColor = 16316664
    PaintOptions.ActiveRecordColor = clBlack
    ExplicitHeight = 350
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 569
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 45
      Height = 13
      Caption = 'Localizar:'
    end
    object loc: TwwIncrementalSearch
      Left = 64
      Top = 8
      Width = 489
      Height = 21
      DataSource = dscfop
      TabOrder = 0
      OnChange = locChange
      OnEnter = locEnter
      OnExit = locExit
      OnKeyDown = locKeyDown
      OnKeyPress = locKeyPress
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 389
    Width = 569
    Height = 18
    Panels = <>
    ExplicitTop = 393
  end
  object dscfop: TDataSource
    DataSet = frmmodulo.qrCFOP
    Left = 216
    Top = 144
  end
end
