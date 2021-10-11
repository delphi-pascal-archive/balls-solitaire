object AboutForm: TAboutForm
  Left = 198
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'A propos ...'
  ClientHeight = 174
  ClientWidth = 185
  Color = 36074
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AboutPanel: TPanel
    Left = 8
    Top = 8
    Width = 169
    Height = 129
    BevelInner = bvRaised
    BorderStyle = bsSingle
    Color = 36074
    TabOrder = 0
    object ProgramLabel: TLabel
      Left = 20
      Top = 5
      Width = 129
      Height = 42
      Caption = 'Solitaire'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -37
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object VersionLabel: TLabel
      Left = 8
      Top = 56
      Width = 85
      Height = 16
      Caption = 'Version 1.4.3.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ProgramIcon: TImage
      Left = 96
      Top = 56
      Width = 60
      Height = 60
      AutoSize = True
    end
    object CommentLabel: TLabel
      Left = 8
      Top = 104
      Width = 94
      Height = 16
      Caption = 'Version stable.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BuildLabel: TLabel
      Left = 8
      Top = 80
      Width = 62
      Height = 16
      Caption = 'Build 133.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object CloseBtn: TButton
    Left = 56
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Fermer'
    TabOrder = 1
    OnClick = CloseBtnClick
  end
end
