object OptionsForm: TOptionsForm
  Left = 198
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Options du Solitaire'
  ClientHeight = 287
  ClientWidth = 225
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
  object FullPanel: TPanel
    Left = 0
    Top = 0
    Width = 225
    Height = 287
    Align = alClient
    TabOrder = 0
    object ColorOptionsGB: TGroupBox
      Left = 8
      Top = 8
      Width = 209
      Height = 107
      Caption = 'Options de couleur'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object ColorLabel: TLabel
        Left = 40
        Top = 80
        Width = 45
        Height = 13
        Caption = 'Couleur : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object AleaColor: TCheckBox
        Left = 16
        Top = 32
        Width = 175
        Height = 17
        Caption = 'Disposition des couleurs al'#233'atoire'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = AleaColorClick
      end
      object OneColor: TCheckBox
        Left = 16
        Top = 56
        Width = 156
        Height = 17
        Caption = 'Une seule couleur affich'#233'e ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = OneColorClick
      end
      object ColorCombo: TComboBox
        Left = 88
        Top = 78
        Width = 113
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ItemIndex = 0
        ParentFont = False
        TabOrder = 2
        Text = 'Rouge'
        Items.Strings = (
          'Rouge'
          'Vert'
          'Bleu'
          'Jaune'
          'Aqua'
          'Violet')
      end
    end
    object BtnPanel: TPanel
      Left = 1
      Top = 212
      Width = 223
      Height = 74
      Align = alBottom
      BevelInner = bvRaised
      BorderStyle = bsSingle
      TabOrder = 1
      object ApplyBtn: TButton
        Left = 6
        Top = 5
        Width = 107
        Height = 25
        Caption = 'Appliquer'
        TabOrder = 0
        OnClick = ApplyBtnClick
      end
      object CancelBtn: TButton
        Left = 120
        Top = 5
        Width = 91
        Height = 25
        Caption = 'Annuler'
        TabOrder = 1
        OnClick = CancelBtnClick
      end
      object AboutBtn: TButton
        Left = 8
        Top = 37
        Width = 105
        Height = 25
        Caption = 'A propos'
        TabOrder = 2
        OnClick = AboutBtnClick
      end
      object HelpBtn: TButton
        Left = 120
        Top = 37
        Width = 91
        Height = 25
        Caption = 'Aide'
        TabOrder = 3
        OnClick = HelpBtnClick
      end
    end
    object SoundsOptionGB: TGroupBox
      Left = 8
      Top = 128
      Width = 209
      Height = 80
      Caption = 'Options de son'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object InfoSound: TCheckBox
        Left = 8
        Top = 32
        Width = 155
        Height = 17
        Caption = 'Activer les sons d'#39'information'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object BackSound: TCheckBox
        Left = 8
        Top = 56
        Width = 143
        Height = 17
        Caption = 'Activer la musique de fond'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
end
