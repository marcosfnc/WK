unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Model.Cliente, Model.Produto, Model.Connection,
  uCancelaVenda, uCarregaVenda, MaskUtils;

type
  TFrmPrincipal = class(TForm)
    PnlRodaPe: TPanel;
    PnlTopo: TPanel;
    PnlCentral: TPanel;
    Label1: TLabel;
    EdtSearchClient: TEdit;
    PnlBuscaProd: TPanel;
    Label2: TLabel;
    EdtSearchProduto: TEdit;
    DBGrid1: TDBGrid;
    BtnGravar: TButton;
    BtnCancelar: TButton;
    EdtQtde: TEdit;
    EdtTotalIten: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EdtTotalVenda: TEdit;
    Label5: TLabel;
    EdtNumVenda: TEdit;
    Label6: TLabel;
    LblNomeCliente: TLabel;
    LblCidadeCliente: TLabel;
    BtnPedidos: TButton;
    BtnCancelaPedido: TButton;
    BtnInsertProd: TButton;
    EdtVlrUnitario: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LblProduto: TLabel;
    LblCodProduto: TLabel;
    procedure EdtSearchProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtSearchClientKeyPress(Sender: TObject; var Key: Char);
    procedure BtnCancelarClick(Sender: TObject);
    procedure EdtQtdeKeyPress(Sender: TObject; var Key: Char);
    procedure EdtVlrUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure EdtQtdeExit(Sender: TObject);
    procedure EdtVlrUnitarioExit(Sender: TObject);
    procedure BtnInsertProdClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnCancelaPedidoClick(Sender: TObject);
    procedure BtnPedidosClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure EdtSearchProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    TotalVenda, VlrAtu: Double;

    procedure LimpaCabecalho;
  public
    procedure HabilitaBtn(Status: Boolean);
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.BtnCancelaPedidoClick(Sender: TObject);
var
  CancelarVenda: TFrmCancelarVenda;
begin
  try
    CancelarVenda := TFrmCancelarVenda.Create(Self);
    CancelarVenda.ShowModal;
  finally
    FreeAndNil(CancelarVenda);
  end;
end;

procedure TFrmPrincipal.BtnCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TFrmPrincipal.BtnGravarClick(Sender: TObject);
var
  IdVenda: Integer;
  Total: Double;
begin
  if EdtTotalVenda.Text <> '' then
  begin
    IdVenda := StrToInt(EdtNumVenda.Text);
    Total   := StrToFloat(EdtTotalVenda.Text);
    Dm.Totalizar(IdVenda,Total);
    EdtTotalVenda.Text := '0,00';
    EdtNumVenda.Text   := '';
    TotalVenda         := 0;
    LimpaCabecalho;
    HabilitaBtn(False);
    dm.QryGrid.Close;
    EdtSearchClient.SetFocus;
  end;
end;

procedure TFrmPrincipal.BtnInsertProdClick(Sender: TObject);
var
  Produto : Tproduto;
  error : String;
begin
  if (LblProduto.Caption <> '')  then
  begin
    try
      Produto := TProduto.Create;

      Produto.COD_PRODUTO := StrToInt(LblCodProduto.Caption);
      Produto.NOME        := LblProduto.Caption;
      Produto.QTDE        := StrToFloat(EdtQtde.Text);
      Produto.VLRITEM     := StrToFloat(EdtVlrUnitario.Text);
      Produto.VLRTOTAL    := StrToFloat(EdtTotalIten.Text);
      produto.COD_VENDA   := StrToInt(EdtNumVenda.Text);

      if not EdtSearchProduto.Enabled then
      begin
        if Produto.AlterarProd(error) then
        begin
          EdtSearchProduto.Enabled := true;
          LimpaCabecalho;
          EdtSearchProduto.SetFocus;
          DBGrid1.DataSource.DataSet.Refresh;

          if Produto.SumTotal(Error) then
          begin
            TotalVenda          := Produto.VLRTOTAL;
            EdtTotalVenda.Text  := FormatFloat('#,##0.00',TotalVenda);
          end
          else
          ShowMessage(error);
        end;
      end
      else
      begin
        if Produto.InserirProd(error) then
        begin
          EdtSearchProduto.Clear;
          LimpaCabecalho;
          EdtSearchProduto.SetFocus;
          Dm.CarregaGrid(produto.COD_VENDA);

          TotalVenda := TotalVenda + Produto.VLRTOTAL;

          EdtTotalVenda.Text := FormatFloat('#,##0.00',TotalVenda);
        end
        else
        begin
          ShowMessage(error);
          LimpaCabecalho;
          EdtSearchProduto.SetFocus;
        end;
      end;

    finally
      FreeAndNil(Produto);
    end;

  end
  else
  begin
    ShowMessage('Favor digitar o codigo do produto');
    EdtSearchProduto.SelectAll;
    EdtSearchProduto.SetFocus;
  end;
end;

procedure TFrmPrincipal.BtnPedidosClick(Sender: TObject);
var
  CarregaVenda: TFrmCarregaVenda;
begin
  try
    CarregaVenda := TFrmCarregaVenda.Create(Self);
    CarregaVenda.ShowModal;
    TotalVenda := StrToFloatDef(EdtTotalVenda.Text,0.00);
  finally
    FreeAndNil(CarregaVenda);
  end;

end;

procedure TFrmPrincipal.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if DBGrid1.DataSource.DataSet.State in [dsEdit, dsInsert, dsBrowse] then
    if Rect.Top = TStringGrid(DBGrid1).CellRect(0,TStringGrid(DBGrid1).Row).Top then
    begin
      DBGrid1.Canvas.FillRect(Rect);
      DBGrid1.Canvas.Brush.Color := TColor($F0CAA6);
      DBGrid1.DefaultDrawDataCell(Rect,Column.Field,State)
   end;

end;

procedure TFrmPrincipal.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  TotalAtu: Double;
begin
  if dm.QryGrid.IsEmpty then
    exit;

  if key = vk_delete then
  begin
    if MessageDlg('Deseja excluir o item ' +
        dbgrid1.columns.items[1].field.Asstring + '?',   mtConfirmation,
        [mbYes, mbNo], 0)= mrYes then
    begin
      TotalAtu            := dbgrid1.columns.items[4].field.AsFloat;
      dm.DelteItem(StrToInt(EdtNumVenda.Text),dbgrid1.columns.items[5].field.Asinteger);
      DBGrid1.DataSource.DataSet.Refresh;
      TotalVenda         := TotalVenda - TotalAtu;
      EdtTotalVenda.Text := FormatFloat('#,##0.00',TotalVenda);
      EdtSearchProduto.SetFocus;
    end;
  end
  else
  begin
    if key = VK_RETURN then
    begin
      LblCodProduto.Caption := dbgrid1.columns.items[5].field.Asstring;
      LblProduto.Caption    := dbgrid1.columns.items[1].field.Asstring;
      EdtQtde.Text          := dbgrid1.columns.items[2].field.Asstring;
      EdtVlrUnitario.Text   := FormatFloat('#,##0.00',dbgrid1.columns.items[3].field.Asfloat);
      EdtTotalIten.Text     := FormatFloat('#,##0.00',dbgrid1.columns.items[4].field.Asfloat);
      VlrAtu                := dbgrid1.columns.items[4].field.Asfloat;
      EdtQtde.SetFocus;
      EdtSearchProduto.Enabled := False;
    end;
  end;
end;

procedure TFrmPrincipal.EdtQtdeExit(Sender: TObject);
begin
  if (EdtQtde.Text = '0') or (EdtQtde.Text = '') then
    EdtQtde.Text := '1';
end;

procedure TFrmPrincipal.EdtQtdeKeyPress(Sender: TObject; var Key: Char);
begin
  if ((key in ['0'..'9',#13] = false)) then
    key := #0;

  if key = #13 then
  begin
    if (EdtQtde.Text = '0') or (EdtQtde.Text = '') then
      EdtQtde.Text := '1';

    if EdtVlrUnitario.Text = '0' then
    begin
      ShowMessage('Favor digitar o valor do produto');
      EdtVlrUnitario.SetFocus;
      exit;
    end;

    EdtVlrUnitario.SelectAll;
    EdtVlrUnitario.SetFocus;
  end;
end;

procedure TFrmPrincipal.EdtSearchClientKeyPress(Sender: TObject; var Key: Char);
var
  Cliente : TCliente;
  error : String;
begin
  if ((key in ['0'..'9',#13] = false)) then
    key := #0;

  if key = #13 then
  begin
    if EdtSearchClient.Text = '' then
    begin
      ShowMessage('Favor digitar o c�digo do cliente');
      EdtSearchClient.SetFocus;
    end
    else
    begin
      try
        Cliente := TCliente.Create;

        Cliente.COD_CLIENTE := StrToInt(EdtSearchClient.Text);

        if Cliente.searchClient(error) then
        begin
          LblNomeCliente.Caption   := 'Cliente: ' + Cliente.NOME;
          LblCidadeCliente.Caption := 'Cidade: ' + Cliente.CIDADE;

          Cliente.InserirCabecalho(error);

          EdtNumVenda.Text :=  Cliente.COD_VENDA.ToString;

          HabilitaBtn(true);
          EdtSearchProduto.SetFocus;
        end
        else
        begin
          ShowMessage(error);
          EdtSearchClient.SetFocus;
          EdtSearchClient.SelectAll;
        end;

      finally
        FreeAndNil(Cliente);
      end;
    end;

  end;
end;

procedure TFrmPrincipal.EdtSearchProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_UP)  then begin
    Key := 0;
    PostMessage(DBGrid1.Handle, WM_HSCROLL, 0, 0);
  end
  else if (Key = VK_DOWN)  then begin
    Key := 0;
    PostMessage(DBGrid1.Handle, WM_HSCROLL, 1, 0);
  end;
end;

procedure TFrmPrincipal.EdtSearchProdutoKeyPress(Sender: TObject;var Key: Char);
var
  Produto : TProduto;
  error : String;
begin
   if ((key in ['0'..'9',#13] = false)) then
    key := #0;

  if Key = #13 then
  begin
    if EdtSearchProduto.Text = '' then
    begin
      ShowMessage('Favor digitar o c�digo do produto');
      EdtSearchProduto.SetFocus;
    end
    else
    begin
      try
        Produto := TProduto.Create;

        Produto.COD_PRODUTO := StrToInt(EdtSearchProduto.Text);

        if Produto.searchProd(error) then
        begin
          LblCodProduto.Visible := true;
          LblProduto.Visible    := true;
          LblCodProduto.Caption := IntToStr(Produto.COD_PRODUTO);
          LblProduto.Caption    := Produto.NOME;
          EdtVlrUnitario.Text   := FormatFloat('#,##0.00',Produto.PRECO);

          HabilitaBtn(true);
          EdtQtde.Text := '1';
          EdtQtde.SelectAll;
          EdtQtde.SetFocus;
        end
        else
        begin
          ShowMessage(error);
          LblProduto.Caption    := '';
          LblCodProduto.Caption := '';
          EdtVlrUnitario.Text   := '0,00';
          EdtQtde.Text          := '1';
          EdtTotalIten.Text     := '0,00';
          EdtSearchProduto.SelectAll;
          EdtSearchProduto.SetFocus;
        end;

      finally
        FreeAndNil(Produto);
      end;
    end;
  end;
end;

procedure TFrmPrincipal.EdtVlrUnitarioExit(Sender: TObject);
begin
   if (EdtVlrUnitario.Text = '') or (EdtVlrUnitario.Text = '0') then
   begin
     ShowMessage('Favor digitar o valor do produto');
     EdtVlrUnitario.SelectAll;
     EdtVlrUnitario.SetFocus;
   end;
end;

procedure TFrmPrincipal.EdtVlrUnitarioKeyPress(Sender: TObject; var Key: Char);
var
  vUnitario,Qtde, Total: Double;
begin
  if Key = #13 then
  begin
    if (EdtVlrUnitario.Text = '') or (EdtVlrUnitario.Text = '0') then
    begin
      ShowMessage('Favor digitar o valor do produto');
      EdtVlrUnitario.SelectAll;
      EdtVlrUnitario.SetFocus;
      exit;
    end;

    vUnitario         := StrToFloat(EdtVlrUnitario.Text);
    Qtde              := StrToFloat(EdtQtde.Text);
    Total             := Qtde * vUnitario;
    EdtTotalIten.Text := FormatFloat('#,##0.00',Total);
    BtnInsertProd.SetFocus;
  end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  LimpaCabecalho;
end;

procedure TFrmPrincipal.HabilitaBtn(Status: Boolean);
begin
  BtnGravar.Enabled        := Status;
  BtnCancelar.Enabled      := Status;
  BtnCancelaPedido.Enabled := Not Status;
  BtnPedidos.Enabled       := Not Status;
  LblNomeCliente.Visible   := Status;
  LblCidadeCliente.Visible := Status;
  EdtSearchClient.Enabled  := Not Status;
  BtnInsertProd.Enabled    := Status;
  EdtQtde.Enabled          := Status;
  EdtVlrUnitario.Enabled   := Status;
  EdtSearchProduto.Enabled := Status;
end;

procedure TFrmPrincipal.LimpaCabecalho;
begin
  EdtQtde.Text          := '1';
  EdtVlrUnitario.Text   := '0,00';
  EdtTotalIten.Text     := '0,00';
  LblCodProduto.Caption := '';
  LblProduto.Caption    := '';
  EdtSearchClient.Clear;
end;

end.
