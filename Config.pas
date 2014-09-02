unit Config;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TFmConfig = class(TForm)
    EdUrnas: TEdit;
    Label1: TLabel;
    UdUrnas: TUpDown;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmConfig: TFmConfig;

implementation

{$R *.dfm}

procedure TFmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
