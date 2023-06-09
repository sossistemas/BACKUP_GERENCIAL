unit contacorrente_lancamento2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TFlatPanelUnit, StdCtrls, Buttons, Mask,
  DBCtrls, DB, Wwdatsrc, Menus, AdvGlowButton, JvExMask, JvToolEdit,
  JvDBControls;

type
  Tfrmcontacorrente_lancamento2 = class(TForm)
    DBEdit1: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    dslancamento_conta: TwwDataSource;
    FlatPanel1: TFlatPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    DBEdit2: TDBEdit;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    DBEdit3: TDBEdit;
    edata_cadastro: TJvDBDateEdit;
    ECONTA: TDBEdit;
    BLOCCONTA: TBitBtn;
    enomeconta: TEdit;
    Pop2: TPopupMenu;
    Gravar1: TMenuItem;
    Cancelar1: TMenuItem;
    DBText1: TDBText;
    dscontacorrente: TwwDataSource;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    Panel2: TPanel;
    bgravar: TAdvGlowButton;
    bcancelar: TAdvGlowButton;
    Bevel10: TBevel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ECONTAKeyPress(Sender: TObject; var Key: Char);
    procedure bgravarClick(Sender: TObject);
    procedure bcancelarClick(Sender: TObject);
    procedure DBEdit1Enter(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure edata_cadastroEnter(Sender: TObject);
    procedure DBEdit5Exit(Sender: TObject);
    procedure BLOCCONTAClick(Sender: TObject);
    procedure ECONTAExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edata_cadastroKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcontacorrente_lancamento2: Tfrmcontacorrente_lancamento2;

implementation

uses
  modulo, principal, loc_conta;

{$R *.dfm}

procedure Tfrmcontacorrente_lancamento2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CAFREE;
end;

procedure Tfrmcontacorrente_lancamento2.ECONTAKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    bgravar.setfocus;
end;

procedure Tfrmcontacorrente_lancamento2.bgravarClick(Sender: TObject);
var
  incluir: boolean;
begin

  if FRMMODULO.qrlancamento_conta.FieldByName('tipo').asstring = 'D' then
  begin
    FRMMODULO.qrlancamento_conta.FieldByName('valor').asfloat := FRMMODULO.qrlancamento_conta.FieldByName('valor').asfloat * (-1);
  end;

  FRMMODULO.qrlancamento_conta.Post;
  frmmodulo.Conexao.Commit;
  CLOSE;

end;

procedure Tfrmcontacorrente_lancamento2.bcancelarClick(Sender: TObject);
begin
  FRMMODULO.qrlancamento_conta.Cancel;
  close;
end;

procedure Tfrmcontacorrente_lancamento2.DBEdit1Enter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
end;

procedure Tfrmcontacorrente_lancamento2.DBEdit1Exit(Sender: TObject);
begin
  TEDIT(Sender).COLOR := CLWINDOW;
end;

procedure Tfrmcontacorrente_lancamento2.edata_cadastroEnter(Sender: TObject);
begin
  TEDIT(Sender).COLOR := $00A0FAF8;
  if EDATA_CADASTRO.TEXT = '  /  /    ' then
    EDATA_CADASTRO.DATE := DATE;

end;

procedure Tfrmcontacorrente_lancamento2.DBEdit5Exit(Sender: TObject);
begin
  TEDIT(Sender).COLOR := CLWINDOW;
  if DBEDIT5.Text <> 'D' then
    if dbedit5.text <> 'C' then
    begin
      showmessage('Favor Digitar "D" para D�bito ou "C" para Cr�dito');
      dbedit5.setfocus;
    end;
end;

procedure Tfrmcontacorrente_lancamento2.BLOCCONTAClick(Sender: TObject);
begin
  frmloc_conta := tfrmloc_conta.create(self);
  frmloc_conta.showmodal;
  FRMMODULO.qrlancamento_conta.fieldbyname('codconta').asstring := frmmodulo.qrplano.fieldbyname('CODIGO').asstring;
  enomeconta.Text := frmmodulo.qrplano.fieldbyname('conta').asstring;
  bgravar.setfocus;
end;

procedure Tfrmcontacorrente_lancamento2.ECONTAExit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;
  if (FRMMODULO.qrlancamento_conta.state = dsinsert) or (FRMMODULO.qrlancamento_conta.State = dsedit) then
  begin
    FRMMODULO.qrlancamento_conta.fieldbyname('codconta').asstring := frmprincipal.zerarcodigo(econta.text, 6);
    if econta.text <> '000000' then
    begin
      if not FrmPrincipal.Locregistro(frmmodulo.qrplano, econta.text, 'codigo') then
      begin
        bloccontaclick(frmcontacorrente_LANCAMENTO2);
      end
      else
      begin
        enomeconta.Text := frmmodulo.qrplano.fieldbyname('conta').asstring;
        bgravar.setfocus;
      end;
    end
    else
      blocconta.SetFocus;
  end;
end;

procedure Tfrmcontacorrente_lancamento2.FormShow(Sender: TObject);
begin
  frmmodulo.qrPLANO.close;
  frmmodulo.qrPLANO.sql.clear;
  frmmodulo.qrPLANO.SQL.add('select * from c000035 where atb like :atb order by CONTA');
  frmmodulo.qrPLANO.Open;
end;

procedure Tfrmcontacorrente_lancamento2.edata_cadastroKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    perform(wm_nextdlgctl, 0, 0);
end;

end.

