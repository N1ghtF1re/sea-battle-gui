unit AboutUs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.Imaging.pngimage, Winapi.ShellAPI;

type
  TFormAboutDevelopers = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    Label1: TLabel;
    img1: TImage;
    img2: TImage;
    img3: TImage;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl5: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    vk1: TImage;
    vk2: TImage;
    vk3: TImage;
    gh1: TImage;
    gh2: TImage;
    gh3: TImage;
    procedure DevelopersGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAboutDevelopers: TFormAboutDevelopers;

implementation

{$R *.dfm}

procedure TFormAboutDevelopers.DevelopersGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var R: TRect;x,y:integer;
begin

end;

procedure TFormAboutDevelopers.Label2Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'https://vk.com/sasha_pankratiew', nil, nil,SW_SHOWNOACTIVATE);
end;

procedure TFormAboutDevelopers.Label3Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'https://vk.com/smertowing', nil, nil,SW_SHOWNOACTIVATE);
end;

procedure TFormAboutDevelopers.Label4Click(Sender: TObject);
begin
ShellExecute(Application.Handle, nil, 'https://vk.com/mineralsfree', nil, nil,SW_SHOWNOACTIVATE);

end;

end.
