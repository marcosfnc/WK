program principal;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {FrmPrincipal},
  Model.Connection in '..\Module\Model.Connection.pas' {Dm: TDataModule},
  Model.Cliente in '..\Module\Model.Cliente.pas',
  Model.Produto in '..\Module\Model.Produto.pas',
  uCancelaVenda in 'uCancelaVenda.pas' {FrmCancelarVenda},
  uCarregaVenda in 'uCarregaVenda.pas' {FrmCarregaVenda};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TFrmCancelarVenda, FrmCancelarVenda);
  Application.CreateForm(TFrmCarregaVenda, FrmCarregaVenda);
  Application.Run;
end.
