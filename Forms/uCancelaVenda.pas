unit uCancelaVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Model.Connection;

type
  TFrmCancelarVenda = class(TForm)
    EdtNumNota: TEdit;
    BtnConfirma: TButton;
    BtnVoltar: TButton;
    Label1: TLabel;
    procedure EdtNumNotaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnConfirmaClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCancelarVenda: TFrmCancelarVenda;

implementation

{$R *.dfm}

procedure TFrmCancelarVenda.BtnConfirmaClick(Sender: TObject);
begin
  if (EdtNumNota.Text <> '') then
  begin
    if Dm.DeleteVenda(StrToInt(EdtNumNota.Text)) then
    begin
      ShowMessage('Nota N�: '+ EdtNumNota.Text + ' Cancelada Com sucesso.');
      Close;
    end
    else
      Close;
  end
  else
  begin
    ShowMessage('Favor Informe o n�mero da venda.');
    EdtNumNota.SetFocus;
  end;

end;

procedure TFrmCancelarVenda.BtnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCancelarVenda.EdtNumNotaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
    Close;

  if not CharInSet(Key, ['0'..'9',#8,#13,#27])  then
    Key := #0;

  if Key = #13 then
    BtnConfirma.SetFocus;
end;

end.
