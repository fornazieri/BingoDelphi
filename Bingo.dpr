program Bingo;

uses
  Vcl.Forms,
  U_Principal in 'U_Principal.pas' {F_Principal},
  Vcl.Themes,
  Vcl.Styles,
  U_Configuracoes in 'U_Configuracoes.pas' {F_Configuracoes};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Aqua Light Slate');
  Application.CreateForm(TF_Principal, F_Principal);
  Application.Run;
end.
