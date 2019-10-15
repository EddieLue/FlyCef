object frmFlyMain: TfrmFlyMain
  Left = 0
  Top = 0
  ClientHeight = 376
  ClientWidth = 531
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Chromium1: TChromium
    Left = 0
    Top = 0
    Width = 531
    Height = 376
    Align = alClient
    TabOrder = 0
    OnLoadEnd = Chromium1LoadEnd
    Options = [coPluginsDisabled, coTextAreaResizeDisabled, coDeveloperToolsDisabled]
  end
end
