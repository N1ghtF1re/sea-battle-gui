{*******************************************************}
{                                                       }
{       Sea Battle GUI                                  }
{       The trademark is not registered                 }
{       no rights are protected                         }
{       (c) 2018,  BrakhMen Corp                        }
{       SITE: brakhmen.info                             }
{                                                       }
{*******************************************************}


unit CreateField;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons, Vcl.Menus;

type
  hard = (easy,medium,paramon);
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
    rb1: TRadioButton;
    rb2: TRadioButton;
    rb3: TRadioButton;
    lbl1: TLabel;
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
    procedure N6Click(Sender: TObject);
    procedure rb1Click(Sender: TObject);
    procedure rb2Click(Sender: TObject);
    procedure rb3Click(Sender: TObject);

  private
    { Private declarations }
  public
    var
      P1F: TPF;
      P2F: TPF;
  end;

var
  hardness:hard;
  Form1: TForm1;
  mode:TMode;
  isShow:Boolean;
  LSX, LSY:byte;
  isRevers:Boolean;
  CurrPlayer:1..2;
  P1N, P2N: 0..20;
  AntiKick:Boolean;
implementation

{$R *.dfm}

uses ErrorPage, MainPage, AboutUs;

procedure isHitted_wow(var player1matrix:TStringGrid; var i,j:byte);
// Старый ИИ от Кирилла, а может и не старый.
// Время покажет... Но возможно этот код скоро
// Придется удалить :c
var rand,  iDamaged, jDamaged, K, trigr:integer;
    stem,limit:Boolean;
begin
stem:=False;
idamaged:=0;
jDamaged:=0;
k:=0;
if j<=9 then
  if player1matrix.cells[i,j+1] = 'R' then
        begin
        stem:=True;
        iDamaged:=i;
        end;
if j>=2 then
  if player1matrix.cells[i+1,j] = 'R' then
        begin
        stem:=True;
        jDamaged:=j;
        end;
if i<=9 then
  if player1matrix.cells[i,j-1] = 'R' then
        begin
        stem:=True;
        iDamaged:=i;
        end;
if i>=2 then
  if player1matrix.cells[i-1,j] = 'R' then
        begin
        stem:=True;
        jDamaged:=j;
        end;
if not(stem) then
  begin
  repeat
    INC(K);
    limit:=True;
    Rand:=Random(3);
    case Rand of
      0: if i<=9 then
      begin
      trigr:=0;
      repeat
      Inc(i);
      Inc(trigr);
      if ((i=10) and (player1matrix.cells[i,j] <> '')) and (player1matrix.Cells[i,j] <> 'S') then
        begin
        limit:=False;
        dec(i,trigr);
        end;
      until (player1matrix.Cells[i,j]='S') or (player1matrix.Cells[i,j]='') or (i=10)
      end
    else Limit:=false;

      1: if i>=2 then
      begin
      trigr:=0;
      repeat
      dec(i);
      Inc(trigr);
      if ((i=1) and (player1matrix.cells[i,j] <> '')) and (player1matrix.Cells[i,j] <> 'S') then
        begin
        limit:=False;
        inc(i,trigr);
        end;
      until (player1matrix.Cells[i,j]='S') or (player1matrix.Cells[i,j]='') or (i=1)
      end
    else Limit:=false;

      2: if j<=9 then
      begin
      trigr:=0;
      repeat
      Inc(j);
      Inc(trigr);
      if ((j=10) and (player1matrix.cells[i,j] <> '')) and (player1matrix.Cells[i,j] <> 'S') then
        begin
        limit:=False;
        dec(j,trigr);
        end;
      until (player1matrix.Cells[i,j]='S') or (player1matrix.Cells[i,j]='') or (j=10)
      end
    else Limit:=false;

      3: if j>=2 then
      begin
      trigr:=0;
      repeat
      dec(j);
      Inc(trigr);
      if ((j=1) and (player1matrix.cells[i,j] <> '')) and (player1matrix.Cells[i,j] <> 'S') then
        begin
        limit:=False;
        inc(j,trigr);
        end;
      until (player1matrix.Cells[i,j]='S') or (player1matrix.Cells[i,j]='') or (j=1)
      end
    else Limit:=false;
    end;
  until ((limit) and ((player1matrix.Cells[i,j] = 'S') or (player1matrix.Cells[i,j] = '')))  or (k=30) ;
  if k=30 then
  repeat
      i := Random(10) +1;
      j := Random(10) +1;
  until ((player1matrix.Cells[i,j] <> '*') and (player1matrix.Cells[i,j] <> 'R') and (player1matrix.Cells[I,J] <> 'K'));
  end
  else
  begin
  if jDamaged = j then
    repeat
    Inc(k);
      limit:=True;
      Rand:=Random(1);
      case Rand of
        0: if (J<=9)
      then
        begin
        trigr:=0;
        repeat
        Inc(j);
        Inc(trigr);
        if ((j=10) and ((player1matrix.cells[i,j]<>'') and (player1matrix.cells[i,j]<>'S'))) or (player1matrix.Cells[i,j]= '*') then
          begin
          limit:=False;
          Dec(j,trigr);
          end;
        until (player1matrix.cells[i,j]='') or (player1matrix.cells[i,j]='S') or (j=10)
        end
      else limit:=false;
        1: if (J>=2)
      then
        begin
        trigr:=0;
        repeat
        Dec(j);
        inc(trigr);
        if ((j=1) and ((player1matrix.cells[i,j]<>'') and (player1matrix.cells[i,j]<>'S'))) or (player1matrix.Cells[i,j]= '*') then
          begin
            limit:=False;
            Inc(j,trigr);
            end;
        until (player1matrix.cells[i,j]='') or (player1matrix.cells[i,j]='S') or (j=1)
        end
      else limit:=false;
      end;
    until (limit) or (k=30);
  if iDamaged = i then
    repeat
      Inc(k);
      limit:=True;
      Rand:=Random(1);
      case Rand of
        0: if (i<=9) then
        begin
        trigr:=0;
        repeat
        Inc(i);
        Inc(trigr);
        if ((i=10) and ((player1matrix.cells[i,j]<>'') and (player1matrix.cells[i,j]<>'S'))) or (player1matrix.Cells[i,j]= '*') then
          begin
          limit:=False;
          Dec(i,trigr);
          end;
        until (player1matrix.cells[i,j]='') or (player1matrix.cells[i,j]='S') or (i=10)
        end
      else limit:=false;
        1: if (i>=2)
      then
        begin
        trigr:=0;
        repeat
        Dec(i);
        Inc(trigr);
        if ((i=1) and ((player1matrix.cells[i,j]<>'') and (player1matrix.cells[i,j]<>'S'))) or (player1matrix.Cells[i,j]= '*') then
          begin
          limit:=False;
          Inc(i,trigr);
          end;
        until (player1matrix.cells[i,j]='') or (player1matrix.cells[i,j]='S') or (i=1)
        end
      else limit:=false;
      end;
    until (limit) or (k=30);
  if k=30 then
      repeat
      i := Random(10) +1;
      j := Random(10) +1;
      until ((player1matrix.Cells[i,j] <> '*') and (player1matrix.Cells[i,j] <> 'R') and (player1matrix.Cells[I,J] <> 'K'));
  end;
end;

function KillShip(const fullmatrix: TPF; var EnemyMatrix: TStringGrid; const x,y:Byte):Boolean;
  // Функция возвращает true если корабль убит, false если еще не убит
  // В ней же происходит "убийство" корабля (заменя "R" на "S" если убили
  // Корабль
  // В прочем, тут ничего интересного

    var flag, iskilled:Boolean;
    i,j,lasttop, lastdown,lastleft,lastright:byte;
  begin
      // Честно говоря, писал я ее давным давно, поэтому сильно
      // не помню, как она работает, поэтому лучше ее не трогать
      // да и работает она идеально
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
            //ShowMessage('kek');
            LSX:=0;    // ИИ убил корабль - обнуляем координаты
            LSY:=0;    // Последнего раненого корабля (подробнее в процедуре AIShotShotShot


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
            if(currplayer = 2) then
            begin
              //ShowMessage('kek');
              LSX:=0;    // ИИ убил корабль - обнуляем координаты
              LSY:=0;    // Последнего раненого корабля (подробнее в процедуре AIShotShotShot

            end;
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
          if(currplayer = 2) then
          begin
            LSX:=0;    // ИИ убил корабль - обнуляем координаты
            LSY:=0;    // Последнего раненого корабля (подробнее в процедуре AIShotShotShot
          end;
        end;
      end;
      KillShip:=isKilled;
  end;

procedure AIShotShotShot(player1matrix:TStringGrid);
  var
    missed,second:Boolean;
    AIX, AIY: byte;
    flag:Boolean;
  begin
    //lbWalk.Caption := 'Ходит: ИИ';
    missed := False;
    second := False;
    if ((currplayer = 2) and (P1N > 0) )  then
    begin
      if (hardness = easy) then  // Если левел изи, то тупо рандомим
      begin
        repeat
          AIX := Random(10) +1;
          AIY := Random(10) +1;
        until ((player1matrix.Cells[AIX,AIY] <> '*') and (player1matrix.Cells[AIX,AIY] <> 'R') and (player1matrix.Cells[AIX,AIY] <> 'K'))
      end
      else
      begin
        if (player1matrix.Cells[LSX,LSY] = 'K') then
        begin
          lsx:=0;   // На всякий случай, если в клетке K
          lsy:=0;   // Обнуляем
        end;
        if (hardness = paramon) then
        begin
          case Random(2) of
            0: flag:=false;
            1: flag:=True;
          end;
        end
        else
          flag:=true;
        if (LSX = 0) then
        repeat
          // LSX, LSY - содержат координаты последнего раненого корабля
          // Если корабль убивается, то они равны нулю.
          // Если равны нулю, то рандомим по красоте
          AIX := Random(10) +1;
          AIY := Random(10) +1;
          if (player1matrix.Cells[AIX,AIY] = 'S') then flag:=True;
        until ( flag and (player1matrix.Cells[AIX,AIY] <> '*') and (player1matrix.Cells[AIX,AIY] <> 'R') and (player1matrix.Cells[AIX,AIY] <> 'K'))
        else
        begin
          AIX := LSX;
          AIY := LSY;
          // Если мы еще не ранили ничего в округе (мы знаем ток одну клетку)
          if (((AIX = 10) or (player1matrix.Cells[AIX+1,AIY] <> 'R')) and
              ((AIX = 0) or (player1matrix.Cells[AIX-1,AIY] <> 'R')) and
              ((AIY = 10) or (player1matrix.Cells[AIX,AIY+1] <> 'R')) and
              ( (AIY = 0) or (player1matrix.Cells[AIX,AIY-1] <> 'R')))
          then
          begin

            repeat
              AIX := LSX;
              AIY := LSY;
              //ShowMessage('Ищем соседа' + player1matrix.Cells[AIX+1,AIY] +  player1matrix.Cells[AIX-1,AIY] + player1matrix.Cells[AIX,AIY+1] + player1matrix.Cells[AIX,AIY-1] <> 'R');
              IF(LSX) = 0 then Break;
              case Random(4) + 1 of
                1: Inc(AIX);   // Рандомим ячейку в окрестности раненой
                2: Inc(AIY);
                3: Dec(AIX);
                4: Dec(AIY);
              end;
              //ShowMessage('Рандомим соседнюю, X: ' + IntToStr(AIX) + ' Y: ' + IntToStr(AIY));
            until((AIX in [1..10]) and (AIY in [1..10]) and (player1matrix.Cells[AIX,AIY] <> '*') and (player1matrix.Cells[AIX,AIY] <> 'R') and (player1matrix.Cells[AIX,AIY] <> 'K'));
          end
          else
          begin
            // Если слева/справа от нашей последней раненой ячейки есть еще
            // одна раненая, то заходим сюда
            if((AIX <> 10) and (player1matrix.Cells[AIX+1,AIY] = 'R')) or ((AIX <> 0) and(player1matrix.Cells[AIX-1,AIY] = 'R')) then
            begin
              // Рандомим столбец
              isRevers:= false;
              AIX := LSX;
              AIY := LSY;
              // Пока мы не наткнемся на 'S' или '' гуляем по циклу
              // слева направо, если натыкаемся на "Мимо" ("*"), то
              // теперь идем справа налево. Если натыкаемся на 'S'
              // или '', то пиу-пау в корабль игрока
              // ну и тестим, что не вышли на границы цикла
              while(((player1matrix.Cells[AIX,AIY]) <> 'S') or ((player1matrix.Cells[AIX,AIY]) <> '')) do
              begin
                //ShowMessage(IntToStr(AIX) + ' Content : ' + player1matrix.Cells[aix,AIY]);
                if ((AIX in [1..10]) and (player1matrix.Cells[AIX,AIY] = 'S')) then Break;
                if ((AIX in [1..10]) and (player1matrix.Cells[AIX,AIY] = '')) then Break;
                if (not isRevers) then
                begin
                  inc(AIX);
                  if (not (AIX in [1..10]) or (player1matrix.Cells[AIX,AIY] = '*')) then
                    isRevers:= True;
                end
                else
                begin
                  Dec(AIX);
                end;
              end;
            end
            else
            begin
              // Если верху/внизу от нашей последней раненой ячейки есть еще
              // одна раненая, то заходим сюда
              if((AIY <> 10) and (player1matrix.Cells[AIX,AIY+1] = 'R')) or ((AIX <> 0) and(player1matrix.Cells[AIX,AIY-1] = 'R')) then
              begin
                AIX := LSX;
                AIY := LSY;
                // Рандомим строку
                isRevers:= false;
                // Пока мы не наткнемся на 'S' или '' гуляем по циклу
                // снизу вверх, если натыкаемся на "Мимо" ("*"), то
                // теперь идем серху вниз. Если натыкаемся на 'S'
                // или '', то пиу-пау в корабль игрока
                // ну и тестим, что не вышли на границы цикла
                while(((player1matrix.Cells[AIX,AIY]) <> 'S') or ((player1matrix.Cells[AIX,AIY]) <> '')) do
                begin
                  if ((AIY in [1..10]) and (player1matrix.Cells[AIX,AIY] = 'S')) then Break;
                  if ((AIY in [1..10]) and (player1matrix.Cells[AIX,AIY] = '')) then Break;
                  //ShowMessage(IntToStr(AIY) + ' Content : ' + player1matrix.Cells[aix,AIY]);
                  if (not isRevers) then
                  begin
                    inc(AIY);
                    if ((not (AIY in [1..10]) or (player1matrix.Cells[AIX,AIY] = '*'))) then
                      isRevers:= True;
                  end
                  else
                  begin
                    Dec(AIY);
                  end;
                end;
              end;
            end;

          end;
        end;
      end;
      {
      ### Затем в процедуре player1matrixDrawCell идет повторный вызов
      AIShotShotShot (где отрисовываются раненые корабли)
      Это было сделано для того, что бы была хоть какая задержка
      И наш Парамошка не стрелял из дробовика, раня сразу весь корабль
      Одним выстрелом
      }
    //if (second) and (P1N>0) then isHitted_wow(player1matrix,AIX,AIY);
      if (currplayer = 2) then // Проверяем, попал ли наш
      // Парамошка по кораблю, иль промазал
      begin
        if player1matrix.Cells[AIX,AIY] = '' then
        begin
          player1matrix.Cells[AIX,AIY] := '*';
          missed:=true;
          // Прое... промазал
          currplayer := 1;
          //ShowMessage('Miss');
        end
        else
        begin
          if (player1matrix.Cells[AIX,AIY] = 'S') then
          begin
            Dec(P1N);
            player1matrix.Cells[AIX,AIY] := 'R';
            LSX:=AIX;
            LSY:=AIY;
            // Парамошка попал

          end;
        end;
      end;


    end;
    //ShowMessage('Sibasa');
    currplayer := 1;
  end;

procedure Seabattle_fieldAI_generator(var P2F:TPF);
// Эт функция Никиты. Никита хороший парень, больше ничего сказать
// Не могу. Ну только, что сейчас процедура работает ну просто
// Идеально. ЗЫ Никита, если не трудно, можешь закомментить))
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
      until not (quick_math(ib,jb)) or ( (jb+ship_size-1>10) and (ib+ship_size-1>10)) ;
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
// Если юзверь нажимает "Автогенерация", юзаем процедуру Никиты
// И даем юзверю то, что он жаждет - хорошее поле
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
  lbnum1.Caption := '4'; // Обновляем счетчики справа
  lbNum2.Caption := '3';
  lbNum3.Caption := '2';
  lbNum4.Caption := '1';
  pnIsFin.Visible := true; // Даем лицезреть полузигующего Парамошку

end;

procedure TForm1.player1matrixDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var X: Real;rept:Boolean;
begin
  // Тут уже очень даже интересно. Отрисовываем ячейки матрицы первого
  // Игрока.
  // Если там '' - белым. если 'S' - синим (корабль)
  // Если '*' - белым + рисуем там точку посреди
  // Если 'R' - оранжевым. Если 'K' - красным
  // Ну и тип эт, если отрисовывается R, там же вызывается AIShotShotShot
  // (Если ИИ попал и ранил кого-то кроме себя, то он стреляет еще раз)
  rept:=false;
 with player1matrix do
  begin
  AntiKick:=true;
    if(Cells[ACol,ARow] = '*') then
    begin
      Canvas.Brush.Color:=clWhite;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left+10, Rect.Top+5, '•');
      currplayer:=1;
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
      Sleep(600);
      currplayer:=2;
      AIShotShotShot(player1matrix);
      // ИИ наносит еще раз удар
      //Sleep(500);
      if KillShip(Form1.P1F, player1matrix,ACol,Arow) then  // Проверяем,
            // Убил ли наш ИИ корабль. И если да - отрисовываем гениальной
            // Процедурой убитые корабли и вызываем AIShotShotShot
      begin
        rept:=true;
      end;
    end;
    if (Cells[ACol,ARow] = 'K')   then
    begin
      Canvas.Brush.Color:= clRed;//Red;
      Rect.Left:=Rect.Left-5;
      Canvas.FillRect(Rect);
      currplayer:=2;
    end;
    if ((ACol = 0) and (ARow = 0)) then
    begin
      Canvas.Brush.Color:=clWhite;
      Rect.Left:=Rect.Left-5;
      Canvas.FillRect(Rect);
    end;
  end;
  if (rept) then
  begin
    rept:=false;
    AIShotShotShot(player1matrix);
  end;
  if CurrPlayer = 1 then
    AntiKick:=False;
  if CurrPlayer = 1 then
  begin
    pnl5.Visible := true;
    pnl5.color := RGB(34,180,34);
    pnl5.Caption := 'Ваш ход, ' + form3.UserName;
  end;

end;

procedure TForm1.player1matrixMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
// Найс процедура. Первое мое творение в этом приложении.
// Игра имеет несколько режимов.
// Переменная перечисляемого типа mode
// Режимы: создание поля, игра, завершение игры
// Когда идем режим создания поля, то эта процедура будет работать,
// Обрабатывать клики и создавать поле для игрока. Повторный клик -
// Очистка ячейки
// Процедуры checkInCol и checkInRow внутри этой процедуры тупо
// корабли. Подробнее внутри их, но особо интересного ничего там нет
var
  ACol, ARow: Integer;
  num1,num2,num3,num4: Byte;
procedure showError;
begin
  Form2.ShowModal; // if юзверь налажал then показываем ему Парамошку с ошибкой
  player1matrix.Cells[ACol,ARow] := '';
end;

procedure checkInCol(var num1,num2,num3,num4:byte);
var
  i,j,k:byte;
  count:byte;
begin
  // ************* Подсчет кораблей в столбец **************** \\
  for i:=1 to 10 do   // Перебираем столбцы
  begin
    j:=1;
    while(j<=10) do // Перебираем строки                 // i - столбец, j - строка
    begin                            // [Col, Row]  ([Столбец, Строка])
      if( (player1matrix.Cells[i,j] = 'S') // Найден коарбль, считаем кол-во кораблей подряд. Если находим не корабль - выходим
      and
      ( ((i = 10) or (player1matrix.Cells[i+1,j] <> 'S'))
        and
        ((i = 1) or (player1matrix.Cells[i-1,j] <> 'S'))))
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
        j:=k;
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
// Полностью аналогично прошлой процедуре. Писать - лень
var
  i,j,k:byte;
  count:byte;
begin
  // /\/\************* Подсчет кораблей в строчу ****************
  for i:=1 to 10 do
  begin
    j:=1;
    while(j<=10) do
    begin
      if( (player1matrix.Cells[j,i] = 'S')
        and
        (((i = 10) or (player1matrix.Cells[j,i+1] <> 'S'))
          and
        ((i = 1) or (player1matrix.Cells[j,i-1] <> 'S'))))
      then
      begin
        count:=1;
        k:=j+1;
        while(player1matrix.Cells[k,i] = 'S') do
        begin
          inc(count);
          inc(k);
        end;
        j:=k;
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
  if((mode = FCreate) and (x < 440)) then // При смене мода клики
  // по полю первого игрока не будут обрабатываться

  begin
    player1matrix.MouseToCell(X, Y, ACol, ARow); // Отслеживаем, куда же кликнул
    // Наш юзер. Acol, Arow - возвращаемые адрес Колонки и Строки, по которой
    // Произведен клик
    if( (ACol <> 0) and (ARow <> 0)) then
    begin
      if (player1matrix.Cells[ACol,ARow] = '') then
      begin
        player1matrix.Cells[ACol,ARow] := 'S'; // Если было пусто, ставим кораблик
      end
      else
      begin
        player1matrix.Cells[ACol,ARow] := '';  // Если был корабль - то ставим пусто
      end;
      // ОСТОРОЖНО! Просьба отойти от мониторов людей с нервными заболеваниями,
      // непеносимостью кучи условий, беременных женщик, инвалидов и т.д.
      // ДАЛЕЕ ОЧЕНЬ МНОГО УСЛОВИЙ. Я предупредил...

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
        showError; // Показываем Парамошку
      end;
      num1:=0;
      num2:=0;
      num3:=0;
      num4:=0;
      checkInRow(num1,num2,num3,num4);
      checkInCol(num1,num2,num3,num4);
      if ((num1 = 4) and (num2 = 3) and (num3 = 2) and (num4 = 1)) then
        pnIsFin.Visible := true // Если все хорошо, разрешаем идти дальше
      else
        pnIsFin.Visible := false;
      // pnIsFin.Visible := true
    end;
  end;
end;

procedure TForm1.player2matrixDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
  // Отрисовываем ячейки матрицы второго игрока
  // Если там '' - белым. Если там корабль('S') - белым.
  // Если '*' - белым + рисуем там точку посреди
  // Если 'R' - оранжевым. Если 'K' - красным
var flag:Boolean;
begin
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
      //pnlName.Caption := IntToStr(currplayer);
      if currplayer = 2 then
        flag:=true;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left+10, Rect.Top+5, '•');
    end;
  end;

  if (flag) then       // Небольшая махинация. Если игрок промазывает,
  // Показывается табличка "Ходит ИИ"
  begin
    if (currplayer = 2) then
    begin
      //pnl5.Visible := false;
      AntiKick:=true;
      sleep(800);
      AIShotShotShot(player1matrix);
      lbP1N.Caption := IntToStr(P1n);
      currplayer := 1;
      flag:=false;
    end;
    if ((P1N =  0) and (mode = battaly)) then
    begin
      ShowMessage('Game Over');
      mode := GameOver;
      if (P1N = 0) then
        ShowMessage('Парамошка победил, поэтому может и продолжать не выставлять модули');
    end;
  end;
end;

procedure TForm1.player2matrixMouseUp (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
// Игра имеет несколько режимов.
// Переменная перечисляемого типа mode
// Режимы: создание поля, игра, завершение игры
// Когда идем режим игры, то эта процедура будет работать,
// В процедуре стреляет игрок в ИИ
var
  ACol, ARow: Integer;
  type TEM = array[1..10,1..10] of string;

begin
  if (mode = battaly) then
  begin
    if (CurrPlayer = 2) and (LSX = 0) then
    begin
      CurrPlayer := 1;
      AntiKick := false;
    end;
    if (AntiKick or (currplayer = 2)) then // Как без угроз
    ShowMessage('Соблюдай очередь, иначе придет большой ИИ и накажет тебя :c');
    if ((not AntiKick) and (currplayer = 1)) then
    begin
      player2matrix.MouseToCell(X, Y, ACol, ARow); // Отслеживаем клик юзера
      // В ACol and Arow возвращаются координаты Колонки и Строки
      // В которые "Тыкнул" юзуер
      if( (ACol <> 0) and (ARow <> 0)) then
      begin
        if (player2matrix.Cells[ACol,ARow] = '') then
        begin
          // Юзер промазал, теперь стреляет наш
          // Мистер сдвиг
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
            'S':   // ИИ ПОРАЖЕН! МЫ ЕГО РАНИЛИ (ИЛИ УБИЛИ, НО ЭТ НЕ ТОЧНО)
            begin
              Dec(P2N);
              lbP2N.Caption := IntToStr(P2n); // Изменяем счетчик оставшихся ячеек
              // корабликов внизу
              player2matrix.Cells[ACol,ARow] := 'R';
              KillShip(Form1.P2F, player2matrix,ACol,ARow); // Если мы убили, заменяем 'R' на 'K'
            end;
          else ShowMessage('error :C'); // На всякий случай. Такого быть не может, но
          // В военное впемя и синус может быть равен трем (с)
          end;

        end;
      end;
    end;
    //lbP1N.Caption := IntToStr(P1N);
    //lbP2N.Caption := IntToStr(P2N);
  end;
  if ((P1N =  0) or (P2N = 0)) then // ее, игра кончилась... Или не еее
  begin
    ShowMessage('Game Over');
    mode := GameOver;
    if (P1N = 0) then
      ShowMessage('Парамошка победил, поэтому может и продолжать не выставлять модули');
  end;
end;

procedure TForm1.rb1Click(Sender: TObject);
begin
   hardness:=easy;
end;

procedure TForm1.rb2Click(Sender: TObject);
begin
  hardness:=medium;

end;

procedure TForm1.rb3Click(Sender: TObject);
begin
  hardness:=paramon;
end;

procedure TForm1.btNextClick(Sender: TObject);
// если пользователю надоел Парамошка, он нажимает далее
// И карочи скрываются ненужные блоки, показываеются нужные
// Вообщем, в этой процедуре довольно таки скучно.
// Чуть веселее, чем на лекциях Дубовца (хотя от куда мне знать)
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
// Ну тут изи. Када форма открывается и уже отображается, то
// Предлагаем юзеру ввести имя.
// isShow - чтобы запускалась она онли один раз за сессию
begin
  if(not isShow)then
  begin
    Form3.ShowModal;
    isShow:= true;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
// Это можно удалить, но как-то жалко. История, все таки.

begin
  //Form3.Close;    // ЭТО ПОТОМ НУЖНО БУДЕТ УБРАТЬ, КОГДА ПОЙДЕМ В РЕЛИЗ
  //  ОНО ЧТОБЫ НЕ ВЫЛАЗИЛА ГРЕБАННАЯ ОШИБКА OUTPUT ERROR

end;

procedure TForm1.FormCreate(Sender: TObject);
// При создании формы инициализируем все шо надо
var i:Byte;
begin
  currplayer:=1;
  isShow:=false;
  hardness := medium;
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
// ОСТОРОЖНО!!!1 Многа букаф, это страница "Выйгрышная стратегия". Сворачивай и листай дальше
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
  // Наша шикарная страница "О разработчиках"
  FormAboutDevelopers.Show;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  // Когда нажимают "Завершить игру" В менюхе
  ShowMessage('Я еще вернусь!');
  Form1.Close;
end;

procedure TForm1.N5Click(Sender: TObject);
// ОСТОРОЖНО!!!1 Многа букаф, это страница "Управление". Сворачивай и листай дальше
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

procedure TForm1.N6Click(Sender: TObject);
// Шикарное описание нашей проги от Кирилла
  var
  savedTitle : String;
  rule:string;
begin
  savedTitle := Application.Title;
  rule := 'SEA-BATTLE-GUI (Торговая марка не зарегистрирована, никакие права не защищены, все имена вымышленные, а фотографии сгенерированны нейросетью, все совпадения неслучайны)- это';
  rule := rule + 'современный симулятор войны, основанный на технологиях самообучившегося искусственного интеллекта и дополнительной реальности.';
  rule := rule + #10#13 + #10#13 + 'В нашей игре вы сможете управлять своим флотом современной морской техники и противостоять армии восстания машин! Мы также поддерживаем блокчейн технологии - встроенные скрипты будут майнить криптовалюты за счет мощностей вашего процессора!';
  rule := rule + #10#13 + #10#13 + #10#13 + 'Мы успешно решили две главные задачи, которые ставили перед новым написанием данной программы. Во-первых, обеспечили себе занятие на каникулы, ведь Оношко Д.Е. сказал нам: делайте, что хотите, пока время позволяет.';
  rule := rule + 'Во-вторых, изучили поведение иноземного искусственного интеллекта в условиях графического пользовательского интерфейса. ';
  rule := rule + #10#13 + 'Александр Панкратьев,';
  rule := rule + #10#13 + 'Технический директор BrakhMen Corp';
  rule:= rule + #10#13 + #10#13 + 'Морской бой еще никогда не был таким увлекающим!' + #10#13 + '(Торговая марка не зарегистрирована, никакие права не защищены)';
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
// ОСТОРОЖНО!!!1 Многа букаф, это страница "Правила размещения кораблей". Сворачивай и листай дальше
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
// Опять скучно, как на лекциях у Дубовца (но эт не точно)
// Когда юзер нажимает "Новая игра" в меню, то исчезают ненужные блоки
// появляются нужные и все возвращается в исходное состояние
// и обнуляется
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
  pnIsFin.Visible := false;
  player2matrix.Visible := false;
  pnl4.Visible := False;
  lbP1N.Caption:= '20';
  lbP2N.Caption := '20';
  pnlName.Visible := false;
  img2.Visible := false;
  lbP1N.Visible := false;
  lbP2N.Visible := false;
  btnAutoCreate.Visible := true;
end;
end.
