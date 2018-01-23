unit CreateField;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons, Vcl.Menus;

type
  TPF = array[1..10, 1..10] of Char;
  TMode = (Fcreate, battaly, GameOver);
  TForm1 = class(TForm)
    player1matrix: TStringGrid;
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
    player2matrix: TStringGrid;
    pnl4: TPanel;
    pnl5: TPanel;
    img2: TImage;
    pnlName: TPanel;
    lbP1N: TLabel;
    lbP2N: TLabel;
    mm1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    btnAutoCreate: TButton;
    N11: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure player1matrixMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure player1matrixDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btNextClick(Sender: TObject);
    procedure player2matrixDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure player2matrixMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure newGame(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure btnAutoCreateClick(Sender: TObject);
    procedure N11Click(Sender: TObject);

  private
    { Private declarations }
  public
    var
      P1F: TPF;
      P2F: TPF;
  end;

var
  Form1: TForm1;
  mode:TMode;

implementation

{$R *.dfm}

uses ErrorPage, MainPage,game, AboutUs;

// resourcestring PlacingRules = 'Игровое поле — обычно квадрат 10×10 каждого игрока, на котором размещается флот кораблей. Горизонтали обычно нумеруются сверху вниз, а вертикали помечаются буквами слева направо. При этом используются буквы русского алфавита от «а» до «к» (буквы «ё» и «й» обычно пропускаются) либо от «а» до «и» (с использованием буквы «ё»), либо буквы латинского алфавита от «a» до «j». Иногда используется слово «республика» или «снегурочка», так как в этих 10-буквенных словах ни одна буква не повторяется. Поскольку существуют различные варианты задания системы координат, то об этом лучше заранее договориться.' + #1013 'Размещаются:';
procedure isHitted_wow(var player1matrix:TStringGrid; var i,j:byte);
var rand, g, l, iDamaged, jDamaged:integer;
    stem,limit:Boolean;
begin
stem:=False;
for l:=i-1 to i+1 do
  for g:=j-1 to j+1  do
    if (g>=1) and (g<=10) and (l>=1) and (l<=10) and not((g=j) and (l=i)) then
      if player1matrix.cells[l,g] = 'R' then
        begin
        stem:=True;
        iDamaged:=l;
        jDamaged:=g;
        end;
if not(stem) then
  begin
  repeat
    limit:=True;
    Rand:=Random(3);
    case Rand of
      0: if i<=9 then Inc(i) else Limit:=false;
      1: if i>=2 then Dec(i) else Limit:=false;
      2: if j<=9 then Inc(i) else Limit:=false;
      3: if j>=2 then Dec(i) else Limit:=false;
    end;
  until limit;
  end
else
  begin
  if jDamaged = j then
    repeat
      limit:=True;
      Rand:=Random(1);
      case Rand of
        0: if (J<=9)
      then
        repeat
        Inc(j);
        if (j=10) and (player1matrix.cells[i,j]='R') then limit:=False;
        until (player1matrix.cells[i,j]<>'R') or (j=10)
      else limit:=false;
        1: if (J>=2)
      then
        repeat
        Dec(j);
        if (j=1) and (player1matrix.cells[i,j]='R') then limit:=False;
        until (player1matrix.cells[i,j]<>'R') or (j=1)
      else limit:=false;
      end;
    until limit;
  if iDamaged = i then
    repeat
      limit:=True;
      Rand:=Random(1);
      case Rand of
        0: if (i<=9) then
        repeat
        Inc(i);
        if (i=10) and (player1matrix.cells[i,j]='R') then limit:=False;
        until (player1matrix.cells[i,j]<>'R') or (i=10)
      else limit:=false;
        1: if (i>=2)
      then
        repeat
        Dec(j);
        if (j=1) and (player1matrix.cells[i,j]='R') then limit:=False;
        until (player1matrix.cells[i,j]<>'R') or (j=1)
      else limit:=false;
      end;
    until limit;
  end;
end;



  procedure KillShip(const fullmatrix: TPF; var EnemyMatrix: TStringGrid; const x,y:Byte);
    var flag, iskilled:Boolean;
    i,j,lasttop, lastdown,lastleft,lastright:byte;
  begin
      if ((fullmatrix[x+1, y] = 'K') or (fullmatrix[x-1, y] = 'K')) then
      begin
        flag:=True;
        isKilled:=true;
        i:=1;
        while(flag) do
        begin
          if ((fullmatrix[x-i, y] = 'K') and (EnemyMatrix.Cells[x-i, y] <> 'R')) then
          begin
            isKilled:=false;
            flag:=false;
          end
          else
          begin
            if (fullmatrix[x-i, y] <> 'K') then
            begin
              flag:=false;
              lastdown:=x-i+1;
            end;
          end;
          Inc(i);
        end;
        flag:=True;
        i:=1;
        while(flag and isKilled) do
        begin
          if ((fullmatrix[x+i, y] = 'K') and (EnemyMatrix.Cells[x+i, y] <> 'R')) then
          begin
            isKilled:=false;
            flag:=false;
          end
          else
          begin
            if (fullmatrix[x+i, y] <> 'K') then
            begin
              flag:=false;
              lasttop:=x+i-1;
            end;
          end;
          Inc(i);
        end;
        if(iskilled) then
        begin
          if (lastdown-1) in [1..10] then
            EnemyMatrix.Cells[lastdown-1, y] := '*';
          if (((lastdown-1) in [1..10]) and ((y+1) in [1..10])) then
            EnemyMatrix.Cells[lastdown-1, y+1] := '*';
          if (((lastdown-1) in [1..10]) and ((y-1) in [1..10])) then
            EnemyMatrix.Cells[lastdown-1, y-1] := '*';
          if (((lasttop+1) in [1..10]) and ((y+1) in [1..10])) then
            EnemyMatrix.Cells[lasttop+1, y+1] := '*';
          if (((lasttop+1) in [1..10]) and ((y-1) in [1..10])) then
            EnemyMatrix.Cells[lasttop+1, y-1] := '*';
          if (lasttop+1) in [1..10] then
            EnemyMatrix.Cells[lasttop+1, y] := '*';
          for j:=lastdown to lasttop do
          begin
            EnemyMatrix.Cells[j, y] := 'K';
            if (y+1) in [1..10] then
              EnemyMatrix.Cells[j, y+1] := '*';
            if (y-1) in [1..10] then
              EnemyMatrix.Cells[j, y-1] := '*';
          end;

          if(currplayer = 2) then
          begin
            LSX:=0;
            LSY:=0;
          end;
        end;
      end
      else
      begin
        if ((fullmatrix[x, y+1] = 'K') or (fullmatrix[x, y-1] = 'K')) then
        begin
          flag:=True;
          isKilled:=true;
          i:=1;
          while(flag) do
          begin
            if ((fullmatrix[x, y-i] = 'K') and (EnemyMatrix.Cells[x, y-i] <> 'R')) then
            begin
              isKilled:=false;
              flag:=false;
            end
            else
            begin
              if (fullmatrix[x, y-i] <> 'K') then
              begin
                flag:=false;
                lastleft:=y-i+1;
              end;
            end;
            Inc(i);
          end;
          flag:=True;
          i:=1;
          while(flag and isKilled) do
          begin
            if ((fullmatrix[x, y+i] = 'K') and (EnemyMatrix.Cells[x, y+i] <> 'R')) then
            begin
              isKilled:=false;
              flag:=false;
            end
            else
            begin
              if (fullmatrix[x, y+i] <> 'K') then
              begin
                flag:=false;
                lastright:=y+i-1;
              end;
            end;
            Inc(i);
          end;
          if(iskilled) then
          begin
            if (lastleft-1) in [1..10] then
              EnemyMatrix.Cells[x,lastleft-1] := '*';
            if (((lastleft-1) in [1..10]) and ((x+1) in [1..10])) then
              EnemyMatrix.Cells[x+1, lastleft-1] := '*';
            if (((lastleft-1) in [1..10]) and ((x-1) in [1..10])) then
              EnemyMatrix.Cells[x-1, lastleft-1] := '*';
            if (((lastright+1) in [1..10]) and ((x+1) in [1..10])) then
              EnemyMatrix.Cells[x+1,lastright+1] := '*';
            if (((lastright+1) in [1..10]) and ((x-1) in [1..10])) then
              EnemyMatrix.Cells[x-1,lastright+1] := '*';
            if (lastright+1) in [1..10] then
              EnemyMatrix.Cells[x, lastright+1] := '*';
            for j:=lastleft to lastright do
            begin
              EnemyMatrix.Cells[x, j] := 'K';
              if((x+1) in [1..10]) then
                EnemyMatrix.Cells[x+1, j] := '*';
              if((x-1) in [1..10]) then
                EnemyMatrix.Cells[x-1, j] := '*';
            end;
            LSX:=0;
            LSY:=0;
          end;
        end
        else
        begin
          EnemyMatrix.Cells[x, y] := 'K';
          if ( (x+1) in [1..10] ) then
            EnemyMatrix.Cells[x+1, y] := '*';
          if ( (y+1) in [1..10] ) then
            EnemyMatrix.Cells[x, y+1] := '*';
          if ( (x-1) in [1..10] ) then
            EnemyMatrix.Cells[x-1, y] := '*';
          if ( (y-1) in [1..10] ) then
            EnemyMatrix.Cells[x, y-1] := '*';
          if ( ((y-1) in [1..10] ) and ((x-1) in [1..10])) then
            EnemyMatrix.Cells[x-1, y-1] := '*';
          if ( ((y+1) in [1..10] ) and ((x-1) in [1..10])) then
            EnemyMatrix.Cells[x-1, y+1] := '*';
          if ( ((y-1) in [1..10] ) and ((x+1) in [1..10])) then
            EnemyMatrix.Cells[x+1, y-1] := '*';
          if ( ((y+1) in [1..10] ) and ((x+1) in [1..10])) then
            EnemyMatrix.Cells[x+1, y+1] := '*';
            LSX:=0;
            LSY:=0;
        end;
      end;
  end;
  procedure AIShotShotShot(player1matrix:TStringGrid);
  var
    missed,second:Boolean;
    AIX, AIY: byte;
  begin
    //lbWalk.Caption := 'Ходит: ИИ';
    missed := False;
    second := False;
    while (not missed) do
    begin
    if not second then
      repeat
      AIX := Random(10) +1;
      AIY := Random(10) +1;
      until ((player1matrix.Cells[AIX,AIY] <> '*') and (player1matrix.Cells[AIX,AIY] <> 'R') and (player1matrix.Cells[AIX,AIY] <> 'K'));
       if player1matrix.Cells[AIX,AIY] = '' then
      begin
        player1matrix.Cells[AIX,AIY] := '*';
        missed:=true;
      end
      else
      begin
        if (player1matrix.Cells[AIX,AIY] = 'S') then
        begin
          Dec(P1N);

          player1matrix.Cells[AIX,AIY] := 'R';
          KillShip(Form1.P1F, player1matrix,AIX,AIY);
          LSX:=AIX;
          LSY:=AIY;
          ShowMessage('Большой ИИ попал в тебя');
          second:=true;
        end;
      end;
      if second then isHitted_wow(player1matrix,AIX,AIY)

    end;

  end;

procedure Seabattle_fieldAI_generator(var P2F:TPF);
  const ships = 20;
   var ib,jb,ie,je,i,j,k,ship_size,ship_amount,direction,n,counter:Integer ;
 var exiter,exc:Boolean;
 function Quick_math(x,y:integer):boolean;
 var count:integer;

 begin

   if (P2F[x-1,y]='K') or (P2F[x,y-1]='K') or (P2F[x-1,y-1]='K')
      or (P2F[x+1,y]='K') or (P2F[x,y+1]='K') or (P2F[x+1,y+1]='K')
      or (P2F[x+1,y-1]='K')or (P2F[x-1,y+1]='K') or (P2F[x,y]='K')  then
   Quick_math:=true
   else quick_math:=false;
 end;
 begin
 while counter<>20 do
  begin

 n:=10;
 for I := 1 to n do
   for j := 1 to n do
     P2F[i,j]:='S';

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
      until not (quick_math(ib,jb)) or ( (jb+ship_size-1>10) or (ib+ship_size-1>10)) ;
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
      if P2F[i,j] = 'K' then inc(counter);

  end;





   end;
  end;
  end;
procedure TForm1.btnAutoCreateClick(Sender: TObject);
var i,j:Integer;
begin
  for i:=1 to 10 do
  begin
    for j:=1 to 10 do
    begin
      player1matrix.Cells[i,j] := '';
      P1F[i,j] := ' ';
    end;
  end;
  Seabattle_fieldAI_generator(P1F);
  for i:=1 to 10 do
    for j:= 1 to 10 do
      Case P1F[i,j] of
        'M' : player1matrix.Cells[i,j] := '';
        'K' : player1matrix.Cells[i,j] := 'S';
      End;
  lbnum1.Caption := '4';
  lbNum2.Caption := '3';
  lbNum3.Caption := '2';
  lbNum4.Caption := '1';
  pnIsFin.Visible := true

end;

procedure TForm1.btNextClick(Sender: TObject);
var i,j:Byte;
// Test1:string;
begin
  for i:=1 to 10 do
  begin
    for j:=1 to 10 do
    begin
      if (player1matrix.Cells[i,j] = 'S') then
        Form1.P1F[i,j] := 'K'
      else
        Form1.P1F[i,j] := 'M';
      //test1 := Test1 + 'S' + P1F[i,j];
    end;
    //test1:= test1 + #10#13;
  end;
  //player1matrix.Free();
  Seabattle_fieldAI_generator(P2F);
  btnAutoCreate.Visible := false;
  pnl1.Visible := false;
  pnIsFin.Visible := false;
  mode := battaly;
  //ShowMessage(P2F[1,1]);
  for i:=1 to 10 do
  begin
    for j:=1 to 10 do
    begin
      Case P2F[i,j] of
        'M' : player2matrix.Cells[i,j] := '';
        'K' : player2matrix.Cells[i,j] := 'S';
      End;
      // player1Field.Cells[i,j] := Form1.P1F[j,i];
    end;
  end;
  currplayer:=1;
  P1N := 20;
  P2N := 20;
  player2matrix.Visible := True;
  pnl4.Visible := true;
  //Form3.UserName := 'kek';
  pnl5.Caption := 'Ваш ход, ' + form3.UserName;
  LSX:=0;
  LSY:=0;
  pnlName.Visible := true;
  pnlName.Caption := form3.UserName;
  img2.Visible := True;
  lbP1N.Visible := true;
  lbP2N.Visible := True;
  pnl5.color := RGB(34,180,34);
  //ShowMessage(player2matrix.Cells[1,1]);
  //Form1.hide;
  //FieldForm.show;
  //ShowMessage(test1);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Form3.ShowModal;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Form3.Close;    // ЭТО ПОТОМ НУЖНО БУДЕТ УБРАТЬ, КОГДА ПОЙДЕМ В РЕЛИЗ
  //  ОНО ЧТОБЫ НЕ ВЫЛАЗИЛА ГРЕБАННАЯ ОШИБКА OUTPUT ERROR
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:Byte;
begin
  for i:=1 to 10 do
  begin
    player1matrix.Cells[i,0]:=IntToStr(i);
    player1matrix.Cells[0,i]:=Chr(1039+i);
    player2matrix.Cells[i,0]:=IntToStr(i);
    player2matrix.Cells[0,i]:=Chr(1039+i);
  end;
  player1matrix.Cells[0,10]:='К';
  player2matrix.Cells[0,10]:='К';
end;


procedure TForm1.N10Click(Sender: TObject);
var
  savedTitle : String;
  rule:string;
begin
  savedTitle := Application.Title;

  rule:= 'Вокруг каждого корабля можно нарисовать область (толщиной в одну клетку), в которой не может быть других кораблей — эту область назовём ореолом данного корабля.';
  rule := rule + 'Одна из выигрышных стратегий описана Я. И. Перельманом. Игрока, использующего эту выигрышную стратегию, назовём Виктором; другого игрока (не использующего выигрышную стратегию Я. И. Перельмана) назовём Петром.';
  rule := rule + #10#13 + #10#13 + 'Выигрышная стратегия Перельмана состоит в том, что Виктор свои многоклеточные корабли компактно располагает в одном из углов поля, «вжимая» в этот угол так, как только возможно. Одноклеточные';
  rule := rule + ' корабли Виктор равномерно распределяет по оставшейся незанятой ';
  rule := rule + 'многоклеточными кораблями части поля. Скорее всего, Пётр относительно';
  rule := rule +'быстро обнаружит, что много кораблей Виктора компактно сосредоточенно в этом углу,';
  rule := rule + ' и быстро уничтожит все корабли Виктора, кроме одноклеточных. После этого, ';
  rule:= rule + ' чтобы найти одноклеточные корабли Виктора, Петру ';
  rule := rule + 'надо будет исследовать своими ходами-выстрелами очень большую площадь, поскольку ореолы многоклеточных кораблей';
  rule := rule + 'Виктора перекрываются, плюс к тому львиная доля площади ореолов кораблей, прижатых к кромке поля, оказывается за пределами поля. Между тем, благодаря тому, что у Петра';
  rule := rule + 'перекрывается меньше площади ореолов, чем у Виктора, Виктору нужно исследовать меньшую площадь поля Петра, чем Петру площадь поля Виктора.';
  rule := rule + #10#13 + #10#13 + 'По мере того, как игроки поражают корабли друг друга, неисследованная Виктором часть площади поля Петра уменьшается быстрее, чем уменьшается неисследованная Петром часть площади поля';
  rule := rule + ' Виктора. Благодаря этому, Виктор быстрее исследует своими ходами-выстрелами поле Петра, ';
  rule := rule + 'чем Пётр поле Виктора, и, следовательно, Виктор быстрее, чем Пётр, поразит все корабли противника. При этом Виктор понесёт большие потери (потеряет все многоклеточные корабли), ';
  rule:= rule+ ' однако правила игры не требуют стремиться к минимальным потерям, поэтому Виктор, сохранив только одноклеточные корабли,';
  rule := rule + 'окажется в выигрыше по сравнению с Петром, который потеряет все свои корабли раньше, чем Виктор.';
  try
    Application.Title := 'Выйгрышная стратегия';
    ShowMessage(rule);
  finally
    rule:='';
    Application.Title := savedTitle;
  end;

end;

procedure TForm1.N11Click(Sender: TObject);
begin
  FormAboutDevelopers.Show;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  ShowMessage('Я еще вернусь!');
  Form1.Close;
end;

procedure TForm1.N5Click(Sender: TObject);
var
  savedTitle : String;
  rule:string;
begin
  savedTitle := Application.Title;
  rule := 'Для расстановки кораблей кликайте по ячейкам игрового поля. Слева вы можете отслеживать, сколько каких кораблей вам осталось создать.';
  rule := rule + #10#13 + 'После правильной расстановки кораблей появится кнопка продолжения.';
  rule := rule + #10#13 + #10#13 + 'Для стрельбы кликайте по ячейкам поля соперника (расположено справа)';

  try
    Application.Title := 'Управление';
    ShowMessage(rule);
  finally
    rule:='';
    Application.Title := savedTitle;
  end;
end;

procedure TForm1.N8Click(Sender: TObject);
var
  savedTitle : String;
begin
  savedTitle := Application.Title;
    try
      Application.Title := 'Правила размещения кораблей';
      ShowMessage('Игровое поле — квадрат 10×10 каждого игрока, на котором размещается флот кораблей.' + #10#13 + #10#13 + 'Размещаются:' + #10#13 + '  • 1 корабль — ряд из 4 клеток («четырёхпалубные»)' + #10#13 + '  • 2 корабля — ряд из 3 клеток («трёхпалубные»)' +  #10#13 + '  • 3 корабля — ряд из 2 клеток («двухпалубные»)' + #10#13 + '  • 4 корабля — 1 клетка («однопалубные»)' + #10#13 + #10#13 + 'При размещении корабли не могут касаться друг друга сторонами и углами.');
    finally
      Application.Title := savedTitle;
    end;
   // ShowMessage(rules);
end;

procedure TForm1.N9Click(Sender: TObject);
var
  savedTitle : String;
  rule:string;
begin
  savedTitle := Application.Title;
  rule := 'Игрок, выполняющий ход, совершает выстрел по определенной клетке';
  rule:= rule + #10#13 + #10#13 + '  • Если выстрел пришёлся в клетку, не занятую ни одним кораблём противника, это «Мимо!» и на этой клетке ставится точка';
  rule := rule + #10#13 + #10#13 + '  • Если выстрел пришёлся в клетку, где находится многопалубный корабль (размером больше чем 1 клетка), то следует вы ранили соперника и клетка закрашивается оранжевым цветом. Стрелявший игрок получает право на ещё один выстрел.';
  rule := rule +  #10#13 + #10#13 + '  • Если выстрел пришёлся в клетку, где находится однотрубный корабль или последнюю непоражённую клетку многопалубного корабля, то вы "убили" корабль. Клетка закрашивается в красный цвет. Стрелявший игрок получает право на ещё один выстрел.';
  rule := rule + #10#13 + #10#13 + 'Победителем считается тот, кто первым потопит все 10 кораблей противника.';
  try
    Application.Title := 'Потопление кораблей противника';
    ShowMessage(rule);
  finally
    rule:='';
    Application.Title := savedTitle;
  end;
end;

procedure TForm1.newGame(Sender: TObject);
  var i,j: byte;
begin
  for i:=1 to 10 do
    for j:=1 to 10 do
    begin
      player1matrix.Cells[i,j] := '';
      player2matrix.Cells[i,j] := '';
    end;
  mode:=Fcreate;
  pnl1.Visible := true;
  pnIsFin.Visible := true;
  player2matrix.Visible := false;
  pnl4.Visible := false;
  pnlName.Visible := false;
  img2.Visible := false;
  lbP1N.Visible := false;
  lbP2N.Visible := false;
  btnAutoCreate.Visible := true;
end;

procedure TForm1.player1matrixDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var X: Real;
begin
 with player1matrix do
  begin
    if(Cells[ACol,ARow] = '*') then
    begin
      Canvas.Brush.Color:=clWhite;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left+10, Rect.Top+5, '•');
    end;
    if (Cells[ACol,ARow] = 'S')   then
    begin
      Canvas.Brush.Color:= RGB(82,158,235);//clBlue;
      Rect.Left:=Rect.Left-5;
      Canvas.FillRect(Rect);
    end;
    if (Cells[ACol,ARow] = '') then
    begin
      Canvas.Brush.Color:=clWhite;
      Rect.Left:=Rect.Left-5;
      Canvas.FillRect(Rect);
    end;
    if (Cells[ACol,ARow] = 'R')   then
    begin
      Canvas.Brush.Color:= RGB(255,170,55);//Orange;
      Rect.Left:=Rect.Left-10;
      Canvas.FillRect(Rect);
    end;
    if (Cells[ACol,ARow] = 'K')   then
    begin
      Canvas.Brush.Color:= clRed;//Red;
      Rect.Left:=Rect.Left-5;
      Canvas.FillRect(Rect);
    end;
    if ((ACol = 0) and (ARow = 0)) then
    begin
      Canvas.Brush.Color:=clWhite;
      Rect.Left:=Rect.Left-5;
      Canvas.FillRect(Rect);
    end;
  end;

end;

procedure TForm1.player1matrixMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: Integer;
  num1,num2,num3,num4: Byte;
procedure showError;
begin
  Form2.ShowModal;
  player1matrix.Cells[ACol,ARow] := '';
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
      if( (player1matrix.Cells[i,j] = 'S')
      and
      ( (player1matrix.Cells[i+1,j] <> 'S') and (player1matrix.Cells[i-1,j] <> 'S')))
      then
      begin
        count:=0;
        k:=j;
        while(player1matrix.Cells[i,k] = 'S') do
        begin
          inc(count);
          inc(k);
          //lbText4.Caption := IntToStr(i) + 'S' + IntToStr(j);
          //player1matrix.Cells[i,j+1] := 'suka';
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
  player1matrix.Col:=ACol;
  player1matrix.Row:=ARow;
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
      if( (player1matrix.Cells[j,i] = 'S')
      and
      ( (player1matrix.Cells[j,i+1] <> 'S') and (player1matrix.Cells[j,i-1] <> 'S')))
      then
      begin
        count:=1;
        k:=j+1;
        while(player1matrix.Cells[k,i] = 'S') do
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
  player1matrix.Col:=ACol;
  player1matrix.Row:=ARow;
end;

begin
  if((mode = FCreate) and (x < 440)) then
  begin
    player1matrix.MouseToCell(X, Y, ACol, ARow);
    if( (ACol <> 0) and (ARow <> 0)) then
    begin
      if (player1matrix.Cells[ACol,ARow] = '') then
      begin
        player1matrix.Cells[ACol,ARow] := 'S';
      end
      else
      begin
        player1matrix.Cells[ACol,ARow] := '';
      end;
      // Далее идет проверка на корректность расстановки (Низя по диагонали и
      // Треугольниками
      if((player1matrix.Cells[ACol+1,ARow+1] = 'S')
          or
          (player1matrix.Cells[ACol+1,ARow-1] = 'S')
          or
          (player1matrix.Cells[ACol-1,ARow+1] = 'S')
          or
          (player1matrix.Cells[ACol-1,ARow-1] = 'S')
          or
          ((player1matrix.Cells[ACol,ARow+1] = 'S') and (player1matrix.Cells[ACol+1,ARow] = 'S'))
          or
          ((player1matrix.Cells[ACol,ARow-1] = 'S') and (player1matrix.Cells[ACol-1,ARow] = 'S'))
          or
          ((player1matrix.Cells[ACol,ARow+1] = 'S') and (player1matrix.Cells[ACol-1,ARow] = 'S'))
          or
          ((player1matrix.Cells[ACol,ARow-1] = 'S') and (player1matrix.Cells[ACol+1,ARow] = 'S')))
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
      // pnIsFin.Visible := true
    end;
  end;
end;

procedure TForm1.player2matrixDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var flag:Boolean;
begin
  {case currplayer of
    1: lbWalk.Caption := 'Ходит: ' + form3.UserName;
    2: lbWalk.Caption := 'Ходит: ИИ';
  end;  }
  flag:=false;
  with player2matrix do
  begin
    if (Cells[ACol,ARow] = 'S')   then
    begin
      Canvas.Brush.Color:= clWhite;//RGB(82,158,235);//clBlue;
      Rect.Left:=Rect.Left-5;
      Canvas.FillRect(Rect);
    end;
    if (Cells[ACol,ARow] = 'R')   then
    begin
      Canvas.Brush.Color:= RGB(255,170,55);//Orange;
      Rect.Left:=Rect.Left-10;
      Canvas.FillRect(Rect);
    end;
    if (Cells[ACol,ARow] = 'K')   then
    begin
      Canvas.Brush.Color:= clRed;//Red;
      Rect.Left:=Rect.Left-5;
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
      Rect.Left:=Rect.Left-5;
      Canvas.FillRect(Rect);
    end;
    if(Cells[ACol,ARow] = '*') then
    begin
      Canvas.Brush.Color:=clWhite;
      flag:=true;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left+10, Rect.Top+5, '•');
    end;
  end;

  if (flag) then
  begin

    if (currplayer = 2) then
    begin
      //pnl5.Visible := false;
      sleep(800);
      // ShowMessage('Стреляет ПАРАМОШКА!!!!');
      AIShotShotShot(player1matrix);
      lbP1N.Caption := IntToStr(P1n);
      Currplayer := 1;
    end;
    pnl5.Visible := true;
    pnl5.color := RGB(34,180,34);
    pnl5.Caption := 'Ваш ход, ' + form3.UserName;
  end;
end;


procedure TForm1.player2matrixMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: Integer;
  type TEM = array[1..10,1..10] of string;

begin
  if (mode = battaly) then
  begin
    if (currplayer = 2) then
      ShowMessage('Соблюдай очередь, иначе придет большой ИИ и накажет тебя :c');
    if (currplayer = 1) then
    begin
      player2matrix.MouseToCell(X, Y, ACol, ARow);
      if( (ACol <> 0) and (ARow <> 0)) then
      begin
        // ShowMessage(IntToStr(ACol));
        if (player2matrix.Cells[ACol,ARow] = '') then
        begin
          // ТУТ ПУСТОЕ ПОЛЕ
          player2matrix.Cells[ACol,ARow] := '*';
          currplayer:=2;
          pnl5.Caption := 'Ходит ИИ';
          pnl5.color := RGB(0,50,0);
          pnl5.Font.Color := clWhite;
        end
        else
        begin
          case player2matrix.Cells[ACol,ARow][1] of
            '*','R','K': ShowMessage('Ты уже стрелял сюда :c');
            'S':   // МЫ ПОПАЛИ!!!
            begin
              Dec(P2N);
              lbP2N.Caption := IntToStr(P2n);
              player2matrix.Cells[ACol,ARow] := 'R';
              KillShip(Form1.P2F, player2matrix,ACol,ARow);
            end;
          else ShowMessage('error :C');
          end;
          {if(player2matrix.Cells[ACol,ARow] = '*') then
          begin

          end
          else
          begin
            player2matrix.Cells[ACol,ARow] := '*';
          end;  }

        end;
      end;
    end;
    //lbP1N.Caption := IntToStr(P1N);
    //lbP2N.Caption := IntToStr(P2N);
  end;
  if ((P1N =  0) or (P2N = 0)) then
  begin
    ShowMessage('Game Over');
    mode := GameOver;
    if (P1N = 0) then
      ShowMessage('Парамошка победил, поэтому может и продолжать не выставлять модули');
  end;
end;


end.
