unit CefTypes;

interface
   uses
  System.SysUtils,
  System.Classes;

//  //�ڲ� ִ��JS���ر�������Ͻṹ
//  type
//  TJsEvent = packed record
//    hWnd: THandle;
//    Event: THandle;
//    Result: string;
//  end;

  //�ӿ� ����������������
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

  //�ڲ� ����/����SendMessage�����ݽṹ
  type
  TJsMessage = packed record
    hWnd: THandle;
    Msg: Integer;
    Param: Integer;
    StrParam: string;
    StrData: string;
  end;

  //�ӿ� ������Ϣ�ĺ����ṹ
  type
  TRecvMessage = Function(hWnd: THandle; Msg: Integer; IntParam: Integer; StrParam: PAnsiChar; StrData: PAnsiChar): PAnsiChar; stdcall;


  //�ӿ� ��������
  type
  TCreateChromium = Function(p_Title: string; p_Parent: THandle; p_Content: string; p_WinInfo: PTCreateInfo; p_MessageRecv: TRecvMessage ): THandle; stdcall;
  type
  TShowChromium = function(p_HWnd: THandle; p_IsModal: Boolean): Cardinal; stdcall;
  type
  TExecuteJS = procedure (p_HWnd: THandle; p_Code: string);

implementation


end.
