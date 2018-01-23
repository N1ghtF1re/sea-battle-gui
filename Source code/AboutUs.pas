unit AboutUs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.Imaging.pngimage, Winapi.ShellAPI, Vcl.Imaging.jpeg;

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
    site1: TImage;
    procedure DevelopersGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure gh1Click(Sender: TObject);
    procedure gh3Click(Sender: TObject);
    procedure gh2Click(Sender: TObject);
    procedure site1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

procedure TFormAboutDevelopers.FormCreate(Sender: TObject);
begin
  Label1.Caption:='Технический директор – Панкратьев Александр' + #10#13 + 'Тим лидер – Панкратьев Александр' + #10#13 + 'Дизайнер – Панкратьев Александр' + #10#13 + 'Вдохновитель – Панкратьев Александр' + #10#13 + 'ИИ разработчик – Голубев Кирилл' + #10#13 + 'Бюджетник – Голубев Кирилл' + #10#13 + 'Главный по юмору – Голубев Кирилл' + #10#13 + 'PR Менеджер – Пилинко Никита' + #10#13 + 'Эксперт по криптовалюте - Пилинко Никита' + #10#13 + 'Получатель Зарплаты – Пилинко Никита' + #10#13 + #10#13 + 'Так же благодарность за помощь в разработке выражаем:' + #10#13 + 'Оношко Дмитрию, Антону Парамонову, сервису Github' +#10#13 + 'и всем участникам бета-тестирования';
end;

procedure TFormAboutDevelopers.gh1Click(Sender: TObject);
begin
   ShellExecute(Application.Handle, nil, 'https://github.com/N1ghtF1re', nil, nil,SW_SHOWNOACTIVATE);
end;

procedure TFormAboutDevelopers.gh2Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'https://github.com/Smertowing', nil, nil,SW_SHOWNOACTIVATE);
end;

procedure TFormAboutDevelopers.gh3Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'https://github.com/mineralsfree', nil, nil,SW_SHOWNOACTIVATE);
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

procedure TFormAboutDevelopers.site1Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'http://pankratiew.info/', nil, nil,SW_SHOWNOACTIVATE);
end;

end.
