program SeaBattle;

uses
  Vcl.Forms,
  MainPage in 'MainPage.pas' {Form1},
  Game in 'Game.pas' {Form1},
  AboutUs in 'AboutUs.pas' {FieldForm},
  ErrorPage in 'ErrorPage.pas' {Form2};

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
