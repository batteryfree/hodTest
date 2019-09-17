object Form8: TForm8
  Left = 0
  Top = 0
  AutoSize = True
  Caption = #1061#1086#1076#1058#1077#1089#1090
  ClientHeight = 103
  ClientWidth = 374
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 49
    Caption = #1055#1077#1088#1080#1086#1076' '#1089
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 21
      Width = 30
      Height = 13
      Caption = #1044#1072#1090#1072':'
    end
    object DateTimePicker1: TDateTimePicker
      Left = 56
      Top = 16
      Width = 126
      Height = 21
      Date = 42641.639565625000000000
      Time = 42641.639565625000000000
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 188
    Top = 1
    Width = 186
    Height = 48
    Caption = #1055#1077#1088#1080#1086#1076' '#1087#1086
    TabOrder = 1
    object Label3: TLabel
      Left = 16
      Top = 24
      Width = 30
      Height = 13
      Caption = #1044#1072#1090#1072':'
    end
    object DateTimePicker2: TDateTimePicker
      Left = 56
      Top = 16
      Width = 127
      Height = 21
      Date = 42641.639565625000000000
      Time = 42641.639565625000000000
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 120
    Top = 55
    Width = 129
    Height = 25
    Caption = #1057#1074#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1095#1077#1090
    TabOrder = 2
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 86
    Width = 374
    Height = 17
    Step = 1
    TabOrder = 3
  end
  object ADOC: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=SqL2014;Persist Security Info=True;' +
      'User ID=sa;Initial Catalog=HodTest;Data Source=SERVERFES2014\FES' +
      '_UKR'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 8
    Top = 72
  end
  object ADOT1: TADOTable
    Active = True
    Connection = ADOC
    CursorType = ctStatic
    TableName = 'HodTestTime'
    Left = 40
    Top = 72
  end
  object ADOT2: TADOTable
    Active = True
    Connection = ADOC
    CursorType = ctStatic
    TableName = 'NameCard'
    Left = 72
    Top = 72
  end
end
