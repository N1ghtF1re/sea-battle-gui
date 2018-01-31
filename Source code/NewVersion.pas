unit NewVersion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,Wininet,HTTPsend,Winapi.ShellAPI;

type
  TFormVers = class(TForm)
    pnl1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnDL: TButton;
    lbCurrVersion: TLabel;
    lbNewVersion: TLabel;
    mmoChangelog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnDLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormVers: TFormVers;
  Changelog:string;

implementation

{$R *.dfm}
uses MainPage;

procedure TFormVers.btnDLClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'http://brakhmen.info/download.php?file=sea-battle', nil, nil,SW_SHOWNOACTIVATE);
end;

procedure TFormVers.FormCreate(Sender: TObject);
var
  HTTP: THTTPsend;
  HTML: TStringlist;
begin
  HTML:= TStringlist.Create;
  HTTP:= THTTPSend.Create;
  HTTP.HTTPMethod('GET', 'http://brakhmen.info/SB_changelog.txt'); // файл на сервере с номером версии
  HTML.LoadFromStream(HTTP.Document);
  Changelog:=HTML.Text;
  lbCurrVersion.Caption := Form3.version;
  lbNewVersion.Caption := Form3.HTMLtext;
  mmoChangelog.Lines.Add('Изменения: ');
  mmoChangelog.Lines.Add(Changelog);
end;

end.
