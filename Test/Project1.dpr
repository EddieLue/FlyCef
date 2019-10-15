program Project1;

uses
  Vcl.Forms,
  Winapi.Windows,
  system.SysUtils,
  Vcl.Dialogs,
  CefTypes in '..\CefTypes.pas',
  Unit2 in 'Unit2.pas' {Form2};

{$R *.res}

var
  CreateChromium: TCreateChromium;
  ShowChromium: TShowChromium;
  hForm: THandle;
  createWinInfo: TCreateInfo;
  hModule: THandle;


procedure MsgRecv(hWnd: THandle; Msg: Integer; IntParam: Integer; StrParam: PAnsiChar; StrData: PAnsiChar);stdcall;
begin
  if(Msg = 0) then  //窗口创建
  begin
//    Form2.m_Close:= true;
    //Form2.ShowModal;

  end;
  if(Msg = 1) then  //载入完成
  begin
//    Form2.m_Close:= true;
//    Form2.ShowModal;
    ShowWindow(hForm, SW_SHOWNORMAL);
  end;

  if(Msg = 111) then
  begin
    //StrLCopy(pchar(@o_Msg.Result[0]), 'nima', 4);

  end;
end;


begin

  hModule:= LoadLibrary(PWideChar(ExtractFilePath(Application.ExeName) + 'FlyCef.dll'));
  CreateChromium:= GetProcAddress(hModule,'CreateChromium');
  ShowChromium:= GetProcAddress(hModule, 'ShowChromium');
  createWinInfo.Width:= 500;
  createWinInfo.Height:= 300;
  createWinInfo.MinWidth:= 300;
  createWinInfo.MinHeight:= 300;
  createWinInfo.BorderStyle:=cardinal(TFormBorderStyle.bsSizeable);
  Form2:= TForm2.Create(nil);
  hForm:= CreateChromium('一个窗口', 0, 'file:///View/home.html', @createWinInfo, @MsgRecv);



  ShowChromium(hForm, true);

end.
