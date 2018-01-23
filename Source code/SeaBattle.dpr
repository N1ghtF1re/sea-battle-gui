program SeaBattle;

uses
  Vcl.Forms,
  MainPage in 'MainPage.pas' {Form1},
  CreateField in 'CreateField.pas' {Form1},
  Game in 'Game.pas' {FieldForm},
  ErrorPage in 'ErrorPage.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm2, Form2);
 // Application.CreateForm(TFieldForm, FieldForm);
  Application.Run;
end.
