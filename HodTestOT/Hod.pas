unit Hod;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB, Data.Win.ADODB,ShellApi;

type
  TForm8 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label3: TLabel;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    ADOC: TADOConnection;
    ADOT1: TADOTable;
    ADOT2: TADOTable;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

procedure TForm8.Button1Click(Sender: TObject);
var HTMLStr:TStringList;
i:integer;
DT:TdateTime;
begin

ProgressBar1.Position :=0;
//DT:=DateTimePicker1.Date+DateTimePicker3.Time;
//DateTimePicker1.Time:=DateTimePicker3.Time;
adot1.Filtered:=false;

adot1.Filter:='DATETIME > '+Datetostr(DateTimePicker1.Date)+' AND DATETIME <= '+Datetostr(DateTimePicker2.Date+1)+'' ;
adot1.Filtered:=true;
ProgressBar1.Max:=adot1.RecordCount;
HTMLStr:=TstringList.Create;
HTMLStr.Clear;
HTMLStr.Add('<HTML>');
HTMLStr.Add('<HEAD>');
HTMLStr.Add('<TITLE>'+'�������'+'</TITLE>');
HTMLStr.Add(' <style>');

HTMLStr.Add('   H1 {');
HTMLStr.Add('    font-family: Verdana, Arial, Helvetica, sans-serif;');
HTMLStr.Add('    font-size: 12pt;');
HTMLStr.Add('    font-weight: 	bolder ;');
HTMLStr.Add('line-height: 0.5em;');
HTMLStr.Add('   }');

HTMLStr.Add('   H2 {');
HTMLStr.Add('    font-family: Verdana, Arial, Helvetica, sans-serif;');
HTMLStr.Add('    font-size: 24pt;');
HTMLStr.Add('    font-weight: 	bolder ;');
HTMLStr.Add('line-height: 0.5em;');
HTMLStr.Add('   }');

HTMLStr.Add('   H3 {');
HTMLStr.Add('    font-family: Verdana, Arial, Helvetica, sans-serif;');
HTMLStr.Add('    font-style: 	italic ;');
HTMLStr.Add('    font-size: 9pt;');
HTMLStr.Add('line-height: 0.5em;');
HTMLStr.Add('    font-weight: 	normal ;');
HTMLStr.Add('   }');

HTMLStr.Add('   H4 {');
HTMLStr.Add('    font-family: Verdana, Arial, Helvetica, sans-serif;');
HTMLStr.Add('    font-size: 12pt;');
HTMLStr.Add('line-height: 0.5em;');
HTMLStr.Add('    font-weight: 	normal ;');
HTMLStr.Add('   }');

HTMLStr.Add('   H5 {');
HTMLStr.Add('    font-family: Verdana, Arial, Helvetica, sans-serif;');
HTMLStr.Add('    font-size: 12pt;');
HTMLStr.Add('line-height: 0.5em;');
HTMLStr.Add('    font-weight: 	bolder ;');
HTMLStr.Add('   }');

HTMLStr.Add('hr {');
//HTMLStr.Add('    border: none; /* ������� ������� */');
HTMLStr.Add('    background-color: black; /* ���� ����� */');
HTMLStr.Add('    color: black; /* ���� ����� ��� IE6-7 */');
HTMLStr.Add('   height: 2px; /* ������� ����� */ ');
HTMLStr.Add('   } ');

HTMLStr.Add('hr2 {');
//HTMLStr.Add('    border: none; /* ������� ������� */');
HTMLStr.Add('    background-color: black; /* ���� ����� */');
HTMLStr.Add('    color: black; /* ���� ����� ��� IE6-7 */');
HTMLStr.Add('   height: 20px; /* ������� ����� */ ');
HTMLStr.Add('   } ');

HTMLStr.Add(' table {');
HTMLStr.Add('     width: 300px; /* ������ ������� */ ');
HTMLStr.Add('     border: 1px solid Black; /* ����� ������ ������� */');
HTMLStr.Add('     margin: auto; /* ����������� ������� �� ������ ����  */ ');
HTMLStr.Add('    } ');

HTMLStr.Add('  </style>');
HTMLStr.Add('</HEAD>');


HTMLStr.Add('<BODY BGCOLOR="#FFFFEE">');
HTMLStr.Add('<H1><CENTER> �������� � ������������ ���������������� </CENTER></H1>');
HTMLStr.Add('<H2><CENTER> "��� ���" </CENTER></H2>');
HTMLStr.Add('<hr>') ;
HTMLStr.Add('</hr>') ;
HTMLStr.Add('<H3><CENTER> (��� ������ 33514978)  </CENTER></H3>');
HTMLStr.Add('<H3><CENTER> 19700, �������, ���������� ���., �. ���������� ��. ��������, 235, �. </CENTER></H3>');
HTMLStr.Add('<H3><CENTER> ���.: (04737) 2-92-03, ����: (04737) 5-20-77 </CENTER></H3>');
HTMLStr.Add('<hr>') ;
HTMLStr.Add('</hr>') ;
HTMLStr.Add('<hr>') ;
HTMLStr.Add('</hr>') ;
HTMLStr.Add('<H1><CENTER>  </CENTER></H1>');
HTMLStr.Add('<H1><CENTER>  </CENTER></H1>');
HTMLStr.Add('<H4><CENTER> ��ר�: </CENTER></H4>');
HTMLStr.Add('<H2><CENTER> "�������" </CENTER></H2>');

HTMLStr.Add('<H3>������ ������:'+Datetostr(DateTimePicker1.Date)+' - '+Datetostr(DateTimePicker2.Date)+'</H3>');

HTMLStr.Add('<table border>');

HTMLStr.Add('<tr>');
HTMLStr.Add('<H5><th> ��� </th></H5>');
HTMLStr.Add('<H5><th> ����/����� </th></H5>');
HTMLStr.Add('<H5><th> ���� ������ </th></H5>');
HTMLStr.Add('</tr>');
ADOT1.Sort:='DATETIME';
ADOT1.First;
i:=1;
while not ADOT1.Eof do begin
       try
        ADOT2.Filtered:=false;
        ADOT2.Filter:='CODECARD = '+ADOT1.FieldValues['CODECARD'];
        ADOT2.Filtered:=true;
        ProgressBar1.Position:=ADOT1.RecNo;
        if ADOT2.RecordCount>0 then begin
           HTMLStr.Add('<tr>');
           HTMLStr.Add('<td>'+inttostr(i)+'</td>');
           HTMLStr.Add('<td>'+Datetostr(ADOT1.FieldValues['DATETIME'])+' '+Timetostr(ADOT1.FieldValues['DATETIME'])+'</td>');

           HTMLStr.Add('<td>'+ADOT2.FieldValues['NAMECARD']+'</td>');
           HTMLStr.Add('</tr>');
           i:=i+1;
        end;
        except

       end;
         //for i:=0 to ADOT1.FieldCount-1 do
        //if ADOT1.Fields[i].DisplayText='' then
        //HTMLStr.Add('<td>'+'___'+'/<td>')
       // else HTMLStr.Add('<td>'+ADOT1.Fields[i].DisplayText+'</td>');
      // HTMLStr.Add('<td>'+inttostr(i)+'</td>');
       //HTMLStr.Add('<td>'+Datetostr(ADOT1.FieldValues['DATETIME'])+'</td>');

ADOT1.Next;
end;

HTMLStr.Add('</TABLE>');
HTMLStr.Add('</BODY>');
HTMLStr.Add('</HTML>');

HTMLStr.SaveToFile('HTML.html');
HTMLStr.Free;

ShellExecute(Handle, 'open', pchar('HTML.html'), '', '', sw_ShowNormal);
end;

procedure TForm8.FormActivate(Sender: TObject);
begin
DateTimePicker1.Date:=date;
DateTimePicker2.Date:=date;
end;

end.
