unit NewVersion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,Wininet,Winapi.ShellAPI;

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
    procedure FormCreate(Sender: TObject);
    procedure btnDLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormVers: TFormVers;

implementation

{$R *.dfm}
uses MainPage;

function GetInetFile(const fileURL, FileName: String): boolean;
const BufferSize = 1024;
var hSession, hURL: HInternet;
Buffer: array[1..BufferSize] of Byte;
BufferLen: DWORD;
f: File;
sAppName: string;
begin
   Result:=False;
   sAppName := ExtractFileName(Application.ExeName);
   hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG,
         nil, nil, 0);
   try
      hURL := InternetOpenURL(hSession,
      PChar(fileURL),nil,0,0,0);
      try
         AssignFile(f, FileName);
         Rewrite(f,1);
         repeat
            InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
            BlockWrite(f, Buffer, BufferLen)
         until BufferLen = 0;
         CloseFile(f);
         Result:=True;
      finally
      InternetCloseHandle(hURL)
      end
   finally
   InternetCloseHandle(hSession)
   end
end;


procedure TFormVers.btnDLClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'http://brakhmen.info/download.php?file=sea-battle', nil, nil,SW_SHOWNOACTIVATE);
end;

procedure TFormVers.FormCreate(Sender: TObject);
begin
  lbCurrVersion.Caption := Form3.version;
  lbNewVersion.Caption := Form3.HTMLtext;
end;

end.
