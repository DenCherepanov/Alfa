program TestProject;

uses
  Forms,
  UMain in 'UMain.pas' {FMain},
  UProc in 'UProc.pas',
  UViewHistory in 'UViewHistory.pas' {FViewHistory};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�������� �������';
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
