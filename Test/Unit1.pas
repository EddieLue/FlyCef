unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CEFTypes;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
//var
//  CreateForm: TCreateChromium;
//  hForm: THandle;
//  createWinInfo: TCreateInfo;
begin
//  CreateForm:= TCreateChromium(GetProcAddress(LoadLibrary('FlyCef.dll'),'CreateChromium'));
//  createWinInfo.Width:= 500;
//  createWinInfo.Height:= 300;
//  createWinInfo.MinWidth:= 300;
//  createWinInfo.Height:= 300;
//  createWinInfo.BorderStyle:= 2;
//  hForm:= CreateForm('Ò»¸ö´°¿Ú', 0, 'file:///View/home.html', @createWinInfo);

end;

end.
