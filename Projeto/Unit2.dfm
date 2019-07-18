object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Geo-Bairros'
  ClientHeight = 525
  ClientWidth = 920
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnClick = FormClick
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 433
    Top = 41
    Width = 487
    Height = 484
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 350
    ExplicitTop = 45
    ExplicitWidth = 468
    ControlData = {
      4C00000055320000063200000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126200000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 920
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 813
    DesignSize = (
      920
      41)
    object Button1: TButton
      Left = 3
      Top = 2
      Width = 148
      Height = 37
      Caption = 'Marcar Pontos'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 768
      Top = 2
      Width = 148
      Height = 37
      Anchors = [akTop, akRight]
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = Button2Click
      ExplicitLeft = 661
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 433
    Height = 484
    Align = alLeft
    TabOrder = 2
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 458
      Width = 431
      Height = 25
      DataSource = DataSource1
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Align = alBottom
      Hints.Strings = (
        'Primeiro'
        'Anterior'
        'Pr'#243'ximo'
        #218'ltimo')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      ExplicitWidth = 343
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 431
      Height = 457
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NOMEBAIRRO'
          Width = 269
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LAT'
          Width = 69
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LNG'
          Width = 68
          Visible = True
        end>
    end
  end
  object GMMap1: TGMMap
    Language = PortuguesBR
    APIKey = 'AIzaSyDRY2EYIQKcdGFMAedzi8De8oDySxmtnIs'
    AfterPageLoaded = GMMap1AfterPageLoaded
    WebBrowser = WebBrowser1
    Left = 464
    Top = 120
  end
  object GMGeoCode1: TGMGeoCode
    Language = PortuguesBR
    Map = GMMap1
    Marker = GMMarker1
    Region = rBRAZIL
    LangCode = lcPORTUGUESE_BRAZIL
    Left = 464
    Top = 56
  end
  object GMMarker1: TGMMarker
    Language = PortuguesBR
    Map = GMMap1
    VisualObjects = <>
    Left = 544
    Top = 56
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = 'G:\ProjetoPortal\PCBFT\GEOBAIRROS.FDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=WIN1252')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    Left = 128
    Top = 57
  end
  object IBTransaction1: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 224
    Top = 57
  end
  object IBQuery1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    ForcedRefresh = True
    AfterOpen = IBQuery1AfterOpen
    Active = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '   A.IDBAIRRO,'
      '   A.NOMEBAIRRO,'
      '   A.LAT,'
      '   A.LNG'
      'FROM'
      '   BAIRRO A'
      'ORDER BY'
      '   A.NOMEBAIRRO')
    Left = 144
    Top = 121
    object IBQuery1IDBAIRRO: TIntegerField
      FieldName = 'IDBAIRRO'
      Origin = '"BAIRRO"."IDBAIRRO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object IBQuery1NOMEBAIRRO: TIBStringField
      FieldName = 'NOMEBAIRRO'
      Origin = '"BAIRRO"."NOMEBAIRRO"'
      Required = True
      Size = 50
    end
    object IBQuery1LAT: TFMTBCDField
      FieldName = 'LAT'
      Origin = '"BAIRRO"."LAT"'
      Precision = 18
      Size = 6
    end
    object IBQuery1LNG: TFMTBCDField
      FieldName = 'LNG'
      Origin = '"BAIRRO"."LNG"'
      Precision = 18
      Size = 6
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = IBQuery1
    Left = 224
    Top = 121
  end
end
