unit HOD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Data.Win.ADODB,
  CPort, Vcl.Menus;

type
  THODTEST1 = class(TForm)
    ADOC: TADOConnection;
    ADOT1: TADOTable;
    Timer1: TTimer;
    ADOT2: TADOTable;
    TrayIcon1: TTrayIcon;
    ComPort1: TComPort;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure TrayIcon1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HODTEST1: THODTEST1;
    RBuf: array[1..20] of Byte;
    //äëÿ õðàíåíèÿ ïîñëåä. êàðòû
  HBuf: array[1..5] of Byte;
    //äëÿ õðàíåíèÿ ïîñëåä. äàí. î äàò÷èêå
  HBufD: array[1..2] of Byte;
    //Ñîñòîÿíèå âîðîò
  FBufRC: array [1..27] of Byte=($DA,$17,$03,$66,$08,$08,$08,$00,$00,$00,$00,$D5,$21,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$54);
  FBufRO: array [1..27] of Byte=($DA,$17,$03,$66,$08,$08,$08,$00,$00,$00,$00,$C5,$21,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$44);
  FBufD: array [1..7] of Byte=($DA, $03, $00, $00, $4C, $05, $90);
Const
  FBufC: array [1..7] of Byte=($DA, $03 ,$00 ,$05,$50,$10,$9C);
implementation

{$R *.dfm}

Procedure Connect;
begin
try
   HODTEST1.ADOC.Connected:=true;
   HODTEST1.ADOT1.Filtered:=false;
   HODTEST1.ADOT1.Active:=true;
   HODTEST1.ADOT2.Filtered:=false;
   HODTEST1.ADOT2.Active:=true;
   HODTEST1.ADOT1.Append;
   HODTEST1.ADOT1.FieldValues['DATETIME']:=Date+Time;
   HODTEST1.ADOT1.FieldValues['CODECARD']:='Connect G';;
   HODTEST1.ADOT1.Post;
   HODTEST1.TrayIcon1.visible:=true;
   HODTEST1.trayicon1.balloontitle:=('*****ХодТест*****');
   HODTEST1.trayicon1.balloonhint:=Datetostr(Date)+' '+Timetostr(Time)+#13+'СВЯЗЬ С БАЗОЙ УСТАНОВЛЕННА';
   HODTEST1.trayicon1.showballoonHint;
   ShowMessage(Datetostr(Date)+' '+Timetostr(Time)+#13+'СВЯЗЬ С БАЗОЙ УСТАНОВЛЕННА');
   HODTEST1.timer1.Enabled:=true;
except
   HODTEST1.timer1.Enabled:=false;
   sleep(60000);
   Connect;

end;
end;

function BinToInt(Value: string): Integer;
var
  i, iValueSize: Integer;
begin
  Result := 0;
  iValueSize := Length(Value);
  for i := iValueSize downto 1 do
    if Value[i] = '1' then Result := Result + (1 shl (iValueSize - i));
end;

function ByteToBinStr(a_bByte: byte): string;
var
 i: integer;
begin
 SetLength(Result, 8);
 for i := 8 downto 1 do
 begin
   Result[i] := chr($30 + (a_bByte and 1));
   a_bByte := a_bByte shr 1;
 end;
 end;


procedure THODTEST1.FormActivate(Sender: TObject);
Const

  FBuf7: array [1..7] of Byte=($DA,$03,$01,$60,$00,$07,$BF);
  FBuf8: array [1..8] of Byte=($DA,$04,$07,$11,$11,$22,$22,$D9);
begin
   ComPort1.Open;

//Убираем с панели задач
   ShowWindow(Handle,SW_HIDE);  // Скрываем программу
   ShowWindow(Application.Handle,SW_HIDE);  // Скрываем кнопку с TaskBar'а
   SetWindowLong(Application.Handle, GWL_EXSTYLE,
   GetWindowLong(Application.Handle, GWL_EXSTYLE) or (not WS_EX_APPWINDOW));
 ComPort1.Write(FBuf7,7);
   sleep(500);
   ComPort1.Read(RBuf,12);
   ComPort1.Write(FBuf8,8);
   sleep(500);
   ComPort1.Read(RBuf,12);
   ComPort1.Write(FBufRC,27);
   sleep(500);
   ComPort1.Read(RBuf,12);
   ComPort1.Write(FBufD,7);
   sleep(500);
   ComPort1.Read(RBuf,12);
   HBufD[1]:=RBuf[8];
   HBufD[2]:=RBuf[9];
   ComPort1.Write(FBufC,7);
   sleep(500);
   ComPort1.Read(RBuf,20);
   HBuf[1]:=RBuf[12];
   HBuf[2]:=RBuf[11];
   HBuf[3]:=RBuf[10];
   HBuf[4]:=RBuf[9];
   HBuf[5]:=RBuf[20];
   Connect;
   TrayIcon1.visible:=true;
//Убираем с панели задач
   ShowWindow(Handle,SW_HIDE);  // Скрываем программу
   ShowWindow(Application.Handle,SW_HIDE);  // Скрываем кнопку с TaskBar'а
   SetWindowLong(Application.Handle, GWL_EXSTYLE,
   GetWindowLong(Application.Handle, GWL_EXSTYLE) or (not WS_EX_APPWINDOW));
end;

procedure THODTEST1.N1Click(Sender: TObject);
begin
Timer1.Enabled:=false;
ComPort1.Close;
ADOC.Connected:=false;
HodTest1.Close;
end;

procedure THODTEST1.Timer1Timer(Sender: TObject);
var
  Card:string;
begin
  ComPort1.Write(FBufC,7);
  sleep(500);
  ComPort1.Read(RBuf,20);
  if  (HBuf[2]<>RBuf[11])or(HBuf[4]<>RBuf[9])or(HBuf[3]<>RBuf[10])or(HBuf[1]<>RBuf[12])or(HBuf[5]<>RBuf[20])then
    begin
     HBuf[1]:=RBuf[12];
     HBuf[2]:=RBuf[11];
     HBuf[3]:=RBuf[10];
     HBuf[4]:=RBuf[9];
     HBuf[5]:=RBuf[20];
     Card:=inttostr(bintoint(ByteToBinStr(HBuf[1])+ByteToBinStr(HBuf[2])+ByteToBinStr(HBuf[3])+ByteToBinStr(HBuf[4])));
     try
     ADOT1.Append;
     ADOT1.FieldValues['DATETIME']:=Date+Time;
     ADOT1.FieldValues['CODECARD']:=Card;;
     ADOT1.Post;
     ADOT2.Filtered:=false;
     ADOT2.Filter:='CODECARD='+Card +'';
     ADOT2.Filtered:=True;
     ADOT2.First;
     if ADOT2.RecordCount>0 then
        begin
          TrayIcon1.visible:=true;
          trayicon1.balloontitle:=('*****ХодТест*****');
          trayicon1.balloonhint:=(Datetostr(Date)+' '+Timetostr(Time)+#13+'ЗОНА КОНТРОЛЯ:'+#13+ADOT2.FieldValues['NAMECARD']+#13+'ПРОЙДЕНО');
          trayicon1.showballoonHint;
          ShowMessage(Datetostr(Date)+' '+Timetostr(Time)+#13+'ЗОНА КОНТРОЛЯ:'+#13+ADOT2.FieldValues['NAMECARD']+#13+'ПРОЙДЕНА');
        end
     else
        begin
          TrayIcon1.visible:=true;
          trayicon1.balloontitle:=('*****ХодТест*****');
          trayicon1.balloonhint:=Datetostr(Date)+' '+Timetostr(Time)+#13+'Считывателем карт ХОДТЕСТА была считына карта: '+Card+'.'+#13+'ДАННАЯ КАРТА НЕ НАЙДЕНА В БАЗЕ';
          trayicon1.showballoonHint;
          ShowMessage(Datetostr(Date)+' '+Timetostr(Time)+#13+'Считывателем карт ХОДТЕСТА была считына карта: '+Card+'.'+#13+'ДАННАЯ КАРТА НЕ НАЙДЕНА В БАЗЕ');
        end;
      except
       TrayIcon1.visible:=true;
       trayicon1.balloontitle:=('*****ХодТест*****');
       trayicon1.balloonhint:=Datetostr(Date)+' '+Timetostr(Time)+#13+'ОШИБКА'+#13+'ПОТЕРЯНА СВЯЗЬ С БАЗОЙ'+#13+'ДАННЫЕ НЕ БУДУТ СОХРАНЕНЫ';
       trayicon1.showballoonHint;
       ShowMessage(Datetostr(Date)+' '+Timetostr(Time)+#13+'ОШИБКА'+#13+'ПОТЕРЯНА СВЯЗЬ С БАЗОЙ'+#13+'ДАННЫЕ НЕ БУДУТ СОХРАНЕНЫ');
       Connect;
       timer1.Enabled:=false;
     end;

end;
end;
procedure THODTEST1.TrayIcon1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Popupmenu1.Popup(X,Y);
end;

end.
