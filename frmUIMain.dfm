object UIMain: TUIMain
  Left = 0
  Top = 0
  Caption = 'Demo of how to use html2canvas to create a Screenshot.'
  ClientHeight = 332
  ClientWidth = 581
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    581
    332)
  PixelsPerInch = 96
  TextHeight = 13
  object btnScreenshot: TButton
    Left = 8
    Top = 6
    Width = 565
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Create Screenshot'
    TabOrder = 0
    OnClick = btnScreenshotClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 48
    Width = 565
    Height = 249
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Screenshots'
    TabOrder = 1
    DesignSize = (
      565
      249)
    object lbxScreens: TListBox
      Left = 16
      Top = 16
      Width = 537
      Height = 185
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      TabOrder = 0
      ExplicitHeight = 209
    end
    object btnViewScreen: TButton
      Left = 16
      Top = 207
      Width = 537
      Height = 25
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'View selected screenshot in another browser tab'
      TabOrder = 1
      OnClick = btnViewScreenClick
      ExplicitTop = 231
    end
  end
  object pnlTime: TPanel
    Left = 0
    Top = 303
    Width = 581
    Height = 29
    Align = alBottom
    TabOrder = 2
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 336
    Top = 176
  end
end
