program HodTest;

uses
  Vcl.Forms,
  HOD in 'HOD.pas' {HODTEST1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THODTEST1, HODTEST1);
  Application.Run;
end.
