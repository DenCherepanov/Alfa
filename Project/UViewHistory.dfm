object FViewHistory: TFViewHistory
  Left = 486
  Top = 256
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = #1048#1089#1090#1086#1088#1080#1103' '#1087#1077#1088#1077#1082#1086#1076#1080#1088#1086#1074#1086#1082' '#1091#1083#1080#1094
  ClientHeight = 410
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object cxGridHistory: TcxGrid
    Left = 0
    Top = 0
    Width = 686
    Height = 410
    Align = alClient
    Images = FMain.cxImageList1
    TabOrder = 0
    object cxGridTableView1: TcxGridTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGridTableView1CustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Images = FMain.cxImageList1
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.FocusRect = False
      OptionsView.GroupByBox = False
      OnCustomDrawColumnHeader = cxGridTableView1CustomDrawColumnHeader
      object cxGridTableView1Column1: TcxGridColumn
        Width = 28
      end
      object cxGridTableView1Column2: TcxGridColumn
        Caption = 'OLDSTREETR'
        Width = 93
      end
      object cxGridTableView1Column3: TcxGridColumn
        Caption = 'OLDSTREETF'
        Width = 111
      end
      object cxGridTableView1Column4: TcxGridColumn
        Caption = 'NEWSTREETR'
        Width = 124
      end
      object cxGridTableView1Column5: TcxGridColumn
        Caption = 'NEWSTREETF'
        Width = 99
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridTableView1
    end
  end
end
