program Eleicao;

uses
  Vcl.Forms,
  Princ in 'Princ.pas' {FmPrinc},
  Config in 'Config.pas' {FmConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmPrinc, FmPrinc);
  Application.Run;
end.
