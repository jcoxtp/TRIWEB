object Form1: TForm1
  Left = 430
  Top = 206
  Width = 434
  Height = 434
  Caption = 'JMail'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 23
    Height = 13
    Caption = 'From'
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 45
    Height = 13
    Caption = 'Recipient'
  end
  object Label3: TLabel
    Left = 8
    Top = 72
    Width = 36
    Height = 13
    Caption = 'Subject'
  end
  object Label4: TLabel
    Left = 8
    Top = 104
    Width = 48
    Height = 13
    Caption = 'Mailserver'
  end
  object Label5: TLabel
    Left = 8
    Top = 184
    Width = 24
    Height = 13
    Caption = 'Body'
  end
  object Label6: TLabel
    Left = 8
    Top = 136
    Width = 54
    Height = 13
    Caption = 'Attachment'
  end
  object Label7: TLabel
    Left = 16
    Top = 376
    Width = 3
    Height = 13
  end
  object Memo1: TMemo
    Left = 96
    Top = 168
    Width = 321
    Height = 185
    TabOrder = 6
  end
  object Button1: TButton
    Left = 264
    Top = 376
    Width = 75
    Height = 25
    Caption = '&Send'
    TabOrder = 7
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 96
    Top = 8
    Width = 321
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 96
    Top = 40
    Width = 321
    Height = 21
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 96
    Top = 72
    Width = 321
    Height = 21
    TabOrder = 2
  end
  object Edit4: TEdit
    Left = 96
    Top = 104
    Width = 321
    Height = 21
    TabOrder = 3
  end
  object Edit5: TEdit
    Left = 96
    Top = 136
    Width = 241
    Height = 21
    TabOrder = 4
  end
  object Button2: TButton
    Left = 344
    Top = 136
    Width = 75
    Height = 21
    Caption = 'Browse'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 344
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Quit'
    TabOrder = 8
    OnClick = Button3Click
  end
  object OpenDialog1: TOpenDialog
    Left = 424
    Top = 8
  end
end
