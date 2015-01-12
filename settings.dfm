object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 321
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 43
    Height = 13
    Caption = #1055#1088#1080#1085#1090#1077#1088
  end
  object Label2: TLabel
    Left = 8
    Top = 38
    Width = 108
    Height = 13
    Caption = 'ZPL '#1079#1072#1075#1088#1091#1079#1082#1080' '#1096#1088#1080#1092#1090#1072
  end
  object Label3: TLabel
    Left = 18
    Top = 225
    Width = 98
    Height = 15
    Caption = #1050#1086#1076' '#1074#1072#1083#1080#1076#1072#1094#1080#1080' ZPL'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 109
    Width = 376
    Height = 172
    Caption = 'tportal.vaz.ru'
    TabOrder = 10
    object Label4: TLabel
      Left = 10
      Top = 144
      Width = 174
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1101#1082#1079#1077#1084#1087#1083#1103#1088#1086#1074' ('#1087#1077#1095#1072#1090#1100')'
    end
    object Edit4: TEdit
      Left = 190
      Top = 141
      Width = 35
      Height = 21
      TabOrder = 0
      Text = '1'
    end
  end
  object Button2: TButton
    Left = 308
    Top = 288
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 136
    Top = 8
    Width = 248
    Height = 21
    TabOrder = 1
  end
  object CheckBox1: TCheckBox
    Left = 18
    Top = 153
    Width = 359
    Height = 17
    Caption = #1056#1072#1089#1089#1090#1072#1074#1083#1103#1090#1100' '#1087#1077#1088#1077#1085#1086#1089' '#1089#1090#1088#1086#1082' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1087#1088#1080' '#1079#1072#1075#1088#1091#1079#1082#1077' ZPL '#1080#1079' IE'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 136
    Top = 35
    Width = 248
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object Edit3: TEdit
    Left = 129
    Top = 222
    Width = 248
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object CheckBox2: TCheckBox
    Left = 18
    Top = 199
    Width = 359
    Height = 17
    Caption = #1054#1089#1091#1097#1077#1089#1090#1074#1083#1103#1090#1100' '#1087#1088#1086#1074#1077#1088#1082#1091' '#1079#1072#1075#1088#1091#1078#1077#1085#1085#1086#1075#1086' ZPL'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = CheckBox2Click
  end
  object CheckBox3: TCheckBox
    Left = 8
    Top = 63
    Width = 376
    Height = 17
    Caption = #1056#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100#1089#1103' '#1074' Internet Explorer ('#1082#1085#1086#1087#1082#1072' "'#1055#1077#1095#1072#1090#1100' ZPL")'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object CheckBox4: TCheckBox
    Left = 18
    Top = 130
    Width = 359
    Height = 17
    Caption = #1055#1088#1086#1074#1077#1088#1103#1090#1100' '#1085#1072#1083#1080#1095#1080#1077' ZPL '#1074' '#1086#1090#1082#1088#1099#1090#1086#1084' Internet Explorer '#1087#1088#1080' '#1079#1072#1087#1091#1089#1082#1077
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object CheckBox5: TCheckBox
    Left = 8
    Top = 86
    Width = 376
    Height = 17
    Caption = #1057#1074#1103#1079#1072#1090#1100' c '#1092#1072#1081#1083#1072#1084#1080' *.ZPL'
    TabOrder = 8
    OnClick = CheckBox5Click
  end
  object CheckBox6: TCheckBox
    Left = 18
    Top = 176
    Width = 351
    Height = 17
    Caption = #1054#1089#1090#1072#1074#1083#1103#1090#1100' '#1088#1077#1076#1072#1082#1090#1086#1088' '#1086#1090#1082#1088#1099#1090#1099#1084' '#1087#1086#1089#1083#1077' '#1087#1077#1095#1072#1090#1080' '#1080#1079' IE'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
end
