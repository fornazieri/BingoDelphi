unit U_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, ACBrGIF, dxGDIPlusClasses, Vcl.Themes, Datasnap.DBClient;

type
  TF_Principal = class(TForm)
    pnlTitulo: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    spinMaximo: TSpinEdit;
    Panel3: TPanel;
    CDS_Sorteados: TClientDataSet;
    DS_Sorteados: TDataSource;
    CDS_SorteadosNUMERO: TIntegerField;
    Panel4: TPanel;
    Panel5: TPanel;
    DBGrid1: TDBGrid;
    btnReiniciar: TBitBtn;
    Panel6: TPanel;
    pnlNumero: TPanel;
    Panel8: TPanel;
    lblSorteados: TLabel;
    Panel9: TPanel;
    Panel10: TPanel;
    pnlPedra1: TPanel;
    imgPedra1: TImage;
    lblPedra1: TLabel;
    pnlPedra2: TPanel;
    imgPedra2: TImage;
    lblPedra2: TLabel;
    pnlPedra3: TPanel;
    imgPedra3: TImage;
    lblPedra3: TLabel;
    pnlPedra4: TPanel;
    imgPedra4: TImage;
    lblPedra4: TLabel;
    pnlPedra5: TPanel;
    imgPedra5: TImage;
    lblPedra5: TLabel;
    Timer1: TTimer;
    Panel11: TPanel;
    btnSortear: TBitBtn;
    pnlNumeroSorteado: TPanel;
    Timer2: TTimer;
    btnConfiguracoes: TBitBtn;
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnSortearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnReiniciarClick(Sender: TObject);
    procedure LimparCampos();
    procedure Timer2Timer(Sender: TObject);
    procedure btnConfiguracoesClick(Sender: TObject);
    procedure TratarTitulo();
  private
    { Private declarations }
  public
    { Public declarations }
    var
      vTitulo, vTema: String;
  end;

var
  F_Principal: TF_Principal;

implementation

{$R *.dfm}

uses U_Configuracoes;

procedure TF_Principal.btnSortearClick(Sender: TObject);
begin
  if btnSortear.Caption = 'Iniciar Jogo' then
  begin
    btnSortear.Caption := 'Sortear Numero';
  end;
  //ACBrGIF1.Active := True;
  pnlNumero.Font.Size := 30;
  pnlNumero.Caption := 'Gerando Numero';

  CDS_Sorteados.Last;
  if CDS_Sorteados.RecordCount = spinMaximo.Value then
  begin
    ShowMessage('Seu bingo ja chegou ao fim! Se ninguem foi sorteado, temos jogadores comendo bronha!!!');
    pnlNumero.Font.Size := 30;
    pnlNumero.Caption := 'Fim de jogo!!!';
    pnlNumeroSorteado.Caption := '';
    Abort;
  end;
  CDS_Sorteados.First;

  Timer2.Enabled := True;
  Timer1.Enabled := True;
end;

procedure TF_Principal.btnConfiguracoesClick(Sender: TObject);
var
  frmConfig : TF_Configuracoes;
  I : Integer;
begin

  frmConfig := TF_Configuracoes.Create(self);


  frmConfig.ComboBox1.Items.Clear;
  for I := 0 to Length(TStyleManager.StyleNames) -1 do
  begin
    frmConfig.ComboBox1.Items.Add(TStyleManager.StyleNames[I]);
  end;
  frmConfig.ComboBox1.ItemIndex := frmConfig.ComboBox1.Items.IndexOf(vTema);

  frmConfig.ShowModal;
  if (frmConfig.ModalResult = mrOk) then
  begin
    vTitulo := frmConfig.edtTitulo.Text;
    TratarTitulo;
  end;

  frmConfig.Free;
end;

procedure TF_Principal.btnReiniciarClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente reiniciar o jogo?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    LimparCampos;
  end;
end;

procedure TF_Principal.FormActivate(Sender: TObject);
begin
  //ACBrGIF1.Top  := (pnlAnimacao.ClientHeight - ACBrGIF1.Height) div 2;
  //ACBrGIF1.Left := (pnlAnimacao.ClientWidth - ACBrGIF1.Width) div 2;
end;

procedure TF_Principal.FormCreate(Sender: TObject);
begin
  LimparCampos;
  vTitulo := InputBox('T�tulo', 'Digite um t�tulo para seu jogo!', '');
  TratarTitulo;
  if Assigned(TStyleManager.ActiveStyle) then
    vTema := TStyleManager.ActiveStyle.Name;
end;

procedure TF_Principal.LimparCampos;
begin
  CDS_Sorteados.Close;
  CDS_Sorteados.CreateDataSet;
  pnlNumeroSorteado.Caption := '';
  lblSorteados.Visible := False;
  //ACBrGIF1.Active := False;
  lblPedra1.Caption := '';
  lblPedra2.Caption := '';
  lblPedra3.Caption := '';
  lblPedra4.Caption := '';
  lblPedra5.Caption := '';
  pnlNumero.Caption := '';
  pnlNumero.Font.Size := 150;
  btnSortear.Caption := 'Iniciar Jogo';
end;

procedure TF_Principal.Timer1Timer(Sender: TObject);
var
  vNumero : Integer;
  vFrase : String;
begin
  vFrase := '';
  Timer1.Enabled := False;

  vNumero := Random(spinMaximo.Value + 1);

  while (CDS_Sorteados.Locate('NUMERO', vNumero, []) or (vNumero = 0)) do
  begin
    vNumero := Random(spinMaximo.Value + 1);
  end;

  CDS_Sorteados.Insert;
  CDS_SorteadosNUMERO.AsInteger := vNumero;
  CDS_Sorteados.Post;
  CDS_Sorteados.First;

  case vNumero of
    1: vFrase := 'Inicio de jogo';
    2: vFrase := 'S� um patinho na lagoa';
    3: vFrase := 'O numero dos porquinhos';
    4: vFrase := 'Pernas da mesa';
    5: vFrase := 'Cachorro';
    6: vFrase := 'Pingo na pan�a, o 6 que avan�a. numero';
    7: vFrase := 'An�es da branca de neve';
    8: vFrase := 'Biscoito';
    9: vFrase := 'Pingo no p� nove �';
    10: vFrase := '*Raso* Craque de bola';
    11: vFrase := 'Casa de bronze, numero';
    12: vFrase := 'Uma duzia';
    13: vFrase := 'N�mero do azar';
    15: vFrase := 'Menina mo�a';
    18: vFrase := 'Maior de Idade';
    20: vFrase := '*Raso* Amigo ouvinte saiu o numero';
    22: vFrase := 'Dois patinhos na lagoa';
    23: vFrase := 'Quase alegre, meio alegra';
    24: vFrase := 'Numero do alegre';
    28: vFrase := 'Dias do m�s de fevereiro';
    30: vFrase := '*Raso* N�o minta, saiu';
    31: vFrase := 'Preparem os fogos, virada de ano';
    33: vFrase := 'A idade dele, idade de cristo';
    38: vFrase := 'Justi�a de goias revolver';
    40: vFrase := '*Raso*';
    44: vFrase := 'P�z�o';
    45: vFrase := 'Fim do primeiro tempo';
    50: vFrase := '*Raso* � penta, numero';
    51: vFrase := 'Uma boa ideia';
    55: vFrase := 'Dois cachorros do padre';
    60: vFrase := '*Raso* 60 para descansar numero';
    66: vFrase := 'Meia meia, s� falta o sapato';
    67: vFrase := 'Me acerte';
    69: vFrase := 'Um para cima outro para baixo';
    70: vFrase := '*Raso* 70 At� conseguir vc tenta numero';
    71: vFrase := 'A bruxa do';
    77: vFrase := 'Duas machadinhas';
    80: vFrase := '*Raso*';
    90: vFrase := '*Raso* A velha';
  end;

  if vNumero = spinMaximo.Value then
    vFrase := 'Fim de Jogo';

  if (Trim(vFrase) <> '') then
  begin
    pnlNumeroSorteado.Caption := vFrase + ': ' + IntToStr(vNumero);
  end else
  begin
    pnlNumeroSorteado.Caption := 'O n�mero sorteado �: ' + IntToStr(vNumero);
  end;

  pnlNumero.Font.Size := 150;
  pnlNumero.Caption := IntToStr(vNumero);

  if not lblSorteados.Visible then
    lblSorteados.Visible := True;

  lblSorteados.Caption := 'Total de n�meros sorteados: ' + IntToStr(CDS_Sorteados.RecordCount) + '       ';

  lblPedra5.Caption := lblPedra4.Caption;
  lblPedra4.Caption := lblPedra3.Caption;
  lblPedra3.Caption := lblPedra2.Caption;
  lblPedra2.Caption := lblPedra1.Caption;
  lblPedra1.Caption := IntToStr(vNumero);

  //ACBrGIF1.Active := False;
end;

procedure TF_Principal.Timer2Timer(Sender: TObject);
begin
  if pnlNumero.Caption = 'Gerando Numero' then
  begin
    pnlNumero.Caption := 'Gerando Numero.';
    Exit;
  end;

  if pnlNumero.Caption = 'Gerando Numero.' then
  begin
    pnlNumero.Caption := 'Gerando Numero..';
    Exit;
  end;

  if pnlNumero.Caption = 'Gerando Numero..' then
  begin
    pnlNumero.Caption := 'Gerando Numero...';
    Timer2.Enabled := False;
    Exit;
  end;


end;

procedure TF_Principal.TratarTitulo;
begin
  if (Trim(vTitulo) = '') then
    vTitulo := 'Bingo - Desenvolvido por Vitor Fornazieri Rodrigues';
  pnlTitulo.Caption := vTitulo;
end;

end.
