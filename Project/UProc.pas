unit UProc;

interface              

uses cxGridTableView;

type
  ident = record
    id,id1,id2,id3,id4,id5,id6,id7,id8: string;
  end;

  tstr = ^ident;

  function ClearGrid(tbv: TcxGridTableView):boolean ;
  procedure InitGrid(tbv: TcxGridTableView; clm_cnt:integer);

implementation

uses umain;

// функция очищающая грид
function ClearGrid(tbv: TcxGridTableView):boolean;
begin
 tbv.DataController.RecordCount := 0;
 result:=true;
end;

// процедура инициализации ширина столбцов грида
procedure InitGrid(tbv: TcxGridTableView; clm_cnt:integer);
var
 i:integer;
begin
 tbv.Columns[0].Width:=16;
 for i:=1 to clm_cnt do tbv.Columns[i].Width:=150;
end;

end.
