unit FlashForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TfrmFlash = class(TForm)
    Timer1: TTimer;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    constructor Create(AOwner: TComponent); reintroduce; overload;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private declarations }
  public
    { Public declarations }
    m_BgBmp: TBitmap;
    m_BgPic: TPicture;
    m_IsClose: Boolean;
  end;

var
  frmFlash: TfrmFlash;

implementation

{$R *.dfm}

constructor TfrmFlash.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
procedure TfrmFlash.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;



procedure TfrmFlash.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:= m_IsClose;
  if(not m_IsClose) then
  begin
    Timer1.Interval:= 1000;
    Timer1.Enabled:= True;
  end;
end;

procedure TfrmFlash.FormCreate(Sender: TObject);
begin
  m_BgPic:= TPicture.Create();
  m_BgPic.LoadFromFile(pchar(ExtractFilePath(ParamStr(0)) + '/View/bg.bmp'));

  m_BgBmp:= TBitmap.Create();
  m_BgBmp.Width:= Self.Width;
  m_BgBmp.Height:= Self.Height;

  m_BgBmp.Canvas.StretchDraw(Rect(0, 0, m_BgBmp.Width, m_BgBmp.Height), m_BgPic.Graphic);

  m_IsClose:= False;

  Image1.Picture.Bitmap.Assign(m_BgBmp);

  SetWindowLong(self.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);

end;

procedure TfrmFlash.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:= False;
  m_IsClose:= True;
  Self.Close;
end;

end.
