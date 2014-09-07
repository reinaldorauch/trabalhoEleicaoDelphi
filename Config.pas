unit Config;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, IniFiles;

type
  TFmConfig = class(TForm)
    EdUrnas: TEdit;
    Label1: TLabel;
    UdUrnas: TUpDown;
    Label2: TLabel;
    EdCand1: TEdit;
    Label3: TLabel;
    CbCand1: TColorBox;
    CbCand2: TColorBox;
    Cor: TLabel;
    EdCand2: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    CbBrancos: TColorBox;
    CbNulos: TColorBox;
    Nulos: TLabel;
    Label6: TLabel;
    EdFileDir: TEdit;
    BtnSalvar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdFileDirChange(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmConfig: TFmConfig;
  IniConfig: TIniFile;

implementation

uses Princ;

{$R *.dfm}

procedure TFmConfig.BtnSalvarClick(Sender: TObject);
begin
  with IniConfig do
  begin
    WriteString(INI_E_SECTION, INI_E_FILEPATH, EdFileDir.Text);
    WriteInteger(INI_E_SECTION, INI_E_QTDSECOES, StrToInt(EdUrnas.Text));
    WriteString(INI_E_SECTION, INI_E_CAND1, EdCand1.Text);
    WriteString(INI_E_SECTION, INI_E_CAND2, EdCand2.Text);
    WriteInteger(INI_E_SECTION, INI_E_CAND1COLOR, CbCand1.Selected);
    WriteInteger(INI_E_SECTION, INI_E_CAND2COLOR, CbCand2.Selected);
    WriteInteger(INI_E_SECTION, INI_E_BRANCOSCOLOR, CbBrancos.Selected);
    WriteInteger(INI_E_SECTION, INI_E_NULOSCOLOR, CbNulos.Selected);
    UpdateFile;
  end;

  if NOT (Sender is TFmConfig) then
    Self.Close;
end;

procedure TFmConfig.EdFileDirChange(Sender: TObject);
begin
  if(DirectoryExists(EdFileDir.Text)) then
    EdFileDir.Color := clWindow
  else
    EdFileDir.Color := clYellow;
end;

procedure TFmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BtnSalvarClick(Sender);
  Action := caFree;
end;

procedure TFmConfig.FormCreate(Sender: TObject);
begin
  with Princ.IniConfig do
  begin
    EdFileDir.Text := ReadString(INI_E_SECTION, INI_E_FILEPATH, 'C:\');
    EdUrnas.Text := IntToStr(ReadInteger(INI_E_SECTION, INI_E_QTDSECOES, 80));
    EdCand1.Text := ReadString(INI_E_SECTION, INI_E_CAND1, '');
    EdCand2.Text := ReadString(INI_E_SECTION, INI_E_CAND2, '');
    CbCand1.Selected := ReadInteger(INI_E_SECTION, INI_E_CAND1COLOR, clBlack);
    CbCand2.Selected := ReadInteger(INI_E_SECTION, INI_E_CAND2COLOR, clBlack);
    CbBrancos.Selected := ReadInteger(INI_E_SECTION, INI_E_BRANCOSCOLOR, clBlack);
    CbNulos.Selected := ReadInteger(INI_E_SECTION, INI_E_NULOSCOLOR, clBlack);
  end;
end;

end.
