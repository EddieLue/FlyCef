unit CefTypes;

interface
   uses
  System.SysUtils,
  System.Classes;

//  //内部 执行JS返回保存的资料结构
//  type
//  TJsEvent = packed record
//    hWnd: THandle;
//    Event: THandle;
//    Result: string;
//  end;

  //接口 创建窗口所需类型
  type
  TCreateInfo = packed record
      Width: Cardinal;
      Height: Cardinal;
      MinWidth: Cardinal;
      MinHeight: Cardinal;
      MaxWidth: Cardinal;
      MaxHeight: Cardinal;
      BorderStyle: Cardinal;
      HIcon: THandle;
  end;
  PTCreateInfo = ^TCreateInfo;

  //内部 接收/传回SendMessage的数据结构
  type
  TJsMessage = packed record
    hWnd: THandle;
    Msg: Integer;
    Param: Integer;
    StrParam: string;
    StrData: string;
  end;

  //接口 接受消息的函数结构
  type
  TRecvMessage = Function(hWnd: THandle; Msg: Integer; IntParam: Integer; StrParam: PAnsiChar; StrData: PAnsiChar): PAnsiChar; stdcall;


  //接口 公开函数
  type
  TCreateChromium = Function(p_Title: string; p_Parent: THandle; p_Content: string; p_WinInfo: PTCreateInfo; p_MessageRecv: TRecvMessage ): THandle; stdcall;
  type
  TShowChromium = function(p_HWnd: THandle; p_IsModal: Boolean): Cardinal; stdcall;
  type
  TExecuteJS = procedure (p_HWnd: THandle; p_Code: string);

implementation


end.
