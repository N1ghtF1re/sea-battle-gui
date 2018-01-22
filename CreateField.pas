unit CreateField;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons, Vcl.Menus;

type
  TPF = array[1..10, 1..10] of Char;
  TForm1 = class(TForm)
    player1matrix1: TStringGrid;
    lb1: TLabel;
    pnl1: TPanel;
    lbText4: TLabel;
    lbNum4: TLabel;
    lbText3: TLabel;
    lbText2: TLabel;
    lbText1: TLabel;
    lbNum3: TLabel;
    lbNum2: TLabel;
    lbNum1: TLabel;
    btNext: TBitBtn;
    pnIsFin: TPanel;
    img1: TImage;
    lbFrom1: TLabel;
    lbFrom2: TLabel;
    lbFrom3: TLabel;
    lbFrom4: TLabel;
    lbInfo: TLabel;
    pnl2: TPanel;
    pnl3: TPanel;
    mm1: TMainMenu;
    J1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure player1matrix1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure player1matrix1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btNextClick(Sender: TObject);
  private
    { Private declarations }
  public
    var
      P1F: TPF;
      P2F: TPF;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses ErrorPage, MainPage,game;

procedure TForm1.btNextClick(Sender: TObject);
var i,j:Byte;
// Test1:string;
  procedure Seabattle_fieldAI_generator(var P2F:TPF);
  const ships = 20;
   var ib,jb,ie,je,i,j,k,ship_size,ship_amount,direction,counter,n:Integer ;
 var exiter,exc:Boolean;
 function Quick_math(x,y:integer):boolean;
 var count:integer;

 begin

   
   if
     (P2F[x-1,y]='K') or (P2F[x,y-1]='K') or (P2F[x-1,y-1]='K')
      or (P2F[x+1,y]='K') or (P2F[x,y+1]='K') or (P2F[x+1,y+1]='K')
      or (P2F[x+1,y-1]='K')or (P2F[x-1,y+1]='K')  then
   Quick_math:=true
   else quick_math:=false;
 end;
 begin
  counter:=0;
   while counter<>20 do
   begin
 n:=10;
 for I := 1 to n do
   for j := 1 to n do
     P2F[i,j]:=' ';

 Randomize;
 exiter:=False;
 Ship_size:=4;
 ship_amount:=1;
  for k := 1 to 4 do
  begin

    for j := 1 to ship_amount do
    begin
    repeat
      exiter:=False;
      repeat
        ib:=Random(n)+1;
        jb:=Random(n)+1;
      until not(quick_math(ib,jb)) or ( (jb+ship_size-1>10) or (ib+ship_size-1>10)) ;
      direction:=random(2)+1;             //1-Right 2-Bottom 3-Left 4-up
      if ship_size>1 then
      begin
      case direction of
      1:
      if  (ib+ship_size-1<=10) then
        begin

        exc:=True;
        for I := 1 to ship_size-1 do
        if Quick_math(ib+i,jb) then
        exc:=False;
         if exc  then
         for I := 1 to ship_size-1 do
         begin
         P2F[ib,jb]:='K';
         P2F[ib+i,jb]:='K';
         exiter:=true;
         end;


        end;
      2:
      if   (jb+ship_size-1<=10)then
        begin
         exc:=True;
        for I := 1 to ship_size-1 do
        if Quick_math(ib,jb+i) then
        exc:=False;
         if exc  then

         for I := 1 to ship_size-1 do
         begin
          P2F[ib,jb]:='K';
          P2F[ib,jb+i]:='K';
          exiter:=true;

         end
        end;                                                                      //1-Right 2-Bottom 3-Left 4-up
        end;
        end
      else begin
      P2F[ib,jb]:='K';
      exiter:=true;
      end;
    until(exiter) ;
    end;
    inc(ship_amount);
    dec(ship_size);
    counter:=0;
     for I := 1 to n do
  begin
    for j := 1 to n do
      if P2F[i,j] = 'K' then   Inc(counter);      
  end;   
  end;
  end;
end;


begin
  for i:=1 to 10 do
  begin
    for j:=1 to 10 do
    begin
      if (player1matrix1.Cells[i,j] = ' ') then
        Form1.P1F[i,j] := 'K'
      else
        Form1.P1F[i,j] := 'M';
      //test1 := Test1 + ' ' + P1F[i,j];
    end;
    //test1:= test1 + #10#13;
  end;
  player1matrix1.Free();
  Seabattle_fieldAI_generator(P2F);
  Form1.hide;
  FieldForm.show;
  //ShowMessage(test1);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Close;    // ЭТО ПОТОМ НУЖНО БУДЕТ УБРАТЬ, КОГДА ПОЙДЕМ В РЕЛИЗ
  //  ОНО ЧТОБЫ НЕ ВЫЛАЗИЛА ГРЕБАННАЯ ОШИБКА OUTPUT ERROR
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:Byte;
begin
  for i:=1 to 10 do
  begin
    player1matrix1.Cells[i,0]:=IntToStr(i);
    player1matrix1.Cells[0,i]:=Chr(1039+i);
    player1matrix1.Cells[0,10]:='К';
  end;
end;

procedure TForm1.player1matrix1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var X: Real;
begin
  with player1matrix1 do
  begin
    if (Cells[ACol,ARow] = ' ')   then
    begin
      Canvas.Brush.Color:=clRed;
      Rect.Left:=Rect.Left-6;
      Canvas.FillRect(Rect);
    end;
    if (Cells[ACol,ARow] = '') then
    begin
      Canvas.Brush.Color:=clWhite;
      Rect.Left:=Rect.Left-5;
      Canvas.FillRect(Rect);
    end;
    if ((ACol = 0) and (ARow = 0)) then
    begin
      Canvas.Brush.Color:=clWhite;
      Rect.Left:=Rect.Left-6;
      Canvas.FillRect(Rect);
    end;
  end;
end;

procedure TForm1.player1matrix1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: Integer;
  num1,num2,num3,num4: Byte;
procedure showError;
begin
  Form2.ShowModal;
  player1matrix1.Cells[ACol,ARow] := '';
end;

procedure checkInCol(var num1,num2,num3,num4:byte);
var
  i,j,k:byte;
  count:byte;
begin
  // ************* Подсчет кораблей в столбец ****************
  for i:=1 to 10 do
  begin
    j:=1;
    while(j<=10) do                  // i - столбец, j - строка
    begin                            // [Col, Row]  ([Столбец, Строка])
      if( (player1matrix1.Cells[i,j] = ' ')
      and
      ( (player1matrix1.Cells[i+1,j] <> ' ') and (player1matrix1.Cells[i-1,j] <> ' ')))
      then
      begin
        count:=0;
        k:=j;
        while(player1matrix1.Cells[i,k] = ' ') do
        begin
          inc(count);
          inc(k);
          //lbText4.Caption := IntToStr(i) + ' ' + IntToStr(j);
          //player1matrix1.Cells[i,j+1] := 'suka';
        end;
        j:=k+1;
        case count of
          1: ;//inc(num1);
          2: inc(num2);
          3: inc(num3);
          4: inc(num4);
        else showError;
        end;
        end;
      inc(j);
    end;
  end;
  lbNum1.Caption := IntToStr(num1);
  lbNum2.Caption := IntToStr(num2);
  lbNum3.Caption := IntToStr(num3);
  lbNum4.Caption := IntToStr(num4);
  player1matrix1.Col:=ACol;
  player1matrix1.Row:=ARow;
end;

procedure checkInRow(var num1,num2,num3,num4:byte);
var
  i,j,k:byte;
  count:byte;
begin
  // ************* Подсчет кораблей в строчу ****************
  for i:=1 to 10 do
  begin
    j:=1;
    while(j<=10) do
    begin
      if( (player1matrix1.Cells[j,i] = ' ')
      and
      ( (player1matrix1.Cells[j,i+1] <> ' ') and (player1matrix1.Cells[j,i-1] <> ' ')))
      then
      begin
        count:=1;
        k:=j+1;
        while(player1matrix1.Cells[k,i] = ' ') do
        begin
          inc(count);
          inc(k);
        end;
        j:=k+1;
        case count of
          1: inc(num1);
          2: inc(num2);
          3: inc(num3);
          4: inc(num4);
        else showError;
        end;
        end;
      inc(j);
    end;
  end;
  lbNum1.Caption := IntToStr(num1);
  lbNum2.Caption := IntToStr(num2);
  lbNum3.Caption := IntToStr(num3);
  lbNum4.Caption := IntToStr(num4);
  player1matrix1.Col:=ACol;
  player1matrix1.Row:=ARow;
end;

begin
  if(x < 440) then
  begin
    player1matrix1.MouseToCell(X, Y, ACol, ARow);
    if( (ACol <> 0) and (ARow <> 0)) then
    begin
      if (player1matrix1.Cells[ACol,ARow] = '') then
      begin
        player1matrix1.Cells[ACol,ARow] := ' ';
      end
      else
      begin
        player1matrix1.Cells[ACol,ARow] := '';
      end;
      // Далее идет проверка на корректность расстановки (Низя по диагонали и
      // Треугольниками
      if((player1matrix1.Cells[ACol+1,ARow+1] = ' ')
          or
          (player1matrix1.Cells[ACol+1,ARow-1] = ' ')
          or
          (player1matrix1.Cells[ACol-1,ARow+1] = ' ')
          or
          (player1matrix1.Cells[ACol-1,ARow-1] = ' ')
          or
          ((player1matrix1.Cells[ACol,ARow+1] = ' ') and (player1matrix1.Cells[ACol+1,ARow] = ' '))
          or
          ((player1matrix1.Cells[ACol,ARow-1] = ' ') and (player1matrix1.Cells[ACol-1,ARow] = ' '))
          or
          ((player1matrix1.Cells[ACol,ARow+1] = ' ') and (player1matrix1.Cells[ACol-1,ARow] = ' '))
          or
          ((player1matrix1.Cells[ACol,ARow-1] = ' ') and (player1matrix1.Cells[ACol+1,ARow] = ' ')))
      then
      begin
        showError;
      end;
      num1:=0;
      num2:=0;
      num3:=0;
      num4:=0;
      checkInRow(num1,num2,num3,num4);
      checkInCol(num1,num2,num3,num4);
      if ((num1 = 4) and (num2 = 3) and (num3 = 2) and (num4 = 1)) then
        pnIsFin.Visible := true
      else
        pnIsFin.Visible := false;
      pnIsFin.Visible := true
    end;
  end;
end;

end.
