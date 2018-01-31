program SeaBattle;

uses
  Vcl.Forms,
  MainPage in 'MainPage.pas' {Form1},
  Game in 'Game.pas' {Form1},
  AboutUs in 'AboutUs.pas' {FieldForm},
  ErrorPage in 'ErrorPage.pas' {Form2},
  NewVersion in 'NewVersion.pas' {Form2},
  blcksock in 'lib\blcksock.pas',
  synafpc in 'lib\synafpc.pas',
  synsock in 'lib\synsock.pas',
  synautil in 'lib\synautil.pas',
  synacode in 'lib\synacode.pas',
  synaip in 'lib\synaip.pas',
  httpsend in 'lib\httpsend.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TFormAboutDevelopers, FormAboutDevelopers);
  // Application.CreateForm(TFieldForm, FieldForm);
  Application.Run;
end.
