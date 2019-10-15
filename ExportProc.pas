unit ExportProc;

interface

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
  CefTypes,
  FlyCefForm;



 implementation



//句柄转窗体
function HToF(p_hWnd: THandle): TfrmFlyMain;  stdcall;
var
  i: Integer;
  frmForm: TfrmFlyMain;
begin
  for i := 0 to pg_FormChroms.Count - 1 do
  begin
    frmForm:= pg_FormChroms[i];
    if(frmForm.Handle = p_hWnd) then
    begin
     Result:= frmForm;
     Exit;
    end;
  end;
  Result:= nil;
end;

//创建Chromuim窗口
function CreateChromium(p_Title: string; p_Parent: THandle; p_Content: string; p_pWinInfo: PTCreateInfo; p_MessageRecv: TRecvMessage ): THandle; stdcall;
var
   frmForm: TfrmFlyMain;
   p_WinInfo: TCreateInfo;
begin

  frmForm:= TfrmFlyMain.Create(nil, p_Content, p_MessageRecv);
  //添加到List中
  pg_FormChroms.Add(frmForm);

  //配置参数
  p_WinInfo:= TCreateInfo(p_pWinInfo^);
  frmForm.Caption:= p_Title;
  frmForm.Width:= p_WinInfo.Width;
  frmForm.Height:= p_WinInfo.Height;

  frmForm.BorderStyle:= TFormBorderStyle(p_WinInfo.BorderStyle);

  if(p_WinInfo.MinWidth > 0) then
  begin
    frmForm.Constraints.MinWidth:= p_WinInfo.MinWidth;
  end;

  if(p_WinInfo.MinHeight > 0) then
  begin
    frmForm.Constraints.MinHeight:= p_WinInfo.MinHeight;
  end;

  if(p_WinInfo.MaxWidth > 0) then
  begin
    frmForm.Constraints.MaxWidth:= p_WinInfo.MaxWidth;
  end;

  if(p_WinInfo.MaxHeight > 0) then
  begin
    frmForm.Constraints.MaxHeight:= p_WinInfo.MaxHeight;
  end;

  if(p_WinInfo.HIcon > 0) then
  begin
    frmForm.Icon.Handle:= p_WinInfo.HIcon;
  end;

  if(IsWindow(p_Parent)) then
  begin
     SetWindowLong(frmForm.Handle, GWL_HWNDPARENT, p_Parent);
  end;
                         
  Result:= frmForm.Handle;
  
end;



//显示窗口
function ShowChromium(p_HWnd: THandle; p_IsModal: Boolean): Cardinal; stdcall;
var
  frmForm: TfrmFlyMain;
begin
  Result:= 0;
  try
    frmForm:= HToF(p_HWnd);
    if(p_IsModal) then
    begin
      Result:= frmForm.ShowModal;
      //ShowWindowAsync(frmForm.Handle, SW_SHOWDEFAULT);
      //ShowWindow(frmForm.Handle, SW_SHOWMINIMIZED)
    end else
    begin
      frmForm.Show;
    end;
  except
    on e: Exception do
    showmessage(e.Message);
  end;
end;

//执行JS
procedure ExecuteWebJS(p_HWnd: THandle; p_Code: string);  stdcall;
var
  frmForm: TfrmFlyMain;
begin
  try
    frmForm:= HToF(p_HWnd);
    if(frmForm <> nil) then
    begin
      frmForm.ExeJS(p_Code);
    end;
  except on E: Exception do
    MessageBox(0, PChar(E.Message), 'Error', MB_OK or MB_ICONERROR);  
  end;

end;

//关闭窗口
procedure CloseChromium(p_HWnd: THandle);  stdcall;
var
  i: Integer;
  frmForm: TfrmFlyMain;
begin
  try
    for i := 0 to pg_FormChroms.Count - 1 do
    begin
      frmForm:= pg_FormChroms[i];
      if(frmForm.Handle = p_HWnd) then
      begin
        frmForm.Close();
        pg_FormChroms.Delete(i);
        break;
      end;
    end;

  except on E: Exception do
    MessageBox(0, PChar(E.Message), 'Error', MB_OK or MB_ICONERROR);
  end;

end;

exports
CreateChromium,
ShowChromium,
ExecuteWebJS,
CloseChromium;


end.

