unit MainPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Wininet, HTTPsend;

type
  TForm3 = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    lbHello: TLabel;
    pnl4: TPanel;
    btn1: TButton;
    pnl3: TPanel;
    lbYourName: TLabel;
    edt1: TEdit;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure btn1Click(Sender: TObject);
    procedure edt1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    var
      UserName: string;
      version: String;   // версия программы
      HTMLtext:String;   // полученный ответ от сервера
  end;

var
  Form3: TForm3;


implementation

{$R *.dfm}

uses Game, NewVersion;


procedure TForm3.btn1Click(Sender: TObject);
begin
  Form3.UserName := edt1.Text;
  //ShowMessage(Form3.UserName);
  if(Trim(Form3.UserName) = '' ) then
    ShowMessage('Введите имя')
  else
  begin
    Form3.Close;
  end;
end;

procedure TForm3.edt1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Mgs: TMsg;
begin
  if (Key = 13) then
  begin
      PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
      btn1Click(btn1);
  end;
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
edt1.SetFocus;
end;

procedure TForm3.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  edt1.Left := Trunc(pnl3.Width*0.1);
  edt1.Width := Trunc(pnl3.Width*0.8);
  edt1.Height := 40;
  edt1.Top := Trunc( (pnl3.Height + edt1.Height) / 2 );
  btn1.Left := Trunc(pnl4.Width*0.3);
  btn1.Width := Trunc(pnl4.Width*0.4);
end;

procedure TForm3.FormCreate(Sender: TObject);
var
HTTP: THTTPsend;
HTML: TStringlist;
begin
  version:='1.10';                   //  Текущая версия
  HTML:= TStringlist.Create;
  HTTP:= THTTPSend.Create;
  HTTP.HTTPMethod('GET', 'https://brakhmen.info/SB_vers.txt'); // файл на сервере с номером версии
  HTML.LoadFromStream(HTTP.Document);
  HTMLtext:=HTML.Text;
  if ( (Pos(version,HTMLtext)<>0) or (HTMLtext = ''))  then
  begin
    // Обнов нет
  end
  else
  begin
    Application.CreateForm(TFormVers, FormVers); // Инициализиуем форму с сообщением об обнове
    FormVers.ShowModal; // Выводим месседж о новой обнове
  end;
end;

end.
