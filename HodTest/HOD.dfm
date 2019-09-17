object HODTEST1: THODTEST1
  Left = 0
  Top = 0
  Caption = 'HodTest'
  ClientHeight = 530
  ClientWidth = 819
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
  object ADOC: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=SqL2014;Persist Security Info=True;' +
      'User ID=sa;Initial Catalog=HodTest;Data Source=SERVERFES2014\FES' +
      '_UKR'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 16
    Top = 16
  end
  object ADOT1: TADOTable
    Connection = ADOC
    CursorType = ctStatic
    TableName = 'HodTestTime'
    Left = 56
    Top = 16
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 136
    Top = 16
  end
  object ADOT2: TADOTable
    Connection = ADOC
    CursorType = ctStatic
    TableName = 'NameCard'
    Left = 96
    Top = 16
  end
  object TrayIcon1: TTrayIcon
    Animate = True
    OnMouseDown = TrayIcon1MouseDown
    Left = 176
    Top = 16
  end
  object ComPort1: TComPort
    BaudRate = br57600
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    StoredProps = [spBasic]
    TriggersOnRxChar = True
    Left = 224
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    Left = 272
    Top = 16
    object N1: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = N1Click
    end
  end
end
