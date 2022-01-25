unit U_Configuracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Themes;

type
  TF_Configuracoes = class(TForm)
    pnlTitulo: TPanel;
    Panel1: TPanel;
    lblSorteados: TLabel;
    edtTitulo: TEdit;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    ComboBox1: TComboBox;
    Label1: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Configuracoes: TF_Configuracoes;

implementation

{$R *.dfm}

uses U_Principal;

procedure TF_Configuracoes.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TF_Configuracoes.btnSalvarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TF_Configuracoes.ComboBox1Change(Sender: TObject);
begin
  try
    F_Principal.vTema := ComboBox1.Text;
    TStyleManager.TrySetStyle(F_Principal.vTema);
  except
    F_Principal.vTema := 'Windows';
    TStyleManager.TrySetStyle(F_Principal.vTema);
  end;

end;

procedure TF_Configuracoes.FormCreate(Sender: TObject);
begin
  edtTitulo.Text := F_Principal.vTitulo;
end;

end.
