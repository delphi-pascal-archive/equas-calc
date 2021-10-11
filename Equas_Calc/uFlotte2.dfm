object frmFlotte2: TfrmFlotte2
  Left = 188
  Top = 176
  BorderStyle = bsNone
  Caption = 'frmFlotte2'
  ClientHeight = 79
  ClientWidth = 228
  Color = 12307668
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object plSupport: TPanel
    Left = 0
    Top = 0
    Width = 153
    Height = 53
    Caption = 'plSupport'
    ParentColor = True
    TabOrder = 0
    object labTitre: TLabel
      Left = 1
      Top = 1
      Width = 151
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'labTitre'
      ParentShowHint = False
      ShowHint = True
      OnClick = labTitreClick
      OnDblClick = labTitreDblClick
      OnMouseMove = labTitreMouseMove
    end
    object red: TRichEdit
      Left = 0
      Top = 14
      Width = 151
      Height = 17
      TabStop = False
      Anchors = []
      BorderStyle = bsNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Lines.Strings = (
        'red')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      WordWrap = False
      OnMouseDown = redMouseDown
      OnSelectionChange = redSelectionChange
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 164
    Top = 4
  end
end
