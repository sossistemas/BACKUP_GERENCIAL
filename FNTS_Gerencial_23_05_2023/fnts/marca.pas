unit marca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Buttons, TFlatPanelUnit,
  Menus, DB, ZAbstractRODataset, ZDataset, Grids, DBGrids,
  Mask, maskutils, AdvGlowButton, wwdbedit, Wwdotdot, Wwdbcomb,
  AdvMetroButton, AdvSmoothExpanderPanel, JvExMask, JvToolEdit,
  JvDBControls, ZAbstractDataset, AdvSmoothPanel;

type
  Tfrmmarca = class(TForm)
    Pop1: TPopupMenu;
    Incluir1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    Localizar1: TMenuItem;
    Fechar1: TMenuItem;
    Pop2: TPopupMenu;
    Gravar1: TMenuItem;
    Cancelar1: TMenuItem;
    dsmarca2: TDataSource;
    qrmarca: TZQuery;
    Relatrios1: TMenuItem;
    dsmarca: TDataSource;
    Panel2: TPanel;
    bincluir: TAdvGlowButton;
    balterar: TAdvGlowButton;
    bexcluir: TAdvGlowButton;
    blocalizar: TAdvGlowButton;
    DBAdvGlowButton1: TDBAdvGlowButton;
    DBAdvGlowButton2: TDBAdvGlowButton;
    DBAdvGlowButton3: TDBAdvGlowButton;
    DBAdvGlowButton4: TDBAdvGlowButton;
    pgravar: TFlatPanel;
    bgravar: TAdvGlowButton;
    bcancelar: TAdvGlowButton;
    pficha: TFlatPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    LRG: TLabel;
    LCPF: TLabel;
    Label21: TLabel;
    Label3: TLabel;
    Label36: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    DBEdit1: TDBEdit;
    edata_cadastro: TJvDBDateEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit28: TDBEdit;
    DBEdit29: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit30: TDBEdit;
    qrduplo: TZQuery;
    euf: TwwDBComboBox;
    AdvSmoothExpanderPanel1: TAdvSmoothExpanderPanel;
    Label105: TLabel;
    AdvMetroButton1: TAdvMetroButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure enomeEnter(Sender: TObject);
    procedure enomeExit(Sender: TObject);
    procedure bincluirClick(Sender: TObject);
    procedure balterarClick(Sender: TObject);
    procedure bexcluirClick(Sender: TObject);
    procedure blocalizarClick(Sender: TObject);
    procedure bfecharClick(Sender: TObject);
    procedure bgravarClick(Sender: TObject);
    procedure bcancelarClick(Sender: TObject);
    procedure enomeKeyPress(Sender: TObject; var Key: Char);
    procedure etipoExit(Sender: TObject);
    procedure edata_cadastroEnter(Sender: TObject);
    procedure elimiteKeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit1Enter(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure RxDBCalcEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit15Exit(Sender: TObject);
    procedure DBEdit8Exit(Sender: TObject);
    procedure edata_cadastroExit(Sender: TObject);
    procedure bfinalizarClick(Sender: TObject);
    procedure DBEdit30KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit2Exit(Sender: TObject);
    procedure AdvMetroButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmmarca: Tfrmmarca;
  comando: string;

implementation

uses
  modulo, principal, xloc_marca;

{$R *.dfm}

procedure Tfrmmarca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure Tfrmmarca.FormShow(Sender: TObject);
begin
  FRMMODULO.QRCONFIG.OPEN;
  if FRMMODULO.QRCONFIG.FIELDBYNAME('RAMO_ATIVIDADE').ASINTEGER = 4 then // FARMACIA
  begin
    caption := 'LABORAT�RIOS | Ficha de Cadastro';
  end
  else
  begin
    caption := 'MARCA/FABRICANTE | Ficha de Cadastro';
  end;
  pgravar.visible := false;
  pgravar.Align := alClient;

  frmmodulo.qrMARCA.close;
  frmmodulo.qrMARCA.SQL.clear;
  frmmodulo.qrMARCA.SQL.add('select * from c000019 where atb like :atb order by codigo');
  frmmodulo.qrMARCA.open;
  frmmodulo.qrMARCA.first;
  pficha.Enabled := false;
  bincluir.SetFocus;
end;

procedure Tfrmmarca.enomeEnter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
end;

procedure Tfrmmarca.enomeExit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;
end;

procedure Tfrmmarca.bincluirClick(Sender: TObject);
begin
  frmmodulo.qrMARCA.insert;
  frmmodulo.qrMARCA.fieldbyname('codigo').asstring := frmprincipal.codifica('000019');
  pficha.Enabled := true;
  EDATA_CADASTRO.setfocus;
  pgravar.Visible := true;

  PopupMenu := pop2;
end;

procedure Tfrmmarca.AdvMetroButton1Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmmarca.balterarClick(Sender: TObject);
begin

  if dbedit1.Text <> '' then
  begin

    frmmodulo.qrMARCA.Edit;
    pficha.Enabled := true;
    EDATA_CADASTRO.setfocus;
    pgravar.Visible := true;
    PopupMenu := pop2;
  end
  else
  begin
    Showmessage('Nenhum registro foi selecionado!');
  end;

end;

procedure Tfrmmarca.bexcluirClick(Sender: TObject);
begin
  if frmprincipal.autentica('Excluir registro', 4) then
  begin
    frmmodulo.qrMARCA.Delete;
    frmmodulo.Conexao.commit;
  end
  else
  begin
    Application.messagebox('Acesso n�o permitido!', 'Erro!', mb_ok + mb_iconerror);
  end;
end;

procedure Tfrmmarca.blocalizarClick(Sender: TObject);
begin
  parametro_pesquisa := '';
  frmxloc_marca := tfrmxloc_marca.create(self);
  frmxloc_marca.showmodal;
  if resultado_pesquisa1 <> '' then
  begin
    frmmodulo.qrmarca.Locate('codigo', resultado_pesquisa1, [loCaseInsensitive]);
  end;
end;

procedure Tfrmmarca.bfecharClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmmarca.bgravarClick(Sender: TObject);
var
  situacao, tipo: integer;
  DATA: string;
begin

  if dbedit2.text = '' then
  begin
    application.messagebox('Favor informar um nome v�lido para este registro!', 'Aten��o', mb_ok + mb_iconerror);
    dbedit2.setfocus;
    exit;
  end;

  if (frmmodulo.qrMARCA.State = dsinsert) or (frmmodulo.qrMARCA.State = dsedit) then
  begin
    frmmodulo.qrMARCA.post;
  end;

  frmmodulo.Conexao.Commit;
  pficha.Enabled := false;
  pgravar.Visible := false;
  PopupMenu := pop1;
  bincluir.setfocus;

end;

procedure Tfrmmarca.bcancelarClick(Sender: TObject);
begin
  if (frmmodulo.qrMARCA.State = dsinsert) or (frmmodulo.qrMARCA.State = dsedit) then
    frmmodulo.qrMARCA.cancel;

  pficha.Enabled := false;
  pgravar.Visible := false;
  PopupMenu := pop1;
  bincluir.setfocus;
  comando := '';

end;

procedure Tfrmmarca.enomeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    PERFORM(WM_NEXTDLGCTL, 0, 0);
end;

procedure Tfrmmarca.etipoExit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;
end;

procedure Tfrmmarca.edata_cadastroEnter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
  if frmmodulo.qrMARCA.state = dsinsert then
    EDATA_CADASTRO.Date := DATE;
end;

procedure Tfrmmarca.elimiteKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    bgravar.setfocus;
end;

procedure Tfrmmarca.DBEdit1Enter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
end;

procedure Tfrmmarca.DBEdit1Exit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;
end;

procedure Tfrmmarca.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    perform(wm_nextdlgctl, 0, 0);
end;

procedure Tfrmmarca.RxDBCalcEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    bgravar.setfocus;
end;

procedure Tfrmmarca.DBEdit15Exit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;
  if DBEDIT15.Text <> '' then
  begin
    if (frmmodulo.qrMARCA.state = dsinsert) or (frmmodulo.qrMARCA.State = dsedit) then
    begin

      if frmprincipal.TestaCnpj(dbedit15.Text) then
      begin
        if pos('/', dbedit15.text) = 0 then
          frmmodulo.qrMARCA.fieldbyname('CNPJ').asstring := FormatMaskText('99.999.999/9999-99;0;_', dbedit15.text);
      end
      else
      begin
        Showmessage('CNPJ Inv�lido!');
        dbedit15.SetFocus;
      end;

    end;
  end;
end;

procedure Tfrmmarca.DBEdit8Exit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;
  if DBEDIT8.Text <> '' then
  begin
    if (frmmodulo.qrMARCA.state = dsinsert) or (frmmodulo.qrMARCA.State = dsedit) then
    begin
      if pos('-', dbedit8.text) = 0 then
        frmmodulo.qrMARCA.fieldbyname('cEP').asstring := FormatMaskText('99999-999;0;_', dbedit8.text);

    end;
  end;

end;

procedure Tfrmmarca.edata_cadastroExit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;

  if TJvDBDateEdit(Sender).text <> '  /  /    ' then
  begin
    try
      TJvDBDateEdit(Sender).Date := strtodate(TJvDBDateEdit(Sender).text);
    except
      showmessage('Data Inv�lida');
      TJvDBDateEdit(Sender).SetFocus;
    end;
  end;

end;

procedure Tfrmmarca.bfinalizarClick(Sender: TObject);
begin
  bgravar.setfocus;
end;

procedure Tfrmmarca.DBEdit30KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    bGRAVAR.setfocus;

  end;

end;

procedure Tfrmmarca.DBEdit2Exit(Sender: TObject);
var
  texto: PWideChar;
begin

  tedit(Sender).Color := clwindow;

  if dbedit2.text = '' then
  begin
    application.messagebox('Favor informar um nome v�lido para este registro!', 'Aten��o', mb_ok + mb_iconerror);
    dbedit2.setfocus;
    exit;
  end;

  if frmmodulo.qrmarca.state = dsinsert then
  begin
    qrduplo.close;
    qrduplo.sql.clear;
    qrduplo.sql.add('select * from c000019 where atb like :atb ');
    qrduplo.sql.add('where upper(NOME) = ''' + ANSIUPPERCASE(dbedit2.text) + '''');
    qrduplo.ParamByName('atb').Value := ME_FiltraATB('TB_MARCA');
    qrduplo.open;
    if qrduplo.recordcount > 0 then
    begin
      texto := PWideChar('Existe uma marca/fabricante cadastrado com este nome!' + #13 + qrduplo.fieldbyname('codigo').asstring + ' - ' + qrduplo.fieldbyname('nome').asstring + #13 + 'Endere�o: ' + qrduplo.fieldbyname('ENDERECO').asSTRING + '!' + #13 + 'Deseja prosseguir?');
      if application.messagebox(texto, 'Aten��o', mb_yesno + mb_iconwarning + MB_DEFBUTTON2) = idNO then
      begin
        BCANCELARCLICK(FRMmarca);
        EXIT;
      end;
    end;
  end;

end;

end.

