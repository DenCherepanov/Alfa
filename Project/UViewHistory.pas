unit UViewHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxClasses,
  cxGridCustomView, cxGrid;

type
  TFViewHistory = class(TForm)
    cxGridHistory: TcxGrid;
    cxGridTableView1: TcxGridTableView;
    cxGridTableView1Column1: TcxGridColumn;
    cxGridTableView1Column2: TcxGridColumn;
    cxGridTableView1Column3: TcxGridColumn;
    cxGridTableView1Column4: TcxGridColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridTableView1Column5: TcxGridColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Init;
    procedure FilGrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridTableView1CustomDrawColumnHeader(
      Sender: TcxGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGridTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FViewHistory: TFViewHistory;

implementation

uses Umain,
     UProc;

{$R *.dfm}

procedure TFViewHistory.FormCreate(Sender: TObject);
begin
 Init;
 FilGrid;
end;

procedure TFViewHistory.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TFViewHistory.Init;
begin
 // инициализация грида улиц
 cxGridTableView1.Columns[0].Width:=16;
 cxGridTableView1.Columns[1].Width:=150;
 cxGridTableView1.Columns[2].Width:=150;
 cxGridTableView1.Columns[3].Width:=150;
 cxGridTableView1.Columns[4].Width:=150;
end;

procedure TFViewHistory.FilGrid;
var
  K: Integer;
begin
  // очистка грида
  ClearGrid(cxGridTableView1);

  cxGridTableView1.DataController.BeginUpdate;

  FMain.OracleQuery.Clear;
  FMain.OracleQuery.SQL.Add('select OLDSTREETR,OLDSTREETF,NEWSTREETR,NEWSTREETF from DECODESTREET');
  K:=0;
  try
   FMain.OracleQuery.Execute;
   while not FMain.OracleQuery.EOF do
    begin
     cxGridTableView1.DataController.AppendRecord;
     cxGridTableView1.DataController.Values [K , cxGridTableView1Column2.Index] := FMain.OracleQuery.FieldAsString('OLDSTREETR');
     cxGridTableView1.DataController.Values [K , cxGridTableView1Column3.Index] := FMain.OracleQuery.FieldAsString('OLDSTREETF');
     cxGridTableView1.DataController.Values [K , cxGridTableView1Column4.Index] := FMain.OracleQuery.FieldAsString('NEWSTREETR');
     cxGridTableView1.DataController.Values [K , cxGridTableView1Column5.Index] := FMain.OracleQuery.FieldAsString('NEWSTREETF');
     inc(K);
     FMain.OracleQuery.Next;
    end;
  finally
   cxGridTableView1.DataController.EndUpdate;
  end;
end;

procedure TFViewHistory.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=27 then close;
end;

procedure TFViewHistory.cxGridTableView1CustomDrawColumnHeader(
  Sender: TcxGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
 with AViewInfo do
  begin
   LookAndFeelPainter.DrawHeader(ACanvas, Bounds, TextBounds, Neighbors,
   Borders, ButtonState, AlignmentHorz,  AlignmentVert, MultiLine,
   False, Text, Params.Font, Params.TextColor , Params.Color);
   ACanvas.FillRect(AViewInfo.Bounds, clBtnFace);
   ACanvas.DrawText(Text, TextBounds, AlignmentHorz, AlignmentVert, MultiLine, false);
   ADone := True;
  end;
end;

procedure TFViewHistory.cxGridTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
 R : TRect;
 img_index:integer;
 clmn_name:string;
begin
 if (Sender as TcxCustomGridTableView).Name='cxGridTableView1' then
  begin
   img_index:=3;
   clmn_name:='cxGridTableView1Column1';
  end;
 If AViewInfo.Item.Name = clmn_name then
  Begin
	 R := AViewInfo.Bounds;
	 ACanvas.Brush.Color := AViewInfo.Params.Color;
	 ACanvas.FillRect(R);
	 // рисуем иконку
	 R := AViewInfo.Bounds;
	 ACanvas.DrawImage(FMain.cxImageList1,r.Left+2,r.Top,img_index,True);
	 ADone := True ;
 end;
end;

end.
