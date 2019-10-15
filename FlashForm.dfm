object frmFlash: TfrmFlash
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 264
  ClientWidth = 438
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 438
    Height = 264
    Align = alClient
    ExplicitLeft = 8
    ExplicitTop = 24
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 216
    Top = 128
  end
end
