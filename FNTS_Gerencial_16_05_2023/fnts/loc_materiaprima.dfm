object frmloc_materiaprima: Tfrmloc_materiaprima
  Left = 226
  Top = 75
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Localizar Mat'#233'ria Prima'
  ClientHeight = 381
  ClientWidth = 603
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ViewSplit1: TViewSplit
    Left = 0
    Top = 39
    Width = 603
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 601
  end
  object FlipPanel1: TFlipPanel
    Left = 0
    Top = 0
    Width = 603
    Height = 39
    Align = alTop
    BorderStyle = bsSingle
    ParentColor = False
    ExplicitWidth = 593
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 55
      Height = 13
      Caption = 'Localizar:'
    end
    object loc: TwwIncrementalSearch
      Left = 80
      Top = 7
      Width = 497
      Height = 21
      DataSource = dsmateria_prima
      SearchField = 'PRODUTO'
      CharCase = ecUpperCase
      TabOrder = 0
      OnChange = locChange
      OnEnter = locEnter
      OnExit = locExit
      OnKeyDown = locKeyDown
      OnKeyPress = locKeyPress
    end
  end
  object wwDBGrid1: TwwDBGrid
    Left = 0
    Top = 42
    Width = 603
    Height = 339
    Selected.Strings = (
      'CODIGO'#9'6'#9'C'#211'DIGO'
      'PRODUTO'#9'45'#9'PRODUTO'
      'UNIDADE'#9'3'#9'UN'
      'ESTOQUE'#9'12'#9'ESTOQUE'
      'PRECOCUSTO'#9'11'#9'CUSTO')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dsmateria_prima
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -9
    TitleFont.Name = 'Verdana'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnDblClick = DBGrid1DblClick
    OnKeyPress = DBGrid1KeyPress
    PaintOptions.AlternatingRowColor = 14540253
    PaintOptions.ActiveRecordColor = clRed
    ExplicitWidth = 593
    ExplicitHeight = 329
  end
  object dsmateria_prima: TDataSource
    DataSet = frmindustrializacao.qrmateria_prima
    Left = 216
    Top = 144
  end
end
