object frmMarges: TfrmMarges
  Left = 139
  Top = 294
  Width = 236
  Height = 152
  Caption = 'frmMarges'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object nbk: TNotebook
    Left = 0
    Top = 0
    Width = 228
    Height = 125
    Align = alClient
    TabOrder = 0
    OnDblClick = nbkDblClick
    object TPage
      Left = 0
      Top = 0
      Caption = 'Facade'
      object LabHaut: TLabel
        Left = 23
        Top = 12
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Haute :'
        OnDblClick = LabHautDblClick
      end
      object labBas: TLabel
        Left = 23
        Top = 36
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Basse :'
      end
      object labGauche: TLabel
        Left = 14
        Top = 60
        Width = 44
        Height = 13
        Alignment = taRightJustify
        Caption = 'Gauche :'
      end
      object labDroite: TLabel
        Left = 24
        Top = 80
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Droite :'
      end
      object labImpDft: TLabel
        Left = 0
        Top = 112
        Width = 228
        Height = 13
        Align = alBottom
        Alignment = taCenter
        AutoSize = False
        Caption = 'labImpDft'
        Color = clScrollBar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object edHaute: TEdit
        Left = 72
        Top = 12
        Width = 65
        Height = 21
        Hint = 'millimètres'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = 'edHaute'
        OnChange = edHauteChange
      end
      object edBasse: TEdit
        Left = 72
        Top = 34
        Width = 65
        Height = 21
        Hint = 'mm'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Text = 'edBasse'
        OnChange = edHauteChange
      end
      object edGauche: TEdit
        Left = 72
        Top = 56
        Width = 65
        Height = 21
        Hint = 'mm'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Text = 'edGauche'
        OnChange = edHauteChange
      end
      object edDroite: TEdit
        Left = 72
        Top = 78
        Width = 65
        Height = 21
        Hint = 'mm'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = 'edDroite'
        OnChange = edHauteChange
      end
      object btnOK: TButton
        Left = 155
        Top = 56
        Width = 58
        Height = 22
        Caption = 'ok'
        TabOrder = 4
        OnClick = btnOKClick
      end
      object btnEch: TButton
        Left = 155
        Top = 78
        Width = 58
        Height = 22
        Hint = 'Echapper'
        Caption = 'Echapper'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = btnEchClick
      end
      object plPortrait: TPanel
        Left = 155
        Top = 12
        Width = 25
        Height = 34
        BevelOuter = bvNone
        TabOrder = 6
        object Portrait: TImage
          Left = 2
          Top = 2
          Width = 21
          Height = 30
          Hint = 'Portait : clicker'
          AutoSize = True
          ParentShowHint = False
          Picture.Data = {
            07544269746D6170DE010000424DDE0100000000000076000000280000001500
            00001E0000000100040000000000680100000000000000000000100000001000
            0000000000000000BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0
            C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF008000000000000000000000008FFFFFFFFFFFFFFFFFFF00008FFFFFFFFFFF
            FFFFFFFF00008FFFFFFFFFFFFFFFFFFF00008FFFFFFFFFFFFFFFFFFF00008FF8
            FFFFF77FFFFFFFFF00008FF88FFF77F77778888F00008FFF88F77FFFF888F8FF
            00008FFFFFFFFF7778FFFFFF00008FFFFFFF77FF7FFFFFFF00008FFFF7777777
            7777FFFF00008FFFF7FFFFFFFFF7FFFF00008FFFF8FF777777F7FFFF00008FFF
            F8FFFFFFF7F7FFFF00008FFFF8FFFF7FFFF78FFF00008FFF88FFFFFFFFF78FFF
            00008FFF87FF8FFF8FF78FFF00008FFFF7FFFFFFFFF7FFFF00008FFFF7FF7777
            7777FFFF00008FFFF7F777777777FFFF00008FFFF7777777777FFFFF00008FFF
            FFFF777FFFFFFFFF00008FFFFFFFFFFFFFFFFFFF00008FFFFFFFFFFFFFFFFFFF
            00008FFFFFFFFFFFFFF0000000008FFFFFFFFFFFFFF8FFFF80008FFFFFFFFFFF
            FFF8FFF870008FFFFFFFFFFFFFF8FF8770008FFFFFFFFFFFFFF8F87770008888
            88888888888887777000}
          ShowHint = True
          OnClick = PortraitClick
        end
      end
      object plPaysage: TPanel
        Left = 182
        Top = 16
        Width = 34
        Height = 29
        BevelOuter = bvNone
        TabOrder = 7
        object Paysage: TImage
          Left = 2
          Top = 4
          Width = 30
          Height = 21
          Hint = 'Paysage : Clicker'
          AutoSize = True
          ParentShowHint = False
          Picture.Data = {
            07544269746D6170C6010000424DC60100000000000076000000280000001E00
            0000150000000100040000000000500100000000000000000000100000001000
            0000000000000000BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0
            C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF00800000000000000000000000000000008B4F4B4E4B4C4C4C4C4C4C4C4C47
            300084C4E4E4B4C4C4C4C4C4C4C4C43330008C4B4E4E4C4C4C4C4C4C4C4C3322
            200084C4B4B4C4C4C4C4C4C4C433322220008C4C4C4C4C4C4C4C4C32B22222D2
            20008FEFEFEFEFEFEFEFEA222A222D2D20008EEEEEEEEEEEEEEEEEA2222A2222
            20008EEEEEEEEEEEEEEEEEEEEEA2222220008EEEEEEEEEEEEEEEEEEEEEEA2222
            20008EEEEEEEEEEEEEEEEEEEEEEEEA2220008EEEEEEEEEEEEEEEEEEEEEEEEEEA
            A0008EEEEEEEEEEEEEEEEEEEEEEEEEEEE0008EEEEBBEEEEEEEEEEEEEEEEEEEEE
            E0008EEEBFFBEEEEEEEEEEEEEEEEEEEEE0008EEEBFFBEEEEEEEEEEEEEEEE0000
            00008EEEEBBEEEEEEEEEEEEEEEEE8FFFF8008EEEEEEEEEEEEEEEEEEEEEEE8FFF
            87008EEEEEEEEEEEEEEEEEEEEEEE8FF877008EEEEEEEEEEEEEEEEEEEEEEE8F87
            770088888888888888888888888888777700}
          ShowHint = True
          OnClick = PaysageClick
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Params'
      object memoParams: TMemo
        Left = 0
        Top = 0
        Width = 215
        Height = 118
        Hint = 'Dbl-Click = Retour'
        Align = alClient
        ParentShowHint = False
        ScrollBars = ssVertical
        ShowHint = True
        TabOrder = 0
        OnDblClick = memoParamsDblClick
      end
    end
  end
end
