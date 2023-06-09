unit produto_atualizapreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, Menus, Buttons, ExtCtrls,
  DB, ZAbstractRODataset, ZDataset, ComCtrls, AdvGlowButton,
  RzPrgres, AdvMetroButton, AdvSmoothExpanderPanel, JvExMask,
  JvToolEdit, JvBaseEdits, ZAbstractDataset, AdvSmoothPanel;

type
  Tfrmproduto_atualizapreco = class(TForm)
    GroupBox1: TGroupBox;
    rproduto: TRadioButton;
    rgrupo: TRadioButton;
    rsubgrupo: TRadioButton;
    rfornecedor: TRadioButton;
    rmarca: TRadioButton;
    PopupMenu1: TPopupMenu;
    Processar1: TMenuItem;
    Fechar1: TMenuItem;
    GPRODUTO: TGroupBox;
    eproduto1: TEdit;
    GroupBox3: TGroupBox;
    eperc: TJvCalcEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    eproduto2: TEdit;
    qrproduto: TZQuery;
    GGRUPO: TGroupBox;
    Label4: TLabel;
    egrupo: TEdit;
    BitBtn1: TBitBtn;
    nomegrupo: TEdit;
    gsubgrupo: TGroupBox;
    Label5: TLabel;
    esubgrupo: TEdit;
    BitBtn3: TBitBtn;
    nomesubgrupo: TEdit;
    gfornecedor: TGroupBox;
    Label6: TLabel;
    efornecedor: TEdit;
    BitBtn4: TBitBtn;
    nomefornecedor: TEdit;
    gmarca: TGroupBox;
    Label7: TLabel;
    emarca: TEdit;
    BitBtn5: TBitBtn;
    nomemarca: TEdit;
    Panel1: TPanel;
    bok: TAdvGlowButton;
    bar: TRzProgressBar;
    Label8: TLabel;
    evalor: TJvCalcEdit;
    AdvSmoothExpanderPanel1: TAdvSmoothExpanderPanel;
    Label105: TLabel;
    AdvMetroButton1: TAdvMetroButton;
    procedure BitBtn2Click(Sender: TObject);
    procedure bokClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure eproduto1KeyPress(Sender: TObject; var Key: Char);
    procedure eproduto2KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure rprodutoClick(Sender: TObject);
    procedure rgrupoClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure rsubgrupoClick(Sender: TObject);
    procedure rfornecedorClick(Sender: TObject);
    procedure rmarcaClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure AdvMetroButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmproduto_atualizapreco: Tfrmproduto_atualizapreco;

implementation

uses
  modulo, xloc_grupo, xloc_subgrupo, xloc_fornecedor, xloc_marca;

{$R *.dfm}

procedure Tfrmproduto_atualizapreco.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmproduto_atualizapreco.bokClick(Sender: TObject);
begin
  if eperc.Value = 0 then
  begin
    application.messagebox('Favor informar o percentual!', 'Aten��o', mb_ok + MB_ICONERROR);
    exit;
  end;
  bar.partscomplete := 0;
  if rproduto.checked then
  begin
    with qrproduto do
    begin
      close;
      sql.clear;
      sql.add('select * from c000025 where atb like :atb and codigo >= ''' + eproduto1.text + ''' and codigo <= ''' + eproduto2.text + '''');
      ParamByName('atb').Value := ME_FiltraATB('TB_PRODUTO');
      open;
      if RECORDCOUNT > 0 then
      begin
        bar.totalparts := recordcount;
        first;
        while not eof do
        begin
          edit;
          if eperc.Value > 0 then
          begin
            fieldbyname('precovenda').asfloat := fieldbyname('PRECOCUSTO').asfloat + (fieldbyname('PRECOCUSTO').asfloat * (eperc.value / 100));
          end
          else if evalor.Value > 0 then
          begin
            fieldbyname('precovenda').asfloat := evalor.Value;
          end;
          post;
          next;
          bar.partscomplete := bar.partscomplete + 1;
        end;
        frmmodulo.Conexao.Commit;
        showmessage('Processamento Conclu�do!');
        bar.partscomplete := 0;
      end
      else
      begin
        APPLICATION.MESSAGEBOX('Nenhum produto encontrado!', 'Aten��o', mb_ok + MB_ICONWARNING);
      end;
    end;
  end;

  if rgrupo.checked then
  begin
    with qrproduto do
    begin
      close;
      sql.clear;
      sql.add('select * from c000025 where atb like :atb and codgrupo = ''' + egrupo.text + '''');
      ParamByName('atb').Value := ME_FiltraATB('TB_PRODUTO');
      open;
      if RECORDCOUNT > 0 then
      begin
        bar.totalparts := recordcount;
        first;
        while not eof do
        begin
          edit;
          if eperc.Value > 0 then
          begin
            fieldbyname('precovenda').asfloat := fieldbyname('precocusto').asfloat + (fieldbyname('precocusto').asfloat * (eperc.value / 100));
          end
          else if evalor.Value > 0 then
          begin
            fieldbyname('precovenda').asfloat := evalor.Value;
          end;
          post;
          next;
          bar.partscomplete := bar.partscomplete + 1;
        end;
        frmmodulo.Conexao.Commit;
        showmessage('Processamento Conclu�do!');
        bar.partscomplete := 0;
      end
      else
      begin
        APPLICATION.MESSAGEBOX('Nenhum produto encontrado!', 'Aten��o', mb_ok + MB_ICONWARNING);
      end;
    end;
  end;

  if rsubgrupo.checked then
  begin
    with qrproduto do
    begin
      close;
      sql.clear;
      sql.add('select * from c000025 where atb like :atb and codsubgrupo = ''' + esubgrupo.text + '''');
      ParamByName('atb').Value := ME_FiltraATB('TB_PRODUTO');
      open;
      if RECORDCOUNT > 0 then
      begin
        bar.totalparts := recordcount;
        first;
        while not eof do
        begin
          edit;
          if eperc.Value > 0 then
          begin
            fieldbyname('precovenda').asfloat := fieldbyname('precovenda').asfloat + (fieldbyname('precovenda').asfloat * (eperc.value / 100));
          end
          else if evalor.Value > 0 then
          begin
            fieldbyname('precovenda').asfloat := evalor.Value;
          end;
          post;
          next;
          bar.partscomplete := bar.partscomplete + 1;
        end;
        frmmodulo.Conexao.Commit;
        showmessage('Processamento Conclu�do!');
        bar.partscomplete := 0;
      end
      else
      begin
        APPLICATION.MESSAGEBOX('Nenhum produto encontrado!', 'Aten��o', mb_ok + MB_ICONWARNING);
      end;
    end;
  end;

  if rmarca.checked then
  begin
    with qrproduto do
    begin
      close;
      sql.clear;
      sql.add('select * from c000025 where atb like :atb and codmarca = ''' + emarca.text + '''');
      ParamByName('atb').Value := ME_FiltraATB('TB_PRODUTO');
      open;
      if RECORDCOUNT > 0 then
      begin
        bar.totalparts := recordcount;
        first;
        while not eof do
        begin
          edit;
          if eperc.Value > 0 then
          begin
            fieldbyname('precovenda').asfloat := fieldbyname('precovenda').asfloat + (fieldbyname('precovenda').asfloat * (eperc.value / 100));
          end
          else if evalor.Value > 0 then
          begin
            fieldbyname('precovenda').asfloat := evalor.Value;
          end;
          post;
          next;
          bar.partscomplete := bar.partscomplete + 1;
        end;
        frmmodulo.Conexao.Commit;
        showmessage('Processamento Conclu�do!');
        bar.partscomplete := 0;
      end
      else
      begin
        APPLICATION.MESSAGEBOX('Nenhum produto encontrado!', 'Aten��o', mb_ok + MB_ICONWARNING);
      end;
    end;
  end;

  if rfornecedor.checked then
  begin
    with qrproduto do
    begin
      close;
      sql.clear;
      sql.add('select * from c000025 where atb like :atb and codfornecedor = ''' + efornecedor.text + '''');
      ParamByName('atb').Value := ME_FiltraATB('TB_PRODUTO');
      open;
      if RECORDCOUNT > 0 then
      begin
        bar.totalparts := recordcount;
        first;
        while not eof do
        begin
          edit;
          if eperc.Value > 0 then
          begin
            fieldbyname('precovenda').asfloat := fieldbyname('precovenda').asfloat + (fieldbyname('precovenda').asfloat * (eperc.value / 100));
          end
          else if evalor.Value > 0 then
          begin
            fieldbyname('precovenda').asfloat := evalor.Value;
          end;
          post;
          next;
          bar.partscomplete := bar.partscomplete + 1;
        end;
        frmmodulo.Conexao.Commit;
        showmessage('Processamento Conclu�do!');
        bar.partscomplete := 0;
      end
      else
      begin
        APPLICATION.MESSAGEBOX('Nenhum produto encontrado!', 'Aten��o', mb_ok + MB_ICONWARNING);
      end;
    end;
  end;
end;

procedure Tfrmproduto_atualizapreco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure Tfrmproduto_atualizapreco.eproduto1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    perform(wm_nextdlgctl, 0, 0);
end;

procedure Tfrmproduto_atualizapreco.eproduto2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    bok.setfocus;
end;

procedure Tfrmproduto_atualizapreco.AdvMetroButton1Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmproduto_atualizapreco.BitBtn1Click(Sender: TObject);
begin
  frmxloc_grupo := tfrmxloc_grupo.create(self);
  frmxloc_grupo.showmodal;
  egrupo.text := resultado_pesquisa1;
  nomegrupo.text := resultado_pesquisa2;

end;

procedure Tfrmproduto_atualizapreco.rprodutoClick(Sender: TObject);
begin
  gproduto.visible := true;
  ggrupo.visible := false;
  gsubgrupo.visible := false;
  gfornecedor.visible := false;
  gmarca.visible := false;

end;

procedure Tfrmproduto_atualizapreco.rgrupoClick(Sender: TObject);
begin
  gproduto.visible := false;
  ggrupo.visible := true;
  gsubgrupo.visible := false;
  gfornecedor.visible := false;
  gmarca.visible := false;

end;

procedure Tfrmproduto_atualizapreco.BitBtn3Click(Sender: TObject);
begin
  frmxloc_subgrupo := tfrmxloc_subgrupo.create(self);
  frmxloc_subgrupo.showmodal;
  esubgrupo.text := resultado_pesquisa1;
  nomesubgrupo.text := resultado_pesquisa2;
end;

procedure Tfrmproduto_atualizapreco.rsubgrupoClick(Sender: TObject);
begin
  gproduto.visible := false;
  ggrupo.visible := false;
  gsubgrupo.visible := true;
  gfornecedor.visible := false;
  gmarca.visible := false;

end;

procedure Tfrmproduto_atualizapreco.rfornecedorClick(Sender: TObject);
begin
  gproduto.visible := false;
  ggrupo.visible := false;
  gsubgrupo.visible := false;
  gfornecedor.visible := true;
  gmarca.visible := false;

end;

procedure Tfrmproduto_atualizapreco.rmarcaClick(Sender: TObject);
begin
  gproduto.visible := false;
  ggrupo.visible := false;
  gsubgrupo.visible := false;
  gfornecedor.visible := false;
  gmarca.visible := true;

end;

procedure Tfrmproduto_atualizapreco.BitBtn4Click(Sender: TObject);
begin
  frmxloc_fornecedor := tfrmxloc_fornecedor.create(self);
  frmxloc_fornecedor.showmodal;
  efornecedor.text := resultado_pesquisa1;
  nomefornecedor.text := resultado_pesquisa2;
end;

procedure Tfrmproduto_atualizapreco.BitBtn5Click(Sender: TObject);
begin
  frmxloc_marca := tfrmxloc_marca.create(self);
  frmxloc_marca.showmodal;
  emarca.text := resultado_pesquisa1;
  nomemarca.text := resultado_pesquisa2;
end;

end.

