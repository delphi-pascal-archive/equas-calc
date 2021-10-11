object frmCourbe: TfrmCourbe
  Left = 191
  Top = 244
  Width = 589
  Height = 275
  Caption = 'Trac� de courbe f(x)'
  Color = 12307668
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnMouseMove = plGaucheMouseMove
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object plCourbe: TPanel
    Left = 0
    Top = 0
    Width = 581
    Height = 248
    Align = alClient
    ParentColor = True
    TabOrder = 0
    object imgF: TImage
      Left = 29
      Top = 1
      Width = 523
      Height = 212
      Cursor = crCross
      Align = alClient
      Visible = False
      OnMouseDown = imgFMouseDown
      OnMouseMove = imgFMouseMove
    end
    object SpeedButton1: TSpeedButton
      Left = 4
      Top = 89
      Width = 20
      Height = 20
      Hint = 'Echelles X et Y'
      Caption = 'E'
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object labCoos: TLabel
      Left = 44
      Top = 140
      Width = 38
      Height = 13
      Cursor = crCross
      Caption = 'labCoos'
      Color = clBtnFace
      ParentColor = False
      Transparent = True
    end
    object plGauche: TPanel
      Left = 1
      Top = 1
      Width = 28
      Height = 212
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      OnMouseDown = Panel1MouseDown
      OnMouseMove = plGaucheMouseMove
      object bAgrandirY: TSpeedButton
        Left = 4
        Top = 11
        Width = 20
        Height = 20
        Hint = 'Multiplier �chelle des Y par 2'
        Flat = True
        Glyph.Data = {
          16050000424D160500000000000036040000280000000E0000000E0000000100
          080000000000E000000000000000000000000001000000010000000000000000
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
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00090909090909
          0909090909090909000009090909090909090909090909090000090909090909
          0909090909090909000009090909090909090909090909090000090909090909
          09090909090909090000090909F9F9F9F9F9F9F9F9F90909000009090909F9F9
          F9F9F9F9F909090900000909090909F9F9F9F9F9090909090000090909090909
          F9F9F90909090909000009090909090909F90909090909090000090909090909
          0909090909090909000009090909090909090909090909090000090909090909
          0909090909090909000009090909090909090909090909090000}
        ParentShowHint = False
        ShowHint = True
        OnClick = bAgrandirYClick
      end
      object bReduireY: TSpeedButton
        Left = 4
        Top = 62
        Width = 20
        Height = 20
        Hint = 'Diviser �chelle des Y par 2'
        Flat = True
        Glyph.Data = {
          16050000424D160500000000000036040000280000000E0000000E0000000100
          080000000000E000000000000000000000000001000000010000000000000000
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
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00090909090909
          0909090909090909000009090909090909090909090909090000090909090909
          0909090909090909000009090909090909090909090909090000090909090909
          F90909090909090900000909090909F9F9F9090909090909000009090909F9F9
          F9F9F909090909090000090909F9F9F9F9F9F9F90909090900000909F9F9F9F9
          F9F9F9F9F9090909000009090909090909090909090909090000090909090909
          0909090909090909000009090909090909090909090909090000090909090909
          0909090909090909000009090909090909090909090909090000}
        ParentShowHint = False
        ShowHint = True
        OnClick = bReduireYClick
      end
      object bAjusterCourbe: TSpeedButton
        Left = 4
        Top = 36
        Width = 20
        Height = 20
        Hint = 'Echelle Y = Echelle X'
        Caption = '='
        Flat = True
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        OnClick = bAjusterCourbeClick
      end
      object bEchelles: TSpeedButton
        Left = 4
        Top = 85
        Width = 20
        Height = 20
        Hint = 'Echelles + Couleurs'
        Caption = 'E'
        Flat = True
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ShowHint = True
        OnMouseUp = bEchellesMouseUp
      end
    end
    object plDroit: TPanel
      Left = 552
      Top = 1
      Width = 28
      Height = 212
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      OnMouseDown = Panel1MouseDown
      OnMouseMove = plGaucheMouseMove
      object bCopier2: TSpeedButton
        Left = 4
        Top = 63
        Width = 20
        Height = 20
        Hint = 'Courbe Vers presse-papier'
        Flat = True
        Glyph.Data = {
          42010000424D4201000000000000760000002800000011000000110000000100
          040000000000CC00000000000000000000001000000010000000000000008400
          0000CED6D60084FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00222222222222
          2222200000002222222222222222200000002222222222222222200000002222
          2220000000002000000022222220333333302000000022222220300000302000
          0000200000003333333020000000204444403000003020000000204000003333
          3330200000002044444030030000200000002040000033330402200000002044
          4440333300222000000020400400000002222000000020444404022222222000
          0000204444002222222220000000200000022222222220000000222222222222
          222220000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = bCopier2Click
      end
      object bSauver2: TSpeedButton
        Left = 4
        Top = 31
        Width = 20
        Height = 20
        Hint = 'Sauver courbe'
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000688DA200BBCC
          D5000000330000006600000099000000CC000033000000333300003366000033
          99000033CC000033FF00006600000066330000666600006699000066CC000066
          FF00009900000099330000996600009999000099CC000099FF0000CC000000CC
          330000CC660000CC990000CCCC0000CCFF0000FF330000FF660000FF990000FF
          CC00330000003300330033006600330099003300CC003300FF00333300003333
          330033336600333399003333CC003333FF003366000033663300336666003366
          99003366CC003366FF00339900003399330033996600339999003399CC003399
          FF0033CC000033CC330033CC660033CC990033CCCC0033CCFF0033FF000033FF
          330033FF660033FF990033FFCC0033FFFF006600000066003300660066006600
          99006600CC006600FF00663300006633330066336600663399006633CC006633
          FF00666600006666330066666600666699006666CC006666FF00669900006699
          330066996600669999006699CC006699FF0066CC000066CC330066CC660066CC
          990066CCCC0066CCFF0066FF000066FF330066FF660066FF990066FFCC0066FF
          FF00990000009900330099006600990099009900CC009900FF00993300009933
          330099336600993399009933CC009933FF009966000099663300996666009966
          99009966CC009966FF00999900009999330099996600999999009999CC009999
          FF0099CC000099CC330099CC660099CC990099CCCC0099CCFF0099FF000099FF
          330099FF660099FF990099FFCC0099FFFF00CC000000CC003300CC006600CC00
          9900CC00CC00CC00FF00CC330000CC333300CC336600CC339900CC33CC00CC33
          FF00CC660000CC663300CC666600CC669900CC66CC00CC66FF00CC990000CC99
          3300CC996600CC999900CC99CC00CC99FF00CCCC0000CCCC3300CCCC6600CCCC
          9900CCCCCC00CCCCFF00CCFF0000CCFF3300CCFF6600CCFF9900CCFFCC00CCFF
          FF00FF003300FF006600FF009900FF00CC00FF330000FF333300FF336600FF33
          9900FF33CC00FF33FF00FF660000FF663300FF666600FF669900FF66CC00FF66
          FF00FF990000FF993300FF996600FF999900FF99CC00FF99FF00FFCC0000FFCC
          3300FFCC6600FFCC9900FFCCCC00FFCCFF00FFFF3300FFFF6600FFFF9900FFFF
          CC0006030600A98511001286950022C6D0002113A200374815008F898C00B7C7
          8D00EEC4290020475400A8C8CF0065865B00248BCB009284DA009A5D5000185C
          890099E4CB00AA875300174CD1009DA8910025A5D700C7A75100984E8A00081F
          45005F665700B54D1A00BDE89300E2AA1000DDE6EA00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00090909090909
          0909090909090909090909090000000000000000000000000009090003030000
          0000000009090003000909000303000000000000090900030009090003030000
          0000000009090003000909000303000000000000000000030009090003030303
          0303030303030303000909000303000000000000000003030009090003000909
          0909090909090003000909000300090909090909090900030009090003000909
          0909090909090003000909000300090909090909090900030009090003000909
          0909090909090000000909000300090909090909090900090009090000000000
          0000000000000000000909090909090909090909090909090909}
        ParentShowHint = False
        ShowHint = True
        OnClick = bSauver2Click
      end
      object bImprimer2: TSpeedButton
        Left = 4
        Top = 7
        Width = 20
        Height = 20
        Hint = 'Imprimer courbe'
        Flat = True
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
        ParentShowHint = False
        ShowHint = True
        OnMouseUp = bImprimer2MouseUp
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 213
      Width = 579
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      Color = 12307668
      TabOrder = 2
      OnMouseDown = Panel1MouseDown
      object bInfos: TSpeedButton
        Left = 5
        Top = 4
        Width = 20
        Height = 20
        Hint = 'Infos d'#39'accueil'
        Caption = '?'
        Flat = True
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ShowHint = True
        OnClick = bInfosClick
      end
      object bCopierLuc: TSpeedButton
        Left = 58
        Top = 0
        Width = 20
        Height = 11
        Hint = 'Copier lucarne dans presse-papier'
        Glyph.Data = {
          6E040000424D6E04000000000000360400002800000007000000070000000100
          0800000000003800000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A60000000000FFFF00004242420084848400BDCED600CED6D600FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000F0F0F0F0F0F
          0F000F0F0F0F0F0F0F000F0FFBFBFB0F0F000F0F0000000F0F000F0FFBFBFB0F
          0F000F0F0F0F0F0F0F000F0F0F0F0F0F0F00}
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        OnClick = bCopierLucClick
      end
      object bCollerDansLuc: TSpeedButton
        Left = 86
        Top = 0
        Width = 20
        Height = 11
        Hint = 'Coller presse-papier dans lucarne'
        Glyph.Data = {
          6E040000424D6E04000000000000360400002800000007000000070000000100
          0800000000003800000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A60000000000FFFF00004242420084848400BDCED600CED6D600FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000F0F0F0F0F0F
          0F000F0F0F0F0F0F0F000F0F0000000F0F000F0FFBFBFB0F0F000F0F0000000F
          0F000F0F0F0F0F0F0F000F0F0F0F0F0F0F00}
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        OnClick = bCollerDansLucClick
      end
      object bLucVersVoirPlus: TSpeedButton
        Left = 113
        Top = 0
        Width = 20
        Height = 11
        Hint = 'Copier lucarne vers Voir +'
        Glyph.Data = {
          8A040000424D8A0400000000000036040000280000000A000000070000000100
          0800000000005400000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A60000000000FFFF00004242420084848400BDCED600CED6D600FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000F0F0F0F0F0F
          0F0F0F0F00000F0F0F0F0F0F0F0F0F0F00000F0F020F0F0F0F020F0F00000F02
          0F020F0F0202020F00000F020F020F0F0F020F0F00000F0F0F0F0F0F0F0F0F0F
          00000F0F0F0F0F0F0F0F0F0F0000}
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        OnClick = bLucVersVoirPlusClick
      end
      object bImprimerLuc: TSpeedButton
        Left = 141
        Top = 0
        Width = 20
        Height = 11
        Hint = 'Imprimer lucarne'
        Glyph.Data = {
          6E040000424D6E04000000000000360400002800000007000000070000000100
          0800000000003800000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A60000000000FFFF00004242420084848400BDCED600CED6D600FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000F0F0F0F0F0F
          0F000F0F0F0F0F0F0F000F0F0B0B0B0F0F000F0F1010100F0F000F0F0B0B0B0F
          0F000F0F0F0F0F0F0F000F0F0F0F0F0F0F00}
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        OnClick = bImprimerLucClick
      end
      object bSauverLuc: TSpeedButton
        Left = 169
        Top = 0
        Width = 20
        Height = 11
        Hint = 'Sauver lucarne'
        Glyph.Data = {
          6E040000424D6E04000000000000360400002800000007000000070000000100
          0800000000003800000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A60000000000FFFF00004242420084848400BDCED600CED6D600FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000F0F0F0F0F0F
          0F000F0F0F0F0F0F0F000F0F0000000F0F000F0F000F000F0F000F0F0000000F
          0F000F0F0F0F0F0F0F000F0F0F0F0F0F0F00}
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        OnClick = bSauverLucClick
      end
      object bEffaceLuc: TSpeedButton
        Left = 30
        Top = 0
        Width = 20
        Height = 11
        Hint = 'Effacer lucarne'
        Glyph.Data = {
          6E040000424D6E04000000000000360400002800000007000000070000000100
          0800000000003800000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A60000000000FFFF00004242420084848400BDCED600CED6D600FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000F0F0F0F0F0F
          0F000FF90F0F0F0F0F000F0FF90FF90F0F000F0F0FF90F0F0F000F0FF90FF90F
          0F000F0F0F0F0FF90F000F0F0F0F0F0F0F00}
        Layout = blGlyphTop
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        OnClick = bEffaceLucClick
      end
      object UpDown1: TUpDown
        Left = 556
        Top = 10
        Width = 16
        Height = 17
        Hint = 'Rappel des Racines'
        Anchors = [akTop, akRight]
        Min = -10000
        Max = 10000
        ParentShowHint = False
        Position = 0
        ShowHint = True
        TabOrder = 0
        Thousands = False
        Wrap = False
        OnClick = UpDown1Click
      end
      object Red1: TRichEdit
        Left = 29
        Top = 10
        Width = 523
        Height = 20
        ScrollBars = ssVertical
        TabOrder = 1
        OnKeyPress = Red1KeyPress
      end
    end
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 512
    Top = 32
  end
  object popEchellesCoul: TPopupMenu
    Left = 57
    Top = 317
    object EchellesXetY: TMenuItem
      Caption = 'Echelles suivant X et Y'
    end
    object CouleursDeLaCourbe1: TMenuItem
      Caption = 'Couleurs de la courbe'
      object InfosSurCouleurs: TMenuItem
        Caption = 'Infos sur'
      end
      object ModifierCoul: TMenuItem
        Caption = 'Modifier'
        object ArcEnCiel: TMenuItem
          Caption = 'Arc-en-ciel'
          Checked = True
        end
        object Monochrome: TMenuItem
          Caption = 'Monochrome'
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 48
    Top = 80
    object EchellesXetY2: TMenuItem
      Caption = 'Echelles suivant X et Y'
      OnClick = EchellesXetY2Click
    end
    object CouleursCourbe2: TMenuItem
      Caption = 'Couleurs de la courbe'
      object InfosSurCoul: TMenuItem
        Caption = 'Infos sur'
        OnClick = InfosSurCoulClick
      end
      object Modifier1: TMenuItem
        Caption = 'Modifier'
        object Arcenciel2: TMenuItem
          Caption = 'Arc en ciel'
          Checked = True
          OnClick = Arcenciel2Click
        end
        object Monochrome2: TMenuItem
          Caption = 'Monochrome'
          OnClick = Monochrome2Click
        end
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 352
    Top = 168
  end
end