unit uCarregaVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Model.Connection;

type
  TFrmCarregaVenda = class(TForm)
    Label1: TLabel;
    EdtNumVenda: TEdit;
    BtnConfirma: TButton;
    BtnVoltar: TButton;
    procedure EdtNumVendaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnVoltarClick(Sender: TObject);
    procedure BtnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCarregaVenda: TFrmCarregaVenda;

implementation

{$R *.dfm}

procedure TFrmCarregaVenda.BtnConfirmaClick(Sender: TObject);
begin
  if (EdtNumVenda.Text <> '') then
  begin
    if Dm.CarregaVenda(StrToInt(EdtNumVenda.Text)) then
      Close
    else
      EdtNumVenda.SetFocus;
  end
  else
  begin
    ShowMessage('Favor Informe o n�mero da venda.');
    EdtNumVenda.SetFocus;
  end;
end;

procedure TFrmCarregaVenda.BtnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCarregaVenda.EdtNumVendaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
    Close;

  if not CharInSet(Key, ['0'..'9',#8,#13,#27])  then
    Key := #0;

  if Key = #13 then
    BtnConfirma.SetFocus;
end;

end.
