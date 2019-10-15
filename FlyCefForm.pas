unit FlyCefForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cef, ceflib,CefTypes, FlashForm,
  Vcl.ExtCtrls;





  const
  WM_CHROMUIM_MSG = Winapi.Messages.WM_USER Or 1;


type
  TfrmFlyMain = class(TForm)
    Chromium1: TChromium;
    constructor Create(AOwner: TComponent; p_Context:string; p_MessageRecv: TRecvMessage); reintroduce; overload;
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;

    procedure OnBrowserMsg(var o_Msg: TMessage); message WM_CHROMUIM_MSG;
    procedure Chromium1LoadEnd(Sender: TCustomChromium;
      const browser: ICefBrowser; const frame: ICefFrame;
      isMainContent: Boolean; httpStatusCode: Integer; out Result: TCefRetval);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    m_Content: string;//url或者内容
    m_RecvMessage: TRecvMessage;  //接受JS消息的事件函数


    procedure  ExeJS(p_Code: string);

  end;

 var
  pg_FormChroms: TList;
  //pg_ExecuteJSReturnEvents: TList; //记录调用JS返回值的List
//  pg_JSRetEvent: TJsEvent;

  type TCefHandlerOwn = class(TCefv8HandlerOwn)
    protected
      function Execute(const name: ustring; const obj: ICefv8Value;
        const arguments: TCefv8ValueArray; var retval: ICefv8Value;
        var exception: ustring): Boolean; override;
    end;

implementation
  uses ceffilescheme;

{$R *.dfm}

procedure TfrmFlyMain.CreateParams(var Params: TCreateParams);
begin
  inherited;

//  // for XP and later only...
//  if (Win32MajorVersion>5) or ((Win32MajorVersion = 5) and (Win32MinorVersion>= 1)) then
//    Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;




//窗体构造事件
constructor TfrmFlyMain.Create(AOwner: TComponent; p_Context:string; p_MessageRecv: TRecvMessage);
begin
  m_Content:= p_Context;
  m_RecvMessage:= p_MessageRecv;
  inherited Create(AOwner);
end;

procedure TfrmFlyMain.FormActivate(Sender: TObject);
begin
//  frmFlash.ShowModal;


end;

//窗体建立事件
procedure TfrmFlyMain.FormCreate(Sender: TObject);
var
  code: string;
begin
  code:=
   'var cef;'+
   'if (!cef)'+
   '  cef = {};'+
   'if (!cef.cefmsg)'+
   '  cef.cefmsg = {  };'+
   'cef.cefmsg.hWnd='+ string.Parse(Self.Handle) +';' +
   '(function() {'+
   '  cef.cefmsg.msg_object = function() {'+
   '    native function GetMsgObject();'+
   '    return GetMsgObject();'+
   '  };'+
   '})();';
  if(CefRegisterExtension('v8/cefmsg', code, (TCefHandlerOwn.Create() as ICefV8Handler))) then
  begin
    //载入页面
    if(m_Content.Substring(0, 4).ToLower() = 'file') or (m_Content.Substring(0, 4).ToLower() = 'http') then
    begin
       Chromium1.Browser.MainFrame.LoadUrl(m_Content);
    end
    else begin
       Chromium1.Browser.MainFrame.LoadString(m_Content, 'about:blank');
    end;
  end;
end;



//页面载入完成事件
procedure TfrmFlyMain.Chromium1LoadEnd(Sender: TCustomChromium;
  const browser: ICefBrowser; const frame: ICefFrame; isMainContent: Boolean;
  httpStatusCode: Integer; out Result: TCefRetval);
begin
  m_RecvMessage(Self.Handle, 1, 0, PAnsiChar(AnsiString('LoadEnd')), PAnsiChar(AnsiString('0')));
end;

procedure TfrmFlyMain.ExeJS(p_Code: string);
begin
  Chromium1.Browser.MainFrame.ExecuteJavaScript(p_Code, 'about:blank', 0);
end;

//接受JS发送过来的资料 执行第三方回调
procedure TfrmFlyMain.OnBrowserMsg(var o_Msg: TMessage);
var
  o_JsMsg: TJsMessage;
  ansi_Result: PAnsiChar;
begin
  o_JsMsg:= TJsMessage(Pointer(o_Msg.WParam)^);
  ansi_Result:= m_RecvMessage
  (
  o_JsMsg.hWnd,
  o_JsMsg.Msg,
  o_JsMsg.Param,
  PAnsiChar(AnsiString(o_JsMsg.StrParam)),
  PAnsiChar(AnsiString(o_JsMsg.StrData))
  );
  o_Msg.Result:= LRESULT(ansi_Result);
  //showmessage(s_Result);
end;


//接收到JS调用
function TCefHandlerOwn.Execute(const name: ustring; const obj: ICefv8Value;
  const arguments: TCefv8ValueArray; var retval: ICefv8Value;
  var exception: ustring): Boolean;
var
  nReturn: Integer;
  o_JsMsg:TJsMessage;
begin
  Result := false;
  if (name = 'GetMsgObject') then
  begin
    //新建一个V8对象
    retval := TCefv8ValueRef.CreateObject(nil);
    // 添加一个方法给新建的V8对象
    retval.SetValueByKey('SendMessage', TCefv8ValueRef.CreateFunction('SendMessage', Self));
    Result := true;
  end
  else if(name = 'SendMessage') then
  begin
    if (Length(arguments) <> 5) or (not arguments[0].IsInt) then
    begin
      Result := False;
      Exit;
    end;

    o_JsMsg.hWnd:= THandle(arguments[0].GetIntValue());
    o_JsMsg.Msg:= arguments[1].GetIntValue();
    o_JsMsg.Param:= arguments[2].GetIntValue();
    o_JsMsg.StrParam:= arguments[3].GetStringValue();
    o_JsMsg.StrData:= arguments[4].GetStringValue();
    if(IsWindow(o_JsMsg.hWnd)) then
    begin
      nReturn:= SendMessage(o_JsMsg.hWnd, WM_CHROMUIM_MSG, Cardinal(@o_JsMsg), 0);
      retval:= TCefv8ValueRef.CreateString('');
      if(nReturn <> 0) then
      begin
        retval:= TCefv8ValueRef.CreateString(string(PAnsiChar(nReturn)));
      end;
      Result:= True;
    end;

  end;


end;


end.

