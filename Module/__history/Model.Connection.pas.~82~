unit Model.Connection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Dialogs;

type
  TDm = class(TDataModule)
    Fconnection: TFDConnection;
    DsGrid: TDataSource;
    QryVendaItem: TFDQuery;
    QryVenda: TFDQuery;
    QryAux: TFDQuery;
    QryGrid: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public
    function GetId: Integer;
    function DeleteVenda(IdVenda: Integer): Boolean;
    function CarregaVenda(IdVenda: Integer): Boolean;

    procedure CarregaGrid(IdVenda: Integer);
    procedure Totalizar(IdVenda: Integer; VlrTotal: Double);
    procedure DelteItem(IdVenda, IdProd: Integer);
  end;

var
  Dm: TDm;

implementation
  uses
    uPrincipal;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDm.CarregaGrid(IdVenda: Integer);
begin
  Try
    QryGrid.Close;
    QryGrid.SQL.Clear;
    QryGrid.SQL.Add('SELECT');
    QryGrid.SQL.Add('a.id,a.idproduto,a.qtde,');
    QryGrid.SQL.Add('a.vlrunitario,a.vlrtotal,b.descricao');
    QryGrid.SQL.Add('FROM');
    QryGrid.SQL.Add('vendaitem a INNER JOIN produto b ON a.idproduto = b.id');
    QryGrid.SQL.Add('WHERE');
    QryGrid.SQL.Add('a.idpedido = :idpedido');

    QryGrid.ParamByName('idpedido').AsInteger := IdVenda;

    QryGrid.Open;

  except on ex:exception do
    ShowMessage('Erro ao carregar grid: ' + ex.Message);
  End;
end;

function TDm.CarregaVenda(IdVenda: Integer): Boolean;
var
  TotalVenda: double;
begin
  try
    QryAux.Close;
    QryAux.SQL.Clear;
    QryAux.SQL.Add('SELECT');
    QryAux.SQL.Add('a.idcliente, a.vlrtotal, b.nome, b.cidade');
    QryAux.SQL.Add('FROM');
    QryAux.SQL.Add('venda a INNER JOIN cliente b ON a.idcliente = b.id');
    QryAux.SQL.Add('WHERE');
    QryAux.SQL.Add('a.id = :id');

    QryAux.ParamByName('id').AsInteger := IdVenda;

    QryAux.Open;

    if not QryAux.IsEmpty then
    begin
      Result := True;
      TotalVenda := QryAux.FieldByName('vlrtotal').AsFloat;

      FrmPrincipal.LblNomeCliente.Caption   := QryAux.FieldByName('nome').AsString;
      FrmPrincipal.LblCidadeCliente.Caption := QryAux.FieldByName('cidade').AsString;
      FrmPrincipal.EdtNumVenda.Text         := IntToStr(IdVenda);
      FrmPrincipal.EdtTotalVenda.Text       := FormatFloat('###,###,##0.00',TotalVenda);
      FrmPrincipal.HabilitaBtn(True);

      CarregaGrid(IdVenda);
    end
    else
    begin
      ShowMessage('Essa Venda Não Existe! ');
      Result := False;
    end;


  except on ex:exception do
    ShowMessage('Erro ao carregar grid: ' + ex.Message);
  End;
end;

procedure TDm.DataModuleCreate(Sender: TObject);
begin
  try
    FConnection.DriverName       := 'MySQL';
    FConnection.Params.Database  := 'teste';
    FConnection.Params.UserName  := 'root';
    FConnection.Params.Password  := '@WK&Technology#123';
    FConnection.Connected := true;


    except on ex:exception do
    begin
      ShowMessage('Erro ao acessar banco de dados: ' + ex.Message);
      exit;
    end;
  end;
end;


procedure TDm.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FConnection) then
  begin
    if FConnection.Connected then
      FConnection.Connected := false;

    FConnection.Free;
  end;
end;

function TDm.DeleteVenda(IdVenda: Integer): Boolean;
begin
  try
    QryAux.Close;
    QryAux.SQL.Clear;
    QryAux.SQL.Add('SELECT id FROM venda');
    QryAux.SQL.Add('WHERE id= :id');
    QryAux.ParamByName('id').AsInteger := IdVenda;
    QryAux.Open;

    if QryAux.IsEmpty then
    begin
      ShowMessage('Essa Venda Não Existe! ');
      Result := False;
      exit;
    end;

    Result := True;
    QryAux.Close;
    QryAux.SQL.Clear;
    QryAux.SQL.Add('DELETE FROM VENDA');
    QryAux.SQL.Add('WHERE id = :id');

    QryAux.ParamByName('id').AsInteger := IdVenda;

    QryAux.ExecSQL;

    QryAux.Close;
    QryAux.SQL.Clear;
    QryAux.SQL.Add('DELETE FROM VENDAITEM');
    QryAux.SQL.Add('WHERE idpedido = :idpedido');

    QryAux.ParamByName('idpedido').AsInteger := IdVenda;

    QryAux.ExecSQL;

  except on ex:exception do
    begin
      ShowMessage('Não foi possivel excluir essa venda: ' + ex.Message);
      Result := False;
    end;

  end;
end;

procedure TDm.DelteItem(IdVenda, IdProd: Integer);
begin
  try
    QryAux.Close;
    QryAux.SQL.Clear;
    QryAux.SQL.Add('DELETE FROM VENDAITEM');
    QryAux.SQL.Add('WHERE idpedido = :idpedido');
    QryAux.SQL.Add('AND id = :id');

    QryAux.ParamByName('idpedido').AsInteger   := IdVenda;
    QryAux.ParamByName('id').AsInteger  := IdProd;

    QryAux.ExecSQL;

  except on ex:exception do
    ShowMessage('Não foi possivel excluir o item: ' + ex.Message);
  end;
end;

function TDm.GetId: Integer;
begin
  Result := 0;

  QryAux.Close;
  QryAux.SQL.Clear;
  QryAux.SQL.Add('select max(id) from venda');
  QryAux.Open;

  Result := QryAux.FieldByName('max(id)').AsInteger;
end;

procedure TDm.Totalizar(IdVenda: Integer; VlrTotal: Double);
begin
  try
    QryAux.Close;
    QryAux.SQL.Clear;
    QryAux.SQL.Add('UPDATE venda');
    QryAux.SQL.Add('SET vlrtotal = :vlrtotal');
    QryAux.SQL.Add('WHERE id = :id');

    QryAux.ParamByName('id').AsInteger       := IdVenda;
    QryAux.ParamByName('vlrtotal').AsFloat   := VlrTotal;

    QryAux.ExecSQL;

  except on ex:exception do
    ShowMessage('Não foi possivel concluir essa venda: ' + ex.Message);
  end;
end;

end.
