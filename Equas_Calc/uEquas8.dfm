object frmEquas7: TfrmEquas7
  Left = 231
  Top = 113
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Equations avec coefficients r'#1081'els ou complexes'
  ClientHeight = 451
  ClientWidth = 682
  Color = 12307669
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    682
    451)
  PixelsPerInch = 96
  TextHeight = 13
  object bResoudre: TSpeedButton
    Left = 8
    Top = 100
    Width = 69
    Height = 21
    Hint = 'R'#1081'soudre l'#39#1081'qua'
    Caption = 'R'#1081'soudre'
    Flat = True
    ParentShowHint = False
    ShowHint = True
    OnClick = bResoudreClick
  end
  object bGenerer: TSpeedButton
    Left = 8
    Top = 73
    Width = 69
    Height = 21
    Hint = 'G'#1081'n'#1081'rer coeffs de l'#39#1081'qua '#1072' partir d'#39'une racine'
    Caption = 'G'#1081'n'#1081'rer'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    PopupMenu = popGenerer
    ShowHint = True
    OnMouseUp = bGenererMouseUp
  end
  object bVoirPlus: TSpeedButton
    Left = 8
    Top = 132
    Width = 69
    Height = 21
    Hint = 'Voir + de d'#1081'tail'
    Caption = 'Voir +'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = bVoirPlusClick
  end
  object bVoirCourbe: TSpeedButton
    Left = 8
    Top = 155
    Width = 69
    Height = 21
    Hint = 'Voir trac'#1081' de la courbe'
    Caption = 'Voir courbe'
    Enabled = False
    Flat = True
    OnClick = bVoirCourbeClick
  end
  object bImprimer3: TSpeedButton
    Left = 8
    Top = 198
    Width = 69
    Height = 21
    Hint = 'Imprimer r'#1081'sultats'
    Enabled = False
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      0800000000000001000000000000000000000001000000010000000000000000
      80000080000000808000800000008000800080800000C0C0C000688DA200BBCC
      D500C0DCC000F0CAA6003F3F5F003F3F7F003F3F9F003F3FBF003F3FDF003F3F
      FF003F5F3F003F5F5F003F5F7F003F5F9F003F5FBF003F5FDF003F5FFF003F7F
      3F003F7F5F003F7F7F003F7F9F003F7FBF003F7FDF003F7FFF003F9F3F003F9F
      5F003F9F7F003F9F9F003F9FBF003F9FDF003F9FFF003FBF3F003FBF5F003FBF
      7F003FBF9F003FBFBF003FBFDF003FBFFF003FDF3F003FDF5F003FDF7F003FDF
      9F003FDFBF003FDFDF003FDFFF003FFF3F003FFF5F003FFF7F003FFF9F003FFF
      BF003FFFDF003FFFFF005F3F3F005F3F5F005F3F7F005F3F9F005F3FBF005F3F
      DF005F3FFF005F5F3F005F5F5F005F5F7F005F5F9F005F5FBF005F5FDF005F5F
      FF005F7F3F005F7F5F005F7F7F005F7F9F005F7FBF005F7FDF005F7FFF005F9F
      3F005F9F5F005F9F7F005F9F9F005F9FBF005F9FDF005F9FFF005FBF3F005FBF
      5F005FBF7F005FBF9F005FBFBF005FBFDF005FBFFF005FDF3F005FDF5F005FDF
      7F005FDF9F005FDFBF005FDFDF005FDFFF005FFF3F005FFF5F005FFF7F005FFF
      9F005FFFBF005FFFDF005FFFFF007F3F3F007F3F5F007F3F7F007F3F9F007F3F
      BF007F3FDF007F3FFF007F5F3F007F5F5F007F5F7F007F5F9F007F5FBF007F5F
      DF007F5FFF007F7F3F007F7F5F007F7F7F007F7F9F007F7FBF007F7FDF007F7F
      FF007F9F3F007F9F5F007F9F7F007F9F9F007F9FBF007F9FDF007F9FFF007FBF
      3F007FBF5F007FBF7F007FBF9F007FBFBF007FBFDF007FBFFF007FDF3F007FDF
      5F007FDF7F007FDF9F007FDFBF007FDFDF007FDFFF007FFF3F007FFF5F007FFF
      7F007FFF9F007FFFBF007FFFDF007FFFFF009F3F3F009F3F5F009F3F7F009F3F
      9F009F3FBF009F3FDF009F3FFF009F5F3F009F5F5F009F5F7F009F5F9F009F5F
      BF009F5FDF009F5FFF009F7F3F009F7F5F009F7F7F009F7F9F009F7FBF009F7F
      DF009F7FFF009F9F3F009F9F5F009F9F7F009F9F9F009F9FBF009F9FDF009F9F
      FF009FBF3F009FBF5F009FBF7F009FBF9F009FBFBF009FBFDF009FBFFF009FDF
      3F009FDF5F009FDF7F009FDF9F009FDFBF009FDFDF009FDFFF009FFF3F009FFF
      5F009FFF7F009FFF9F009FFFBF009FFFDF009FFFFF00BF3F3F00BF3F5F00BF3F
      7F00BF3F9F00BF3FBF00BF3FDF00BF3FFF00BF5F3F00BF5F5F00BF5F7F00BF5F
      9F00BF5FBF00BF5FDF00BF5FFF00BF7F3F00BF7F5F00BF7F7F00BF7F9F00BF7F
      BF00BF7FDF00BF7FFF00BF9F3F00BF9F5F00BF9F7F00BF9F9F00BF9FBF00BF9F
      DF00BF9FFF00BFBF3F00BFBF5F00BFBF7F00BFBF9F00BFBFBF00BFBFDF00BFBF
      FF00BFDF3F00BFDF5F00BFDF7F00BFDF9F00DDE6EA00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00EF0000000000
      000000000000000000EF00090909090909090909090909090900000909090909
      09090909090909090900000000000000000000000000000000000009FF09FF09
      FF09FF09FF09FF09FF0000FFFFFF09FF09FF09FF09FF09F909000009FF09FF09
      FF09FF09FF09FF09FF0000000000000000000000000000000000EFEFEF00FF3B
      FF3B3B3B3BFF00EFEFEFEFEFEF00FFFEFFFEFEFEFEFF00EFEFEFEFEFEF00FFFF
      FFFFFFFFFFFF00EFEFEFEFEFEF0000000000FFFEFEFF00EFEFEFEFEFEFEF00FF
      FF00FFFFFFFF00EFEFEFEFEFEFEFEF00FF00FFFEFEFF00EFEFEFEFEFEFEFEFEF
      0000FFFFFFFF00EFEFEFEFEFEFEFEFEFEF000000000000EFEFEF}
    ParentFont = False
    ParentShowHint = False
    PopupMenu = popImprimer3
    ShowHint = True
    OnMouseDown = bImprimer3MouseDown
  end
  object bCalculette: TSpeedButton
    Left = 8
    Top = 264
    Width = 69
    Height = 36
    Hint = 'Calculette petits ou grands nombres r'#1081'els ou complexes'
    Caption = 'Calculette'
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = bCalculetteClick
  end
  object bAide: TSpeedButton
    Left = 8
    Top = 306
    Width = 69
    Height = 21
    Hint = 'Aide'
    Flat = True
    Glyph.Data = {
      9E050000424D9E05000000000000360400002800000012000000120000000100
      0800000000006801000000000000000000000001000000010000000000000000
      80000080000000808000800000008000800080800000C0C0C000688DA200BBCC
      D500C0DCC000F0CAA60004040400080808000C0C0C0011111100161616001C1C
      1C002222220029292900555555004D4D4D004242420039393900807CFF005050
      FF009300D600FFECCC00C6D6EF00D6E7E70090A9AD0000003300000066000000
      99000000CC00003300000033330000336600003399000033CC000033FF000066
      00000066330000666600006699000066CC000066FF0000990000009933000099
      6600009999000099CC000099FF0000CC000000CC330000CC660000CC990000CC
      CC0000CCFF0000FF660000FF990000FFCC003300000033003300330066003300
      99003300CC003300FF00333300003333330033336600333399003333CC003333
      FF00336600003366330033666600336699003366CC003366FF00339900003399
      330033996600339999003399CC003399FF0033CC000033CC330033CC660033CC
      990033CCCC0033CCFF0033FF330033FF660033FF990033FFCC0033FFFF006600
      00006600330066006600660099006600CC006600FF0066330000663333006633
      6600663399006633CC006633FF00666600006666330066666600666699006666
      CC00669900006699330066996600669999006699CC006699FF0066CC000066CC
      330066CC990066CCCC0066CCFF0066FF000066FF330066FF990066FFCC00CC00
      FF00FF00CC009999000099339900990099009900CC0099000000993333009900
      66009933CC009900FF00996600009966330099336600996699009966CC009933
      FF009999330099996600999999009999CC009999FF0099CC000099CC330066CC
      660099CC990099CCCC0099CCFF0099FF000099FF330099CC660099FF990099FF
      CC0099FFFF00CC00000099003300CC006600CC009900CC00CC0099330000CC33
      3300CC336600CC339900CC33CC00CC33FF00CC660000CC66330099666600CC66
      9900CC66CC009966FF00CC990000CC993300CC996600CC999900CC99CC00CC99
      FF00CCCC0000CCCC3300CCCC6600CCCC9900CCCCCC00CCCCFF00CCFF0000CCFF
      330099FF6600CCFF9900CCFFCC00CCFFFF00CC003300FF006600FF009900CC33
      0000FF333300FF336600FF339900FF33CC00FF33FF00FF660000FF663300CC66
      6600FF669900FF66CC00CC66FF00FF990000FF993300FF996600FF999900FF99
      CC00FF99FF00FFCC0000FFCC3300FFCC6600FFCC9900FFCCCC00FFCCFF00FFFF
      3300CCFF6600FFFF9900FFFFCC006666FF0066FF660066FFFF00FF666600FF66
      FF00FFFF66002100A5005F5F5F00777777008686860096969600CBCBCB00B2B2
      B200D7D7D700DDDDDD00E3E3E300EAEAEA00DDE6EA00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00090909090909
      0909090909090909090909090000090909090909090900000909090909090909
      00000909090909090000F80500090909090909090000090909090000F807FF07
      0500090909090909000009090000F807FFFFF807070500090909090900000900
      F807FFFFF8F800F8070705000909090900000900F8FFF8F800000500F8070705
      0009090900000900F8F800000505050500F80707050009090000090000000505
      050505050500F8070705000900000900F805050505FB0305050500F807000009
      0000090900F80505050507FBFB050500F8000909000009090900F80505030305
      FBFB05050000090900000909090900F80505FBFBFB0305050500090900000909
      09090900F80505050505050500000909000009090909090900F8050505050000
      0909090900000909090909090900F80500000909090909090000090909090909
      0909000009090909090909090000090909090909090909090909090909090909
      0000}
    ParentShowHint = False
    ShowHint = True
    OnClick = bAideClick
  end
  object Bevel1: TBevel
    Left = 97
    Top = 65
    Width = 147
    Height = 2
    Style = bsRaised
  end
  object Bevel2: TBevel
    Left = 260
    Top = 65
    Width = 400
    Height = 2
    Style = bsRaised
  end
  object labDefile: TLabel
    Left = 20
    Top = 432
    Width = 161
    Height = 13
    AutoSize = False
    Caption = 
      'R'#1081'solution '#1081'quations avec m'#1081'thode de Laguerre - R'#1081'solution '#1081'quat' +
      'ions avec m'#1081'thode de Laguerre - '
  end
  object btnAPropos: TSpeedButton
    Left = 8
    Top = 331
    Width = 69
    Height = 21
    Caption = 'A propos'
    Flat = True
    ParentShowHint = False
    ShowHint = True
    OnClick = btnAProposClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 682
    Height = 61
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object labEqua: TLabel
      Left = 124
      Top = 12
      Width = 55
      Height = 13
      Caption = 'Equation '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = labEquaClick
    end
    object labPrecision: TLabel
      Left = 103
      Top = 40
      Width = 56
      Height = 13
      Caption = 'f(x) = 0 '#177' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labRacines: TLabel
      Left = 257
      Top = 12
      Width = 47
      Height = 13
      Caption = 'Racines'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labMis: TLabel
      Left = 328
      Top = 12
      Width = 3
      Height = 13
      Caption = '-'
    end
    object Label2: TLabel
      Left = 6
      Top = 12
      Width = 29
      Height = 13
      Caption = 'Degr'#1081
    end
    object bAutreDegre: TSpeedButton
      Left = 7
      Top = 36
      Width = 70
      Height = 20
      Hint = 'Changement du degr'#1081
      Caption = 'Autre Degr'#1081
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = bAutreDegreClick
    end
    object labNC: TLabel
      Left = 416
      Top = 12
      Width = 15
      Height = 13
      Hint = 'Nombre de chiffres significatifs utilis'#1081's lors des calculs'
      Caption = 'NC'
      ParentShowHint = False
      ShowHint = True
    end
    object Label1: TLabel
      Left = 614
      Top = 12
      Width = 15
      Height = 13
      Hint = 'Nombre de chiffres '#1072' afficher ici par composante du r'#1081'sultat'
      Caption = 'NA'
      ParentShowHint = False
      ShowHint = True
    end
    object edFdeX: TEdit
      Left = 258
      Top = 36
      Width = 403
      Height = 22
      Hint = 
        'Calculer f(x) avec x quelconque (entrer X et double-clicker dess' +
        'us)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = 'edFdeX'
      OnDblClick = edFdeXDblClick
      OnKeyPress = edFdeXKeyPress
    end
    object cbAffichage: TCheckBox
      Left = 476
      Top = 12
      Width = 116
      Height = 13
      Hint = 'Evite l'#39'affichage de r'#1081'sidus inf'#1081'rieurs '#1072' epsilon'
      Caption = 'Afficher valeurs < 10'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 1
      OnClick = cbAffichageClick
    end
    object edDegre: TEdit
      Left = 40
      Top = 9
      Width = 37
      Height = 21
      Hint = 'Degr'#1081' de l'#39#1081'quation'
      BiDiMode = bdRightToLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = '5'
      OnChange = edDegreChange
      OnKeyPress = edDegreKeyPress
      OnKeyUp = edDegreKeyUp
    end
    object edPrecision: TEdit
      Left = 159
      Top = 40
      Width = 38
      Height = 13
      Hint = 'Marge de pr'#1081'cision recherch'#1081'e'
      BorderStyle = bsNone
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = '1E-20'
      OnChange = edPrecisionChange
      OnKeyPress = edPrecisionKeyPress
    end
    object edNC: TEdit
      Left = 435
      Top = 12
      Width = 29
      Height = 15
      Hint = 'Nombre de chiffres significatifs utilis'#1081's lors des calculs'
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Text = '200'
      OnChange = edNCChange
      OnKeyPress = edNCKeyPress
    end
    object edMargeAff: TEdit
      Left = 592
      Top = 8
      Width = 16
      Height = 18
      BorderStyle = bsNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -8
      Font.Name = 'Small Fonts'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 5
      Text = '-20'
      OnChange = edMargeAffChange
    end
    object edNA: TEdit
      Left = 633
      Top = 12
      Width = 27
      Height = 15
      Hint = 'Nombre de chiffres '#1072' afficher ici par composante du r'#1081'sultat'
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Text = '22'
      OnChange = edNAChange
      OnKeyPress = edNAKeyPress
    end
  end
  object edCoEqua: TEdit
    Left = 104
    Top = 295
    Width = 61
    Height = 21
    TabOrder = 1
    Text = 'edCoEqua'
    Visible = False
    OnChange = edCoEquaChange
  end
  object ScrollCoeffs: TScrollBox
    Left = 87
    Top = 69
    Width = 158
    Height = 350
    Anchors = [akLeft, akTop, akBottom]
    BorderStyle = bsNone
    TabOrder = 2
  end
  object ScrollRacines: TScrollBox
    Left = 260
    Top = 69
    Width = 436
    Height = 350
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    TabOrder = 3
    object plProgress: TPanel
      Left = 101
      Top = 88
      Width = 200
      Height = 29
      BevelInner = bvLowered
      TabOrder = 0
      Visible = False
      object plCurProg: TPanel
        Left = 2
        Top = 2
        Width = 29
        Height = 25
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'plCurProg'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 104
    Top = 184
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 105
    Top = 217
  end
  object popGenerer: TPopupMenu
    TrackButton = tbLeftButton
    OnPopup = popGenererPopup
    Left = 104
    Top = 152
    object GenEquaARacineUnique: TMenuItem
      Caption = 'G'#1081'n'#1081'rer '#1081'quation '#1072' racine unique de degr'#1081' N'
      OnClick = GenEquaARacineUniqueClick
    end
    object GenEquaRacineSuppl: TMenuItem
      Caption = 'G'#1081'n'#1081'rer '#1081'qua de degr'#1081' N+1 avec racine suppl'#1081'mentaire suivante'
      OnClick = GenEquaRacineSupplClick
    end
    object GenFragRacineConnue: TMenuItem
      Caption = 'G'#1081'n'#1081'rer '#1081'qua de degr'#1081' N-1 connaissant racine du degr'#1081' N'
      OnClick = GenFragRacineConnueClick
    end
  end
  object popImprimer3: TPopupMenu
    TrackButton = tbLeftButton
    Left = 104
    Top = 252
    object ImprEquation3: TMenuItem
      Caption = 'Imprimer Equation'
      OnClick = ImprEquation3Click
    end
    object ImprRacines3: TMenuItem
      Caption = 'Imprimer Racines'
      OnClick = ImprRacines3Click
    end
    object ImprLesdeux3: TMenuItem
      Caption = 'Imprimer les deux'
      OnClick = ImprLesdeux3Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Modifiermargesdimpression1: TMenuItem
      Caption = 'Modifier marges d'#39'impression'
      OnClick = Modifiermargesdimpression1Click
    end
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 104
    Top = 292
  end
end
