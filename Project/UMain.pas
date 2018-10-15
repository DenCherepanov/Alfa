unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Oracle, dxStatusBar, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxSkinsdxStatusBarPainter, DB, OracleData, dxSkinsdxBarPainter,
  cxClasses, dxBar, ImgList, ComCtrls, cxContainer, cxEdit, cxTreeView,
  cxGroupBox, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxVGrid, cxInplaceContainer, cxSplitter, dxBevel, StdCtrls, Menus,
  cxButtons, Buttons, cxTextEdit, cxCheckBox;

type
  TFMain = class(TForm)
    OracleSession: TOracleSession;
    OracleLogon: TOracleLogon;
    dxStatusBar: TdxStatusBar;
    dxBarManager: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    btnConnect: TdxBarButton;
    btnRefresh: TdxBarButton;
    cxTreeCity: TcxTreeView;
    OracleQuery: TOracleQuery;
    cxImageList1: TcxImageList;
    cxGroupBox1: TcxGroupBox;
    cxSplitter1: TcxSplitter;
    cxGroupBox2: TcxGroupBox;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTableView: TcxGridTableView;
    cxGridTableViewColumn1: TcxGridColumn;
    cxGridTableViewColumn2: TcxGridColumn;
    cxGridTableViewColumn3: TcxGridColumn;
    cxGridTableViewColumn4: TcxGridColumn;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    cxGridTableViewColumn5: TcxGridColumn;
    cxGroupBox3: TcxGroupBox;
    cxGroupBox4: TcxGroupBox;
    cxSplitter2: TcxSplitter;
    cxGrid1: TcxGrid;
    cxGridTableView1: TcxGridTableView;
    cxGridLevel1: TcxGridLevel;
    cxGridTableView1Column1: TcxGridColumn;
    cxGridTableView1Column2: TcxGridColumn;
    cxGridTableView1Column3: TcxGridColumn;
    cxGridTableView1Column4: TcxGridColumn;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    btnFilter: TcxButton;
    btnFilterCancel: TcxButton;
    cxTextEdit: TcxTextEdit;
    cxGroupBox5: TcxGroupBox;
    cxCheckBox1: TcxCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConnectDB;
    procedure Init;
    procedure btnConnectClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure cxTreeCityClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure cxGridTableViewCustomDrawColumnHeader(
      Sender: TcxGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGridTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure MenuItem1Click(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure btnFilterCancelClick(Sender: TObject);
    procedure cxCheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

uses UProc,
     UViewHistory;

{$R *.dfm}

procedure TFMain.FormCreate(Sender: TObject);
begin
 ConnectDB;
 btnRefreshClick(self);
 Init;
end;

// процедура проверки соединение с сервером
procedure TFMain.ConnectDB;
begin
 if not OracleSession.Connected then OracleLogon.Execute
 else ShowMessage('Соединение с сервером уже установлено!');
 if OracleSession.Connected then dxStatusBar.Panels[0].Text:='Соединение установлено.'
 else dxStatusBar.Panels[0].Text:='Соединение не установлено.'
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 OracleSession.LogOff;
end;

procedure TFMain.btnConnectClick(Sender: TObject);
begin
 ConnectDB;
end;

procedure TFMain.btnRefreshClick(Sender: TObject);
var
 tn:TTreeNode;
 id:tstr;
begin
 if not OracleSession.Connected then Exit;
 dxStatusBar.Panels[1].Text:='';
 cxTreeCity.Items.Clear;
 OracleQuery.Clear;
 OracleQuery.SQL.Add('select CODECITY,NAMECITY,ABBR from SCity order by NAMECITY');
 try
  OracleQuery.Execute;
  while not OracleQuery.EOF do
   begin
    new(id);
    id.id:=OracleQuery.FieldAsString('CODECITY');
    tn:=cxTreeCity.Items.AddChildObject(nil,OracleQuery.FieldAsString('NAMECITY') + '   ( ' + OracleQuery.FieldAsString('ABBR') + ' )',pointer(id));
    tn.ImageIndex:=0;
    OracleQuery.Next;
   end;
 except
  on E: EOracleError do
   begin
    ShowMessage(E.Message);
    dxStatusBar.Panels[1].Text:=E.Message;
   end;
 end;
end;

procedure TFMain.Init;
begin
 // инициализация грида улиц
 cxGridTableView.Columns[0].Width:=16;
 cxGridTableView.Columns[1].Width:=150;
 cxGridTableView.Columns[2].Width:=150;
 cxGridTableView.Columns[3].Width:=150;
 cxGridTableView.Columns[4].Width:=150;
 // инициализация грида застрахованных лиц
 cxGridTableView1.Columns[0].Width:=16;
 cxGridTableView1.Columns[1].Width:=150;
 cxGridTableView1.Columns[2].Width:=150;
 cxGridTableView1.Columns[3].Width:=150;
end;

procedure TFMain.cxTreeCityClick(Sender: TObject);
var
  K: Integer;
  tn:TTreeNode;
  show_block:string;
begin
  show_block:='';
  tn:=cxTreeCity.Selected;
  if tn=nil then exit;
  // очистка гридов
  ClearGrid(cxGridTableView);
  ClearGrid(cxGridTableView1);

  if cxCheckBox1.Checked then show_block:='AND ENABLED=1';

  cxGridTableView.DataController.BeginUpdate;

  OracleQuery.Clear;
  OracleQuery.SQL.Add('select CODESTREET,NAMESTREET,ABBR,ENABLED from SSTREET WHERE CODECITY=' + tstr(tn.Data).id + ' AND UPPER(NAMESTREET) like''%' + AnsiUpperCase(cxTextEdit.Text) + '%''' + show_block);
  K:=0;
  try
   OracleQuery.Execute;
   while not OracleQuery.EOF do
    begin
     cxGridTableView.DataController.AppendRecord;
     cxGridTableView.DataController.Values [K , cxGridTableViewColumn1.Index] := OracleQuery.FieldAsString('CODESTREET');
     cxGridTableView.DataController.Values [K , cxGridTableViewColumn2.Index] := OracleQuery.FieldAsString('NAMESTREET');
     cxGridTableView.DataController.Values [K , cxGridTableViewColumn3.Index] := OracleQuery.FieldAsString('ABBR');
     cxGridTableView.DataController.Values [K , cxGridTableViewColumn4.Index] := OracleQuery.FieldAsString('ENABLED');
     inc(K);
     OracleQuery.Next;
    end;
  finally
   cxGridTableView.DataController.EndUpdate;
  end;
end;

procedure TFMain.N1Click(Sender: TObject);
var
 tn:TTreeNode;
begin
 if cxGridTableView.DataController.RecordCount<2 then
  begin
   MessageBox(handle,PChar('Недостаточно данных для объединения!'+#13#10), PChar('Error'), 16);
   exit;
  end;
 if cxGridTableView.Controller.SelectedRows[0].Values[4]='0' then
  begin
   MessageBox(handle,PChar('Улица заблокирована!'+#13#10), PChar('Error'), 16);
   exit;
  end;

 if MessageDlg('Сделать улицу ' + cxGridTableView.Controller.SelectedRows[0].Values[2] + ' (' + cxGridTableView.Controller.SelectedRows[0].Values[1] + ') ' + ' главной?',mtConfirmation,mbOkCancel,0)=mrCancel then exit;
 tn:=cxTreeCity.Selected;
 if tn=nil then exit;
 OracleQuery.Clear;
 OracleQuery.SQL.Add('begin');
 OracleQuery.SQL.Add(' UNIONSTREET(' + tstr(tn.Data).id + ',' + cxGridTableView.Controller.SelectedRows[0].Values[1] + ',''' + AnsiUpperCase(cxTextEdit.Text) + ''');');
 OracleQuery.SQL.Add(' commit;');
 OracleQuery.SQL.Add('end;');
 try
  OracleQuery.Execute;
  cxTreeCityClick(self);
 except
  on E: EOracleError do
   begin
    ShowMessage(E.Message);
    dxStatusBar.Panels[1].Text:=E.Message;
   end;
 end;
end;

procedure TFMain.cxGridTableViewCustomDrawColumnHeader(
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

procedure TFMain.cxGridTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
 R : TRect;
 img_index:integer;
 clmn_name:string;
begin
 if (Sender as TcxCustomGridTableView).Name='cxGridTableView' then
  begin
   img_index:=1;
   clmn_name:='cxGridTableViewColumn5';
  end;
 if (Sender as TcxCustomGridTableView).Name='cxGridTableView1' then
  begin
   img_index:=2;
   clmn_name:='cxGridTableView1Column1';
  end;
 If AViewInfo.Item.Name = clmn_name then
  Begin
   //If (AViewInfo.GridRecord.Values[4] = 0) then если нужно проверить значение конкретного столбца
	 R := AViewInfo.Bounds;
	 ACanvas.Brush.Color := AViewInfo.Params.Color;
	 ACanvas.FillRect(R);
	 // рисуем иконку
	 R := AViewInfo.Bounds;
	 ACanvas.DrawImage(cxImageList1,r.Left+2,r.Top,img_index,True);
	 ADone := True ;
 end;
end;

procedure TFMain.cxGridTableViewCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var
 K: Integer;
begin
 // очищаем грид
 ClearGrid(cxGridTableView1);

 cxGridTableView1.DataController.BeginUpdate;

 OracleQuery.Clear;
 OracleQuery.SQL.Add('select CODEPEOPLE,CODESTREETR,CODESTREETF from PEOPLESTREET');
 OracleQuery.SQL.Add('WHERE (CODESTREETR=' + cxGridTableView.Controller.SelectedRows[0].Values[1] + ' OR ' + 'CODESTREETF=' + cxGridTableView.Controller.SelectedRows[0].Values[1] + ')');
 K:=0;
 try
  OracleQuery.Execute;
  while not OracleQuery.EOF do
   begin
    cxGridTableView1.DataController.AppendRecord;
    cxGridTableView1.DataController.Values [K , cxGridTableView1Column2.Index] := OracleQuery.FieldAsString('CODEPEOPLE');
    cxGridTableView1.DataController.Values [K , cxGridTableView1Column3.Index] := OracleQuery.FieldAsString('CODESTREETR');
    cxGridTableView1.DataController.Values [K , cxGridTableView1Column4.Index] := OracleQuery.FieldAsString('CODESTREETF');
    inc(K);
    OracleQuery.Next;
   end;
 finally
  cxGridTableView1.DataController.EndUpdate;
 end;
end;

procedure TFMain.MenuItem1Click(Sender: TObject);
begin
 FViewHistory:=TFViewHistory.create(self);
 with FViewHistory do ShowModal;
end;

procedure TFMain.btnFilterClick(Sender: TObject);
begin
 cxTreeCityClick(self);
end;

procedure TFMain.btnFilterCancelClick(Sender: TObject);
begin
 cxTextEdit.Text:='';
 cxTreeCityClick(self);
end;

procedure TFMain.cxCheckBox1Click(Sender: TObject);
begin
 cxTreeCityClick(self);
end;

end.
