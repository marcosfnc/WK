unit Model.Produto;

interface
  uses
    Model.Connection, FireDAC.Comp.Client, Data.DB, System.SysUtils;
type
    TProduto = class
    private
        FCOD_PRODUTO: Integer;
        FId_PRODUTO: Integer;
        FCOD_VENDA: Integer;
        FNOME: string;
        FPRECO: Double;
        FQTDE: Double;
        FVLRTOTAL: Double;
        FVLRITEM: Double;
    public
        constructor Create;
        destructor Destroy; override;
        property COD_PRODUTO : integer read FCOD_PRODUTO write FCOD_PRODUTO;
        property Id_PRODUTO : integer read FId_PRODUTO write FId_PRODUTO;
        property NOME : string read FNOME write FNOME;
        property PRECO : Double read FPRECO write FPRECO;
        property QTDE : Double read FQTDE write FQTDE;
        property VLRTOTAL : Double read FVLRTOTAL write FVLRTOTAL;
        property VLRITEM : Double read FVLRITEM write FVLRITEM;
        property COD_VENDA : Integer read FCOD_VENDA write FCOD_VENDA;

        function searchProd(out erro: string): Boolean;
        function InserirProd(out erro: string): Boolean;
        function AlterarProd(out erro: string): Boolean;
        function SumTotal(out erro: string): boolean;


end;

implementation

{ TProduto }

function TProduto.AlterarProd(out erro: string): Boolean;
begin
  try
    Dm.QryAux.Close;
    Dm.QryAux.SQL.Clear;
    Dm.QryAux.SQL.Add('UPDATE vendaitem');
    Dm.QryAux.SQL.Add('SET vlrunitario = :vlrunitario,');
    Dm.QryAux.SQL.Add('qtde = :qtde,');
    Dm.QryAux.SQL.Add('vlrtotal = :vlrtotal');
    Dm.QryAux.SQL.Add('WHERE id = :id');

    Dm.QryAux.ParamByName('id').AsInteger        := COD_PRODUTO;
    Dm.QryAux.ParamByName('vlrunitario').AsFloat := VLRITEM;
    Dm.QryAux.ParamByName('qtde').AsFloat        := Qtde;
    Dm.QryAux.ParamByName('vlrtotal').AsFloat    := Qtde*VLRITEM;

    Dm.QryAux.ExecSQL;
    Dm.CarregaGrid(COD_VENDA);
    Result := True;
  except on ex:exception do
    begin
      erro := 'N?o foi possivel concluir essa venda: ' + ex.Message;
      Result := False;
    end;
  end;
end;

constructor TProduto.Create;
begin

end;

destructor TProduto.Destroy;
begin

  inherited;
end;

function TProduto.InserirProd(out erro: string): Boolean;
begin
  try
    Dm.QryVendaItem.Close;
    Dm.QryVendaItem.SQL.Clear;

    Dm.QryVendaItem.SQL.Add('INSERT INTO vendaitem');
    Dm.QryVendaItem.SQL.Add('(idpedido,idproduto,qtde,vlrunitario,vlrtotal)');
    Dm.QryVendaItem.SQL.Add('VALUES( :idpedido,:idproduto,:qtde,:vlrunitario,:vlrtotal )');

    Dm.QryVendaItem.ParamByName('idpedido').AsInteger   := COD_VENDA;
    Dm.QryVendaItem.ParamByName('idproduto').AsInteger  := COD_PRODUTO;
    Dm.QryVendaItem.ParamByName('qtde').AsFloat         := QTDE;
    Dm.QryVendaItem.ParamByName('vlrunitario').AsFloat  := VLRITEM;
    Dm.QryVendaItem.ParamByName('vlrtotal').AsFloat     := VLRTOTAL;

    Dm.QryVendaItem.execSql;

    Dm.Fconnection.Commit;

    Result := True;

    except on ex:exception do
    begin
      erro := 'Erro ao inserir o produto: ' + ex.Message;
      Result := False;
    end;
  end;

end;

function TProduto.searchProd(out erro: string): Boolean;
var
  qry : TFDQuery;
  Dm: TDm;
begin
  try
    Dm := Tdm.Create(nil);
    qry := TFDQuery.Create(nil);
    qry.Connection := Dm.Fconnection;

    with qry do
    begin
      Active := false;
      Close;
      SQL.Clear;
      SQL.Add('SELECT id,descricao,valor');
      SQL.Add('FROM produto');
      SQL.Add('where id = :id');

      ParamByName('id').Value := COD_PRODUTO;

      Active := true;
    end;

    if qry.IsEmpty then
    begin
      erro := 'Produto nao encontrado.';
      Result := False;
      exit;
    end;

    erro   := '';
    NOME   := qry.FieldByName('descricao').AsString;
    PRECO  := qry.FieldByName('valor').AsFloat;
    Result := True;

    except on ex:exception do
    begin
      erro := 'Erro ao consultar o produto: ' + ex.Message;
      Result := False;
    end;
  end;

end;

function TProduto.SumTotal(out erro: string): boolean;
var
  qry : TFDQuery;
  Dm: TDm;
begin
  try
    Dm := Tdm.Create(nil);
    qry := TFDQuery.Create(nil);
    qry.Connection := Dm.Fconnection;

    with qry do
    begin
      Active := false;
      Close;
      SQL.Clear;
      SQL.Add('SELECT sum(vlrtotal) AS Total');
      SQL.Add('FROM vendaitem');
      SQL.Add('WHERE idpedido = :idpedido');

      ParamByName('idpedido').Value := COD_VENDA;

      Active := true;
    end;

    if qry.IsEmpty then
    begin
      erro := 'Produto nao encontrado.';
      Result := False;
      exit;
    end;

    erro   := '';
    VLRTOTAL  := qry.FieldByName('Total').AsFloat;
    Result := True;

    except on ex:exception do
    begin
      erro := 'Erro ao alterar o produto: ' + ex.Message;
      Result := False;
    end;
  end;

end;

end.
