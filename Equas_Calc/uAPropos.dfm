object frmAPropos: TfrmAPropos
  Left = 194
  Top = 214
  Width = 463
  Height = 293
  Caption = 'A propos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 27
    Top = 48
    Width = 54
    Height = 15
    Caption = 'Auteurs : '
    Font.Charset = ANSI_CHARSET
    Font.Color = clOlive
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 18
    Top = 92
    Width = 50
    Height = 15
    Caption = 'Logiciel :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clOlive
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 90
    Top = 48
    Width = 155
    Height = 15
    Caption = 'Gilbert Geyer (codes Delphi)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 90
    Top = 93
    Width = 222
    Height = 15
    Caption = 'Gratuit, EXPERIMENTAL donc perfectible'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 18
    Top = 117
    Width = 330
    Height = 15
    Caption = 'Principale amélioration par rapport à la version précedente : '
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 90
    Top = 70
    Width = 216
    Height = 15
    Caption = 'René Kinzinger (codes en Assembleur)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 47
    Top = 13
    Width = 327
    Height = 23
    Caption = 'Equations_Calculette - Version 8 de 2011'
    Font.Charset = ANSI_CHARSET
    Font.Color = clOlive
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 20
    Top = 229
    Width = 417
    Height = 28
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'N.B. Ce logiciel proposé à titre gracieux ne peut en aucun cas e' +
      'ngager la responsabilité des auteurs en cas de dysfonctionnement' +
      's ou de mauvaises utilisations.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object RichEdit1: TRichEdit
    Left = 18
    Top = 140
    Width = 419
    Height = 69
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      
        'Gain de vitesse d'#39'exécution par utilisation de la nouvelle unit ' +
        'NewGCent '
      'conçue par René Kinzinger téléchargeable ici : '
      'http://www.delphifr.com/code.aspx?ID=53855'
      '.')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
end
