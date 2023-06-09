unit inventario_ficha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, AdvGlowButton, RzEdit, Mask, RzBtnEdt, Menus, DB,
  ZAbstractRODataset, ZDataset, AdvMetroButton,
  AdvSmoothExpanderPanel, ZAbstractDataset, AdvSmoothPanel;

type
  Tfrminventario_ficha = class(TForm)
    Label1: TLabel;
    eproduto: TRzButtonEdit;
    enomeproduto: TRzEdit;
    Label2: TLabel;
    eestoque: TRzNumericEdit;
    Label3: TLabel;
    ecusto: TRzNumericEdit;
    Label4: TLabel;
    etotal: TRzNumericEdit;
    Panel1: TPanel;
    bgravar: TAdvGlowButton;
    PopupMenu1: TPopupMenu;
    Gravar1: TMenuItem;
    Cancelar1: TMenuItem;
    qrloc: TZQuery;
    qrloc2: TZQuery;
    Panel2: TPanel;
    Label5: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label6: TLabel;
    eano: TLabel;
    edata: TLabel;
    emes: TLabel;
    Label7: TLabel;
    Bevel5: TBevel;
    Label8: TLabel;
    eposterior: TLabel;
    etipo1: TRzNumericEdit;
    etipo2: TRzNumericEdit;
    etipo3: TRzNumericEdit;
    AdvSmoothExpanderPanel1: TAdvSmoothExpanderPanel;
    Label53: TLabel;
    AdvMetroButton1: TAdvMetroButton;
    procedure bcancelarClick(Sender: TObject);
    procedure bgravarClick(Sender: TObject);
    procedure eestoqueKeyPress(Sender: TObject; var Key: Char);
    procedure ecustoKeyPress(Sender: TObject; var Key: Char);
    procedure eprodutoKeyPress(Sender: TObject; var Key: Char);
    procedure eprodutoButtonClick(Sender: TObject);
    procedure eestoqueExit(Sender: TObject);
    procedure ecustoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdvMetroButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frminventario_ficha: Tfrminventario_ficha;

implementation

uses
  modulo, principal, xloc_produto, inventario;

{$R *.dfm}

procedure Tfrminventario_ficha.AdvMetroButton1Click(Sender: TObject);
begin
  close;
end;

procedure Tfrminventario_ficha.bcancelarClick(Sender: TObject);
begin
  close;
end;

procedure Tfrminventario_ficha.bgravarClick(Sender: TObject);
begin

  if (eproduto.text = '') or (eproduto.text = '000000') then
  begin
    application.messagebox('Favor informar o produto!', 'Aten��o', mb_ok + mb_iconerror);
    eproduto.setfocus;
    exit;
  end;

  qrloc2.close;
  qrloc2.sql.Clear;
  qrloc2.sql.add('select * from inventario where atb like :atb and codproduto = ''' + eproduto.text + '''');
  qrloc2.sql.add('and ano = ' + eano.caption + ' and mes = ' + INTTOSTR(STRTOINT(emes.caption)));
  qrloc2.ParamByName('atb').Value := ME_FiltraATB('TB_INVENTARIO');
  qrloc2.Open;
  if qrloc2.recordcount > 0 then
  begin
    application.messagebox('Este produto j� est� lan�ado para este per�odo! Favor verificar!', 'Aten��o', mb_ok + mb_iconerror);
    eproduto.setfocus;
    exit;
  end;

  pode_incluir := true;

  frminventario.qrinventario.insert;
  frminventario.qrinventario.fieldbyname('data').asdatetime := strtodate(edata.caption);
  frminventario.qrinventario.fieldbyname('ano').asinteger := strtoint(eano.caption);
  frminventario.qrinventario.fieldbyname('mes').asstring := emes.caption;
  frminventario.qrinventario.fieldbyname('tipo').asstring := qrloc.fieldbyname('tipo').asstring;

  frminventario.qrinventario.fieldbyname('codproduto').asstring := qrloc.fieldbyname('codigo').asstring;
  frminventario.qrinventario.fieldbyname('produto').asstring := qrloc.fieldbyname('produto').asstring;
  frminventario.qrinventario.fieldbyname('unidade').asstring := qrloc.fieldbyname('unidade').asstring;
  frminventario.qrinventario.fieldbyname('cst').asstring := qrloc.fieldbyname('cst').asstring;
  frminventario.qrinventario.fieldbyname('aliquota').asfloat := qrloc.fieldbyname('aliquota').asfloat;
  frminventario.qrinventario.fieldbyname('custo').asfloat := ecusto.value;
  frminventario.qrinventario.fieldbyname('estoque').asfloat := eestoque.value;
  frminventario.qrinventario.fieldbyname('venda').asfloat := qrloc.fieldbyname('precovenda').asfloat;
  frminventario.qrinventario.fieldbyname('total').asfloat := etotal.value;
  frminventario.qrinventario.fieldbyname('atb').asstring := ME_GravaATB('TB_INVENTARIO');

  if eposterior.caption <> '' then
    frminventario.qrinventario.fieldbyname('data_posterior').asdatetime := strtodate(eposterior.caption);

  frminventario.qrinventario.post;

  frmmodulo.conexao.commit;
  pode_incluir := false;
  close;

  frminventario.bincluirClick(frminventario);
end;

procedure Tfrminventario_ficha.eestoqueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    perform(wm_nextdlgctl, 0, 0);
end;

procedure Tfrminventario_ficha.ecustoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    bgravar.setfocus;
end;

procedure Tfrminventario_ficha.eprodutoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    eproduto.text := frmprincipal.zerarcodigo(eproduto.text, 6);
    if eproduto.text <> '000000' then
    begin
      qrloc.close;
      qrloc.sql.clear;
      qrloc.sql.add('select prod.*, est.*');
      qrloc.sql.add('from c000025 prod, c000100 est');
      qrloc.sql.add('where prod.atb like :atbprod and est.atb like :atbest and prod.codigo = est.codproduto');
      qrloc.sql.add('and prod.codigo = ''' + eproduto.text + '''');
      qrloc.sql.add('order by prod.produto');
      qrloc.ParamByName('atbprod').Value := ME_FiltraATB('TB_PRODUTO');
      qrloc.ParamByName('atbest').Value := ME_FiltraATB('TB_ESTOQUE');
      qrloc.open;

      if qrloc.recordcount > 0 then
      begin
        enomeproduto.text := qrloc.fieldbyname('produto').asstring;
        ecusto.value := qrloc.fieldbyname('precocusto').asfloat;
        eestoque.value := qrloc.fieldbyname('estoque_atual').asfloat;
        etotal.value := qrloc.fieldbyname('estoque_atual').asfloat * qrloc.fieldbyname('precocusto').asfloat;
        eestoque.setfocus;
      end
      else
      begin
        qrloc.close;
        qrloc.sql.clear;
        qrloc.sql.add('select prod.*, est.*');
        qrloc.sql.add('from c000025 prod, c000100 est');
        qrloc.sql.add('where prod.atb like :atbprod and est.atb like :atbest and prod.codigo = est.codproduto');
        qrloc.sql.add('and prod.codbarra = ''' + eproduto.text + '''');
        qrloc.sql.add('order by prod.produto');
        qrloc.ParamByName('atbprod').Value := ME_FiltraATB('TB_PRODUTO');
        qrloc.ParamByName('atbest').Value := ME_FiltraATB('TB_ESTOQUE');
        qrloc.open;
        if qrloc.recordcount > 0 then
        begin
          eproduto.text := qrloc.fieldbyname('codigo').asstring;
          enomeproduto.text := qrloc.fieldbyname('produto').asstring;
          ecusto.value := qrloc.fieldbyname('precocusto').asfloat;
          eestoque.value := qrloc.fieldbyname('estoque_atual').asfloat;
          etotal.value := qrloc.fieldbyname('estoque_atual').asfloat * qrloc.fieldbyname('precocusto').asfloat;
          eestoque.setfocus;
        end
        else
        begin
          application.messagebox('Produto n�o encontrado!', 'Erro', mb_ok + mb_iconerror);
          eproduto.setfocus;
          exit;
        end;
      end;
    end
    else
      eprodutoButtonClick(frminventario_ficha);

  end;
end;

procedure Tfrminventario_ficha.eprodutoButtonClick(Sender: TObject);
begin

  resultado_pesquisa1 := '';
  frmxloc_produto := tfrmxloc_produto.create(self);
  frmxloc_produto.showmodal;
  if resultado_pesquisa1 <> '' then
  begin
    qrloc.close;
    qrloc.sql.clear;
    qrloc.sql.add('select prod.*, est.*');
    qrloc.sql.add('from c000025 prod, c000100 est');
    qrloc.sql.add('where prod.atb like :atbprod and est.atb like :atbest and prod.codigo = est.codproduto');
    qrloc.sql.add('and prod.codigo = ''' + resultado_pesquisa1 + '''');
    qrloc.sql.add('order by prod.produto');
    qrloc.ParamByName('atbprod').Value := ME_FiltraATB('TB_PRODUTO');
    qrloc.ParamByName('atbest').Value := ME_FiltraATB('TB_ESTOQUE');
    qrloc.open;

    ecusto.value := qrloc.fieldbyname('precocusto').asfloat;
    eestoque.value := qrloc.fieldbyname('estoque_atual').asfloat;
    etotal.value := qrloc.fieldbyname('estoque_atual').asfloat * qrloc.fieldbyname('precocusto').asfloat;

    enomeproduto.text := resultado_pesquisa2;
    eproduto.text := resultado_pesquisa1;
    eestoque.setfocus;
  end;
end;

procedure Tfrminventario_ficha.eestoqueExit(Sender: TObject);
begin
  etotal.value := eestoque.value * ecusto.value;
end;

procedure Tfrminventario_ficha.ecustoExit(Sender: TObject);
begin
  etotal.value := eestoque.value * ecusto.value;
end;

procedure Tfrminventario_ficha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

end.

