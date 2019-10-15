library FlyCef;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  messages,
  Vcl.Graphics,
  cef,
  ceflib,
  Forms,
  Vcl.Dialogs,
  FlyCefForm in 'FlyCefForm.pas' {frmFlyMain},
  ExportProc in 'ExportProc.pas',
  CefTypes in 'CefTypes.pas',
  ceffilescheme in 'filescheme\ceffilescheme.pas';

{$R *.res}


procedure DllProcedure(DllProc: Integer);
//var
//  FormChild: TfrmFlyMain;
//  i: Integer;
begin
//  if (DllProc = Winapi.Windows.DLL_PROCESS_DETACH) then
//  begin
//    try
//      for i := 0 to pg_FormChroms.Count - 1 do
//      begin
//        FormChild := pg_FormChroms.Items[i];
//        if (FormChild <> nil) then
//        begin
//          FormChild.Free;
//          pg_FormChroms.Clear;
//          pg_FormChroms.Free;
//        end;
//      end;
//    except
//      on e: Exception do
//        MessageBox(0, PChar(e.Message), 'Error', MB_OK or MB_ICONERROR);
//    end;
//  end;
end;

begin
  pg_FormChroms := TList.Create;
  DllProc := DllProcedure;

end.


