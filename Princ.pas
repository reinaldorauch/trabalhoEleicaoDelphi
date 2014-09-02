unit Princ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls, Vcl.Samples.Gauges, VCLTee.TeEngine,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series, Vcl.CheckLst,
  System.Actions, Vcl.ActnList, Inifiles, RegularExpressions;

type
  TRegSecoes = Record
    Nome: String;
    Cand1,
    Cand2,
    Brancos,
    Nulos : Word;
  End;

  EInvalidFile = class(Exception);
  
  TFmPrinc = class(TForm)
    MainMenu: TMainMenu;
    Opes1: TMenuItem;
    Gauge: TGauge;
    Label1: TLabel;
    PopupMenu: TPopupMenu;
    ChGeral: TChart;
    Series1: TBarSeries;
    PageControlMain: TPageControl;
    TsGeral: TTabSheet;
    TsSecao: TTabSheet;
    ChSecao: TChart;
    TsValidos: TTabSheet;
    Chart2: TChart;
    PnSecao: TPanel;
    ClbSecao: TCheckListBox;
    Series2: TBarSeries;
    Series3: TBarSeries;
    Series4: TBarSeries;
    Series5: TPieSeries;
    ActionList: TActionList;
    AcAbrirConfig: TAction;
    AcAbrirConfig1: TMenuItem;
    AcAbrirConfig2: TMenuItem;
    AcProgExit: TAction;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Timer: TTimer;
    AcUpdate: TAction;
    Atualizar1: TMenuItem;
    Atualizar2: TMenuItem;
    procedure AcAbrirConfigExecute(Sender: TObject);
    procedure AcProgExitExecute(Sender: TObject);
    procedure AcUpdateExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateDataArray;
    procedure UpdateInterface;
    function GetLineData(Line: String): Word;
    function GetFileName(Name: String): String;   
    function GetRecordIndex(Rec: TRegSecoes): Word;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdateIniDependant;
    procedure CalculateSums;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmPrinc: TFmPrinc;
  ArraySecoes: Array of TRegSecoes;
  IniConfig: TIniFile;
  IniUpdate: Boolean = true;

const
  INI_NAME = 'eleicao.ini';
  INI_ELEICAO_SECTION = 'Eleicao';
  INI_ELEICAO_FILEPATH = 'fileDir';
  INI_ELEICAO_CAND1 = 'cand1';
  INI_ELEICAO_CAND1COLOR = 'cand1Color';
  INI_ELEICAO_CAND2 = 'cand2';
  INI_ELEICAO_CAND2COLOR = 'cand2Color';
  INI_ELEICAO_BRANCOS = 'brancos';
  INI_ELEICAO_BRANCOSCOLOR = 'brancosColor';
  INI_ELEICAO_NULOS = 'nulos';
  INI_ELEICAO_NULOSCOLOR = 'nulosColor';
  INI_INTERFACE_SECTION = 'Interface';
  INI_INTERFACE_POSX = 'posX';
  INI_INTERFACE_POSY = 'posY';

implementation

{$R *.dfm}

uses Config;

procedure TFmPrinc.AcAbrirConfigExecute(Sender: TObject);
var
  FormConfig: TForm;
begin
  // Passar a referência do INI para o form de config
  FormConfig := TFmConfig.Create(Self);

  FormCOnfig.ShowModal;
end;

procedure TFmPrinc.AcProgExitExecute(Sender: TObject);
begin
   Self.Close;
end;

procedure TFmPrinc.AcUpdateExecute(Sender: TObject);
begin
  // Atualiza os dados de acordo com os arquivos na pasta
  UpdateDataArray;
  UpdateInterface;
  IniUpdate := False;
end;

procedure TFmPrinc.CalculateSums;
var
  I, Cand1, Cand2, Brancos, Nulos: Word;
begin
  if(Length(ArraySecoes) > 0) then
    with ChGeral.Series[0] do
    begin

      Clear;

      Cand1 := 0;
      Cand2 := 0;
      Brancos := 0;
      Nulos := 0;

      for I := 0 to Length(ArraySecoes) - 1 do
        begin
          inc(Cand1, ArraySecoes[i].Cand1);
          inc(Cand2, ArraySecoes[i].Cand2);
          inc(Brancos, ArraySecoes[i].Brancos);
          inc(Nulos, ArraySecoes[i].Nulos);
        end;

      Add(
        Cand1,
        IniConfig.ReadString(INI_ELEICAO_SECTION, INI_ELEICAO_CAND1, 'Cand1'),
        IniConfig.ReadInteger(INI_ELEICAO_SECTION, INI_ELEICAO_CAND1COLOR, clBlack)
      );

      Add(
        Cand2,
        IniConfig.ReadString(INI_ELEICAO_SECTION, INI_ELEICAO_CAND2, 'Cand2'),
        IniConfig.ReadInteger(INI_ELEICAO_SECTION, INI_ELEICAO_CAND2COLOR, clBlack)
      );

      Add(
        Brancos,
        IniConfig.ReadString(INI_ELEICAO_SECTION, INI_ELEICAO_BRANCOS, 'Brancos'),
        IniConfig.ReadInteger(INI_ELEICAO_SECTION, INI_ELEICAO_BRANCOSCOLOR, clBlack)
      );

      Add(
        Nulos,
        IniConfig.ReadString(INI_ELEICAO_SECTION, INI_ELEICAO_NULOS, 'Nulos'),
        IniConfig.ReadInteger(INI_ELEICAO_SECTION, INI_ELEICAO_NULOSCOLOR, clBlack)
      );

    end;
end;

procedure TFmPrinc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IniConfig.WriteInteger(INI_INTERFACE_SECTION, INI_INTERFACE_POSX, Left);
  IniConfig.WriteInteger(INI_INTERFACE_SECTION, INI_INTERFACE_POSY, Top);
  IniConfig.UpdateFile;
end;

procedure TFmPrinc.FormCreate(Sender: TObject);
begin
  IniConfig := TIniFile.Create(GetCurrentDir + '\' + INI_NAME);
  Top := IniConfig.ReadInteger(INI_INTERFACE_SECTION, INI_INTERFACE_POSY, Top);
  Left := IniConfig.ReadInteger(INI_INTERFACE_SECTION, INI_INTERFACE_POSX, Left);
  AcUpdateExecute(Sender);
end;

function TFmPrinc.GetFileName(Name: String): String;
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('^(.*)\.txt$');

  Match := Regex.Match(Name);

  if Match.Success then
    Result := Match.Groups.Item[1].Value
  else
    EInvalidFile.Create('');
end;

function TFmPrinc.GetLineData(Line: String): Word;
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('^.*=(\d+).*$');
  Match := Regex.Match(Line);

  if Match.Success then
    Result := StrToInt(Match.Groups.Item[1].Value)
  else
    raise EInvalidFile.Create('');
end;

function TFmPrinc.GetRecordIndex(Rec: TRegSecoes): Word;
var
  I: Integer;
begin
  I := 0;

  while (i < Length(ArraySecoes)) AND (ArraySecoes[i].Nome <> Rec.Nome) do
    inc(I);

  if(I = Length(ArraySecoes)) then
    SetLength(ArraySecoes, Length(ArraySecoes) + 1);
    
  Result := I;
end;

procedure TFmPrinc.UpdateDataArray;
var
  FileDir, FilePath, Line: String;
  FilePointer: TextFile;
  NewRecord: TRegSecoes;
  Dir: TSearchRec;
begin
  // Varre o diretório definido no INI e pega o primeiro arquivo novo
  // para atualizar o array de dados
  if (IniConfig is TIniFile) then
  begin
    FileDir := IniConfig.ReadString(
      INI_ELEICAO_SECTION, 
      INI_ELEICAO_FILEPATH,
      GetCurrentDir
    );
    
    FilePath := FileDir + '\*.txt';
    
    if(FindFirst(FilePath, faArchive, Dir) = 0) then
    try    
      AssignFile(FilePointer, FileDir + '\' + Dir.Name);
      Reset(FilePointer);

      NewRecord.Nome := GetFileName(Dir.Name);

      Readln(FilePointer, Line); // Linha 1
      NewRecord.Cand1 := GetLineData(Line);

      Readln(FilePointer, Line); // Linha 2
      NewRecord.Cand2 := GetLineData(Line);

      Readln(FilePointer, Line); // Linha 3
      NewRecord.Brancos := GetLineData(Line);

      Readln(FilePointer, Line); // Linha 4
      NewRecord.Nulos := GetLineData(Line);

      ArraySecoes[GetRecordIndex(NewRecord)] := NewRecord;

      CloseFile(FilePointer);
      DeleteFile(FileDir + '\' + Dir.Name);    
    except
      // Criar logger
      ShowMessage('Arquivo inválido');
      CloseFile(FilePointer);
      DeleteFile(FileDir + '\' + Dir.Name);    
    end;
  end
  else
    ShowMessage('Erro na criação do arquivo ini');

end;

procedure TFmPrinc.UpdateIniDependant;
begin
  // Atualiza as informações que são dependentes do arquivo ini
end;

procedure TFmPrinc.UpdateInterface;
begin
  // Pega os dados no array de dados e atualiza a interface, juntamente com os
  // Dados definidos no INI para apresentação
  if IniUpdate then
    UpdateIniDependant;

  CalculateSums;
end;

end.
