object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Main form'
  ClientHeight = 503
  ClientWidth = 536
  Color = clBtnFace
  Constraints.MaxHeight = 530
  Constraints.MaxWidth = 544
  Constraints.MinHeight = 530
  Constraints.MinWidth = 544
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DisplayLabel: TLabel
    Left = 6
    Top = 8
    Width = 475
    Height = 19
    AutoSize = False
    Caption = 'DisplayLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object CloseButton: TButton
    Left = 457
    Top = 471
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 0
    OnClick = CloseButtonClick
  end
  object SpeedUpDown1: TUpDown
    Left = 241
    Top = 285
    Width = 15
    Height = 21
    Associate = SpeedEdit1
    Max = 10
    Position = 2
    TabOrder = 1
  end
  object SpeedUpDown2: TUpDown
    Left = 517
    Top = 285
    Width = 15
    Height = 21
    Associate = SpeedEdit2
    Max = 10
    Position = 3
    TabOrder = 2
  end
  object SpeedEdit1: TEdit
    Left = 6
    Top = 285
    Width = 235
    Height = 21
    TabOrder = 3
    Text = '2'
    OnChange = SpeedEdit1Change
  end
  object SpeedEdit2: TEdit
    Left = 282
    Top = 285
    Width = 235
    Height = 21
    TabOrder = 4
    Text = '3'
    OnChange = SpeedEdit2Change
  end
  object DirectionListBox1: TListBox
    Left = 6
    Top = 312
    Width = 250
    Height = 153
    ItemHeight = 13
    TabOrder = 5
  end
  object DirectionListBox2: TListBox
    Left = 282
    Top = 312
    Width = 250
    Height = 153
    ItemHeight = 13
    TabOrder = 6
  end
  object MyTimer: TTimer
    Interval = 100
    OnTimer = MyTimerTimer
    Left = 496
  end
end
