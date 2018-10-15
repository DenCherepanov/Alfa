unit UProc;

interface

uses cxGridTableView;

type
  ident = record
    id,id1,id2,id3,id4,id5,id6,id7,id8: string;
  end;

  tstr = ^ident;

  function ClearGrid(tbv: TcxGridTableView):boolean ;

implementation

uses umain;


function ClearGrid(tbv: TcxGridTableView):boolean;
begin
 tbv.DataController.RecordCount := 0;
 result:=true;
end;

end.
