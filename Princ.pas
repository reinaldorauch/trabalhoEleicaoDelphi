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
    ChValidos: TChart;
    PnSecao: TPanel;
    ClbSecao: TCheckListBox;
    Series2: TBarSeries;
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
    BtnPausa: TButton;
    Series3: TBarSeries;
    TsLog: TTabSheet;
    LvLog: TListView;
    AcCleanLog: TAction;
    LimparLog1: TMenuItem;
    LimparLog2: TMenuItem;
    procedure AcAbrirConfigExecute(Sender: TObject);
    procedure AcProgExitExecute(Sender: TObject);
    procedure AcUpdateExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateDataArray;
    procedure UpdateInterface(Init: Boolean);
    function GetLineData(F,Line: String): Word;
    function GetFileName(Name: String): String;   
    function GetRecordIndex(Rec: TRegSecoes): Word;
    function GetSecaoIndex(Secao: String): Integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CalculateSums(Init: Boolean);
    procedure UpdateGeral(Series: TChartSeries; C1, C2, B, N: Word);
    procedure UpdateValidos(Series: TChartSeries; C1, C2: Word);
    procedure UpdateSecao(Init: Boolean);
    procedure BtnPausaClick(Sender: TObject);
    procedure UpdateGauge(Init: Boolean);
    procedure ClbSecaoClickCheck(Sender: TObject);
    procedure AddToLog(Messsage: String);
    procedure AcCleanLogExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmPrinc: TFmPrinc;
  ArraySecoes: Array of TRegSecoes;
  IniConfig: TIniFile;
  IniUpdate: Boolean = false;

const
  INI_NAME           = 'eleicao.ini';
  INI_E_SECTION      = 'Eleicao';
  INI_E_FILEPATH     = 'fileDir';
  INI_E_CAND1        = 'cand1';
  INI_E_CAND1COLOR   = 'cand1Color';
  INI_E_CAND2        = 'cand2';
  INI_E_CAND2COLOR   = 'cand2Color';
  INI_E_BRANCOS      = 'brancos';
  INI_E_BRANCOSCOLOR = 'brancosColor';
  INI_E_NULOS        = 'nulos';
  INI_E_NULOSCOLOR   = 'nulosColor';
  INI_E_QTDSECOES    = 'qtdSecoes';
  INI_I_SECTION      = 'Interface';
  INI_I_POSX         = 'posX';
  INI_I_POSY         = 'posY';

implementation

{$R *.dfm}

uses Config;

procedure TFmPrinc.AcAbrirConfigExecute(Sender: TObject);
var
  FormConfig: TForm;
begin
  Timer.Enabled := False;
  FormConfig := TFmConfig.Create(Self);
  Config.IniConfig := IniConfig;
  FormCOnfig.ShowModal;
  Timer.Enabled := True;
  IniUpdate := True;
  AcUpdateExecute(Sender);
end;

procedure TFmPrinc.AcCleanLogExecute(Sender: TObject);
begin
  LvLog.Items.Clear;
end;

procedure TFmPrinc.AcProgExitExecute(Sender: TObject);
begin
   Self.Close;
end;

procedure TFmPrinc.AcUpdateExecute(Sender: TObject);
begin
  // Atualiza os dados de acordo com os arquivos na pasta
  UpdateDataArray;
  UpdateInterface((Sender is TFmPrinc) OR IniUpdate);
  IniUpdate := False;
end;

procedure TFmPrinc.AddToLog(Messsage: String);
begin
  with LvLog.Items.Add do
  begin
    Caption := DateTimeToStr(Now());
    SubItems.Add(Messsage);
  end;
end;

procedure TFmPrinc.BtnPausaClick(Sender: TObject);
begin
  if Timer.Enabled then
    begin
      Timer.Enabled := False;
      BtnPausa.Caption := 'Resumir';
    end
  else
    begin
      Timer.Enabled := True;
      BtnPausa.Caption := 'Pausar';
    end;
end;

procedure TFmPrinc.CalculateSums(Init: Boolean);
var
  I, Cand1, Cand2, Brancos, Nulos: Word;
begin

  Cand1 := 0;
  Cand2 := 0;
  Brancos := 0;
  Nulos := 0;

  if(Length(ArraySecoes) > 0) then
    begin
      for I := 0 to Length(ArraySecoes) - 1 do
        begin
          inc(Cand1, ArraySecoes[i].Cand1);
          inc(Cand2, ArraySecoes[i].Cand2);
          inc(Brancos, ArraySecoes[i].Brancos);
          inc(Nulos, ArraySecoes[i].Nulos);
        end;
    end;

  if Init OR (Length(ArraySecoes) > 0) then
  begin
    UpdateGeral(ChGeral.Series[0], Cand1, Cand2, Brancos, Nulos);
    UpdateValidos(ChValidos.Series[0], Cand1, Cand2);
  end;

end;

procedure TFmPrinc.ClbSecaoClickCheck(Sender: TObject);
begin
  UpdateSecao(False);
end;

procedure TFmPrinc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IniConfig.WriteInteger(INI_I_SECTION, INI_I_POSX, Left);
  IniConfig.WriteInteger(INI_I_SECTION, INI_I_POSY, Top);
  IniConfig.UpdateFile;
end;

procedure TFmPrinc.FormCreate(Sender: TObject);
var FormConfig: TFmConfig;
begin
  IniConfig := TIniFile.Create(GetCurrentDir + '\' + INI_NAME);

  if NOT IniConfig.SectionExists(INI_E_SECTION) then
    AcAbrirConfigExecute(Sender);

  Top := IniConfig.ReadInteger(INI_I_SECTION, INI_I_POSY, Top);
  Left := IniConfig.ReadInteger(INI_I_SECTION, INI_I_POSX, Left);
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

function TFmPrinc.GetLineData(F,Line: String): Word;
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('^' + F + '\s*=(\d+).*$');
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

function TFmPrinc.GetSecaoIndex(Secao: String): Integer;
var
  I: Integer;
begin
  i := 0;
  while (i < Length(ArraySecoes)) AND (ArraySecoes[i].Nome <> Secao) do
    inc(i);

  if(i = Length(ArraySecoes)) then
    Result := -1
  else
    Result := i;
end;

procedure TFmPrinc.UpdateGeral(Series: TChartSeries; C1, C2, B, N: Word);
begin
  with Series do
  begin
    Clear;

    Add(
      C1,
      IniConfig.ReadString(INI_E_SECTION, INI_E_CAND1, 'Cand1'),
      TColor(IniConfig.ReadInteger(INI_E_SECTION, INI_E_CAND1COLOR, clBlack))
    );

    Add(
      C2,
      IniConfig.ReadString(INI_E_SECTION, INI_E_CAND2, 'Cand2'),
      TColor(IniConfig.ReadInteger(INI_E_SECTION, INI_E_CAND2COLOR, clWhite))
    );

    Add(
      B,
      IniConfig.ReadString(INI_E_SECTION, INI_E_BRANCOS, 'Brancos'),
      TColor(IniConfig.ReadInteger(INI_E_SECTION, INI_E_BRANCOSCOLOR, clBlack))
    );

    Add(
      N,
      IniConfig.ReadString(INI_E_SECTION, INI_E_NULOS, 'Nulos'),
      TColor(IniConfig.ReadInteger(INI_E_SECTION, INI_E_NULOSCOLOR, clWhite))
    );

  end;
end;

procedure TFmPrinc.UpdateDataArray;
var
  FileDir, FilePath, Line: String;
  FilePointer: TextFile;
  NewRecord: TRegSecoes;
  Dir: TSearchRec;
  I: Integer;
  Found: Boolean;
begin
  // Varre o diretório definido no INI e pega o primeiro arquivo novo
  // para atualizar o array de dados
  if (IniConfig is TIniFile) then
  begin
    FileDir := IniConfig.ReadString(
      INI_E_SECTION, 
      INI_E_FILEPATH,
      GetCurrentDir
    );
    
    FilePath := FileDir + '\*.txt';
    
    if(FindFirst(FilePath, faArchive, Dir) = 0) then
    try    
      AssignFile(FilePointer, FileDir + '\' + Dir.Name);
      Reset(FilePointer);

      NewRecord.Nome := LowerCase(GetFileName(Dir.Name));

      Readln(FilePointer, Line); // Linha 1
      NewRecord.Cand1 := GetLineData('votos 1', Line);

      Readln(FilePointer, Line); // Linha 2
      NewRecord.Cand2 := GetLineData('votos 2', Line);

      Readln(FilePointer, Line); // Linha 3
      NewRecord.Brancos := GetLineData('brancos', Line);

      Readln(FilePointer, Line); // Linha 4
      NewRecord.Nulos := GetLineData('nulos', Line);

      ArraySecoes[GetRecordIndex(NewRecord)] := NewRecord;

      CloseFile(FilePointer);
      DeleteFile(FileDir + '\' + Dir.Name);

      if(ClbSecao.Items.IndexOf(NewRecord.Nome) = -1) then
        ClbSecao.Items.Add(NewRecord.Nome);

      AddToLog('Arquivo: ' + Dir.Name + ' lido com sucesso');
    except
      // Criar logger
      AddToLog('Erro ao ler o arquivo:' + Dir.Name);
      CloseFile(FilePointer);
      DeleteFile(FileDir + '\' + Dir.Name);    
    end;
  end
  else
    ShowMessage('Erro na abertura do arquivo ini');

end;

procedure TFmPrinc.UpdateGauge(Init: Boolean);
begin
  if Init then
    Gauge.MaxValue := IniConfig.ReadInteger(INI_E_SECTION, INI_E_QTDSECOES, 100);

  Gauge.Progress := Length(ArraySecoes);
end;

procedure TFmPrinc.UpdateInterface(Init: Boolean);
begin
  CalculateSums(Init);
  UpdateSecao(Init);
  UpdateGauge(Init);
end;

procedure TFmPrinc.UpdateSecao(Init: Boolean);
var
  i: integer;
  Atual: TRegSecoes;
begin
  with ChSecao do
  begin
    Series[0].Clear;
    Series[1].Clear;

    if Init then
    begin
      Series[0].Title := IniConfig.ReadString(INI_E_SECTION, INI_E_CAND1, 'cand1');
      Series[1].Title := IniConfig.ReadString(INI_E_SECTION, INI_E_CAND2, 'cand2');
    end;

    with ClbSecao do
      for I := 0 to GetCount - 1 do
        if(Checked[i]) then
          begin
            Atual := ArraySecoes[GetSecaoIndex(ClbSecao.Items[i])];

            Series[0].Add(
              Atual.Cand1,
              Atual.Nome,
              IniConfig.ReadInteger(INI_E_SECTION, INI_E_CAND1COLOR, clRed)
            );

            Series[1].Add(
              Atual.Cand2,
              Atual.Nome,
              IniConfig.ReadInteger(INI_E_SECTION, INI_E_CAND2COLOR, clBlue)
            );
          end;
  end;

end;

procedure TFmPrinc.UpdateValidos(Series: TChartSeries; C1, C2: Word);
begin
  with Series do
  begin
    Clear;

    Add(
      C1,
      IniConfig.ReadString(INI_E_SECTION, INI_E_CAND1, 'Cand1'),
      IniConfig.ReadInteger(INI_E_SECTION, INI_E_CAND1COLOR, clBlack)
    );

    Add(
      C2,
      IniConfig.ReadString(INI_E_SECTION, INI_E_CAND2, 'Cand2'),
      IniConfig.ReadInteger(INI_E_SECTION, INI_E_CAND2COLOR, clWhite)
    );
  end;

end;

end.
