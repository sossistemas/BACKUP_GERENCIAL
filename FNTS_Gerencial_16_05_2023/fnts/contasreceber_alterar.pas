unit contasreceber_alterar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdblook, Mask, DBCtrls,
  ExtCtrls, Buttons, TFlatPanelUnit, Menus, DB, AdvGlowButton,
  JvBaseEdits, JvDBControls, JvExMask, JvToolEdit;

type
  Tfrmcontasreceber_alterar = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBDateEdit1: TJvDBDateEdit;
    DBDateEdit2: TJvDBDateEdit;
    DBEdit3: TDBEdit;
    COMBOTIPO: TwwDBLookupCombo;
    PopupMenu1: TPopupMenu;
    Gravar1: TMenuItem;
    Cancelar1: TMenuItem;
    dscontasreceber: TDataSource;
    rvalor: TJvDBCalcEdit;
    FlatPanel2: TFlatPanel;
    Label7: TLabel;
    DBEdit2: TDBEdit;
    Label8: TLabel;
    ENOMECLIENTE: TEdit;
    ENOMEVENDEDOR: TEdit;
    Label9: TLabel;
    ecliente: TDBEdit;
    evendedor: TDBEdit;
    GroupBox1: TGroupBox;
    COMBOCONTA: TwwDBLookupCombo;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit4: TDBEdit;
    Label12: TLabel;
    DBEdit5: TDBEdit;
    Label13: TLabel;
    DBEdit6: TDBEdit;
    pgravar: TFlatPanel;
    bgravar: TAdvGlowButton;
    bcancelar: TAdvGlowButton;
    procedure DBEdit1Enter(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBDateEdit1Enter(Sender: TObject);
    procedure DBDateEdit2Enter(Sender: TObject);
    procedure bcancelarClick(Sender: TObject);
    procedure bgravarClick(Sender: TObject);
    procedure evendedorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure COMBOCONTAExit(Sender: TObject);
    procedure COMBOCONTAKeyPress(Sender: TObject; var Key: Char);
    procedure COMBOCONTAEnter(Sender: TObject);
    procedure DBEdit6KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcontasreceber_alterar: Tfrmcontasreceber_alterar;

implementation

uses modulo, contasreceber, principal;

{$R *.dfm}

procedure Tfrmcontasreceber_alterar.DBEdit1Enter(Sender: TObject);
begin
  tedit(SENDER).Color := $00A0FAF8;
end;

procedure Tfrmcontasreceber_alterar.DBEdit1Exit(Sender: TObject);
begin
  tedit(SENDER).Color := clwindow;
end;

procedure Tfrmcontasreceber_alterar.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then perform(wm_nextdlgctl, 0, 0);
end;

procedure Tfrmcontasreceber_alterar.DBDateEdit1Enter(Sender: TObject);
begin
  tedit(SENDER).Color := $00A0FAF8;
  if dbdateedit1.text = '  /  /    ' then
    dbdateedit1.Date := date;
end;

procedure Tfrmcontasreceber_alterar.DBDateEdit2Enter(Sender: TObject);
begin
  tedit(SENDER).Color := $00A0FAF8;
  if dbdateedit2.text = '  /  /    ' then
    dbdateedit2.Date := incmonth(dbdateedit1.date, 1);
end;

procedure Tfrmcontasreceber_alterar.bcancelarClick(Sender: TObject);
begin
  frmcontasreceber.qrcontasreceber.Cancel;
  close;
end;

procedure Tfrmcontasreceber_alterar.bgravarClick(Sender: TObject);
begin
  if (ecliente.Text = '') or (ecliente.Text = '000000') then
  begin
    showmessage('Favor informar o cliente!');
    ecliente.setfocus;
    exit;
  end;
  if dbdateedit2.text = '  /  /    ' then
  begin
    showmessage('Favor informar o vencimento!');
    dbdateedit2.SetFocus;
    exit;
  end;


  if rvalor.Value = 0 then
  begin
    showmessage('O valor est� zerado!');
    rvalor.setfocus;
    exit;
  end;


  frmcontasreceber.qrcontasreceber.fieldbyname('situacao').asinteger := 1;
  frmcontasreceber.qrcontasreceber.fieldbyname('filtro').asinteger := 0;
  frmcontasreceber.qrcontasreceber.fieldbyname('valor_atual').asfloat := rvalor.value;
  frmcontasreceber.qrcontasreceber.post;


  frmmodulo.conexao.commit;

  frmPrincipal.logUC('Alterou Conta Nr: ' + DBEdit3.Text + ' do Cliente: ' +ENOMECLIENTE.Text, 2);
  close;



end;

procedure Tfrmcontasreceber_alterar.evendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then bgravar.setfocus;
end;

procedure Tfrmcontasreceber_alterar.FormShow(Sender: TObject);
begin


  enomecliente.Text := frmmodulo.qrcliente.fieldbyname('nome').asstring;
  enomevendedor.Text := frmmodulo.qrfunci.fieldbyname('nome').asstring;



  frmmodulo.qrformapgto.close;
  frmmodulo.qrformapgto.sql.clear;
  frmmodulo.qrformapgto.sql.add('select * from c000014 order by formapgto');
  frmmodulo.qrformapgto.Open;
  frmmodulo.qrformapgto.IndexFieldNames := 'formapgto';

end;

procedure Tfrmcontasreceber_alterar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
end;

procedure Tfrmcontasreceber_alterar.COMBOCONTAExit(Sender: TObject);
begin
  tedit(sender).color := clwindow;
end;

procedure Tfrmcontasreceber_alterar.COMBOCONTAKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then perform(wm_nextdlgctl, 0, 0);
end;

procedure Tfrmcontasreceber_alterar.COMBOCONTAEnter(Sender: TObject);
begin
  tedit(sender).color := $00A0FAF8;
end;

procedure Tfrmcontasreceber_alterar.DBEdit6KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then bgravar.setfocus;
end;

end.
