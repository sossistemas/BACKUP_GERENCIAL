unit financeira_pgto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzEdit, ExtCtrls, AdvGlowButton, StdCtrls, Mask, Menus,
  AdvMetroButton, AdvSmoothPanel, AdvSmoothExpanderPanel, JvExMask, JvToolEdit;

type
  TfrmFinanceira_Pgto = class(TForm)
    Label4: TLabel;
    DateEdit1: TJvDateEdit;
    Panel1: TPanel;
    bgravar: TAdvGlowButton;
    Label1: TLabel;
    rvalor: TRzNumericEdit;
    PopupMenu1: TPopupMenu;
    Cancelar1: TMenuItem;
    AdvSmoothExpanderPanel1: TAdvSmoothExpanderPanel;
    Label53: TLabel;
    AdvMetroButton1: TAdvMetroButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DateEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure rvalorKeyPress(Sender: TObject; var Key: Char);
    procedure DateEdit1Enter(Sender: TObject);
    procedure DateEdit1Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bcancelarClick(Sender: TObject);
    procedure bgravarClick(Sender: TObject);
    procedure AdvMetroButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFinanceira_Pgto: TfrmFinanceira_Pgto;

implementation

uses
  financeira, principal, modulo;

{$R *.dfm}

procedure TfrmFinanceira_Pgto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmFinanceira_Pgto.DateEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    perform(wm_nextdlgctl, 0, 0);
end;

procedure TfrmFinanceira_Pgto.rvalorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    bgravar.setfocus;
end;

procedure TfrmFinanceira_Pgto.DateEdit1Enter(Sender: TObject);
begin
  tedit(Sender).color := $00C1FFFF;
end;

procedure TfrmFinanceira_Pgto.DateEdit1Exit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
end;

procedure TfrmFinanceira_Pgto.FormShow(Sender: TObject);
begin
  DateEdit1.setfocus;
end;

procedure TfrmFinanceira_Pgto.AdvMetroButton1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmFinanceira_Pgto.bcancelarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmFinanceira_Pgto.bgravarClick(Sender: TObject);
begin
  if DateEdit1.text = '  /  /    ' then
  begin
    application.messagebox('Favor informar a data!', 'Erro', mb_OK + MB_ICONERROR);
    DateEdit1.setfocus;
    EXIT;
  end;

  frmprincipal.logUC('Baixou Mov.Financeira - CodVenda: ' + frmfinanceira.qrfinanceira.fieldbyname('CODVENDA').asstring, 3);

  frmfinanceira.query.close;
  frmfinanceira.query.sql.clear;
  frmfinanceira.query.sql.add('update c000123 set situacao = 2, valor_pago = :valor_pago, data_pgto = :data_pgto');
  frmfinanceira.query.sql.add('where atb like :atb and codigo = ''' + frmfinanceira.qrfinanceira.fieldbyname('codigo').asstring + '''');
  frmfinanceira.query.ParamByName('valor_pago').asfloat := rvalor.value;
  frmfinanceira.query.ParamByName('data_pgto').asdatetime := DateEdit1.date;
  frmfinanceira.query.ParamByName('atb').Value := ME_FiltraATB('TB_FINANCEIRA_LANCAMENTO');
  frmfinanceira.query.execsql;

  close;
end;

end.

