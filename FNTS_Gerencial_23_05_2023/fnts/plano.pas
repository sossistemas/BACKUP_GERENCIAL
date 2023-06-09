unit plano;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Buttons, TFlatPanelUnit,
  Menus, DB, ZAbstractRODataset, ZDataset, Grids, DBGrids,
  Mask, maskutils, wwdbedit, Wwdotdot, Wwdbcomb, PageView, ImgList, ComCtrls,
  AdvGlowButton, UCBase, dxGDIPlusClasses,
  AdvMetroButton, AdvSmoothExpanderPanel, System.ImageList, ZAbstractDataset,
  AdvSmoothPanel;

type
  Tfrmplano = class(TForm)
    Pop1: TPopupMenu;
    Incluir1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    Localizar1: TMenuItem;
    Fechar1: TMenuItem;
    Pop2: TPopupMenu;
    Gravar1: TMenuItem;
    Cancelar1: TMenuItem;
    dsplano2: TDataSource;
    Relatrios1: TMenuItem;
    Regies1: TMenuItem;
    query1: TZQuery;
    PageView1: TPageView;
    PageSheet1: TPageSheet;
    PageSheet2: TPageSheet;
    pficha: TFlatPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    COMBOGRUPO: TwwDBComboBox;
    DBEdit3: TDBEdit;
    DBEdit28: TDBEdit;
    bloc: TBitBtn;
    DBEdit30: TDBEdit;
    N1: TMenuItem;
    FichadeCadastro1: TMenuItem;
    Visualizaoemrvore1: TMenuItem;
    arvore: TTreeView;
    ImageList1: TImageList;
    Panel2: TPanel;
    bincluir: TAdvGlowButton;
    balterar: TAdvGlowButton;
    bexcluir: TAdvGlowButton;
    blocalizar: TAdvGlowButton;
    DBAdvGlowButton1: TDBAdvGlowButton;
    DBAdvGlowButton2: TDBAdvGlowButton;
    DBAdvGlowButton3: TDBAdvGlowButton;
    DBAdvGlowButton4: TDBAdvGlowButton;
    bitbtn5: TAdvGlowButton;
    pgravar: TFlatPanel;
    bgravar: TAdvGlowButton;
    bcancelar: TAdvGlowButton;
    UCControls1: TUCControls;
    AdvSmoothExpanderPanel1: TAdvSmoothExpanderPanel;
    Label20: TLabel;
    AdvMetroButton1: TAdvMetroButton;
    Panel1: TPanel;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
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
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure etipoExit(Sender: TObject);
    procedure edata_cadastroEnter(Sender: TObject);
    procedure elimiteKeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit1Enter(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure RxDBCalcEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DBEdit4Exit(Sender: TObject);
    procedure ERENDAKeyPress(Sender: TObject; var Key: Char);
    procedure COMBOGRUPOEnter(Sender: TObject);
    procedure COMBOGRUPOExit(Sender: TObject);
    procedure blocClick(Sender: TObject);
    procedure DBEdit28Exit(Sender: TObject);
    procedure DBEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure Visualizaoemrvore1Click(Sender: TObject);
    procedure FichadeCadastro1Click(Sender: TObject);
    procedure PageView1Change(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure W7ActiveLabel1Click(Sender: TObject);
    procedure W7ActiveLabel2Click(Sender: TObject);
    procedure cySpeedButton1Click(Sender: TObject);
    procedure cySpeedButton2Click(Sender: TObject);
    procedure AdvMetroButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmplano: Tfrmplano;
  comando: string;

implementation

uses
  modulo, principal, xloc_conta, lista_planocontas2;

{$R *.dfm}

procedure Tfrmplano.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure Tfrmplano.FormShow(Sender: TObject);
begin

  pgravar.visible := false;
  pgravar.Align := alClient;

  frmmodulo.qrplano.close;
  frmmodulo.qrplano.SQL.clear;
  frmmodulo.qrplano.SQL.add('select * from c000035 where atb like :atb order by conta');
  frmmodulo.qrplano.open;
  frmmodulo.qrplano.first;

  pficha.Enabled := false;
end;

procedure Tfrmplano.enomeEnter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
end;

procedure Tfrmplano.enomeExit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;
end;

procedure Tfrmplano.bincluirClick(Sender: TObject);
begin
  if bincluir.Enabled = false then
    exit;

  PageView1.activepageindex := 0;

  COMBOGRUPO.Enabled := true;
  bloc.Enabled := true;
  frmmodulo.qrplano.insert;
  frmmodulo.qrplano.fieldbyname('codigo').asstring := frmprincipal.codifica('000035');
  pficha.Enabled := true;
  pgravar.visible := true;
  PopupMenu := Pop2;
  COMBOGRUPO.setfocus;

end;

procedure Tfrmplano.AdvMetroButton1Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmplano.balterarClick(Sender: TObject);
begin

  if balterar.Enabled = false then
    exit;
  PageView1.activepageindex := 0;
  if DBEdit1.Text <> '' then
  begin
    COMBOGRUPO.Enabled := false;
    bloc.Enabled := false;

    frmmodulo.qrplano.Edit;

    pficha.Enabled := true;

    DBEdit2.setfocus;
    pgravar.visible := true;
    PopupMenu := Pop2;

  end
  else
  begin
    Showmessage('Nenhum registro foi selecionado!');
  end;

end;

procedure Tfrmplano.bexcluirClick(Sender: TObject);
begin
  if balterar.Enabled = false then
    exit;
  if frmprincipal.autentica('Excluir plano', 4) then
  begin
    if frmmodulo.qrplano.fieldbyname('NIVEL').ASINTEGER = 1 then
    begin
      Application.MESSAGEBOX('Conta de N�vel Superior do Sistema! Imposs�vel excluir!', 'Aten��o', mb_ok + MB_ICONerror);
      exit;
    end;
    if frmmodulo.qrplano.fieldbyname('NIVEL').ASINTEGER = 2 then
    begin
      if Application.MESSAGEBOX('Esta conta � um subgrupo. Caso voc� exclua esta conta, todas as contas dentro dela ser�o exclu�das! Deseja prosseguir?', 'Aten��o', mb_yesno + MB_ICONWARNING + MB_DEFBUTTON2) = idyes then
      begin
        query1.close;
        query1.SQL.clear;
        query1.SQL.add('delete from c000035 where atb like :atb and codgrupo =''' + frmmodulo.qrplano.fieldbyname('codigo').asstring + '''');
        query1.ParamByName('atb').Value := ME_FiltraATB('TB_PLANO_CONTA');
        query1.ExecSQL;

        frmprincipal.logUC('Excluiu Plano de Contas - ' + DBEdit2.Text, 3);
        frmmodulo.qrplano.Delete;
        frmmodulo.Conexao.commit;
      end;
    end;
    if frmmodulo.qrplano.fieldbyname('NIVEL').ASINTEGER = 3 then
    begin
      frmprincipal.logUC('Excluiu Plano de Contas - ' + DBEdit2.Text, 3);
      frmmodulo.qrplano.Delete;
      frmmodulo.Conexao.commit;
    end;
  end
  else
  begin
    Application.MESSAGEBOX('Acesso n�o permitido!', 'Erro!', mb_ok + MB_ICONerror);
  end;
end;

procedure Tfrmplano.blocalizarClick(Sender: TObject);
begin
  frmxloc_CONTA := tfrmxloc_CONTA.create(self);
  frmxloc_CONTA.showmodal;
  if resultado_pesquisa1 <> '' then
  begin
    frmmodulo.qrplano.Locate('codigo', resultado_pesquisa1, [loCaseInsensitive]);
  end;
end;

procedure Tfrmplano.bfecharClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmplano.bgravarClick(Sender: TObject);
var
  situacao, tipo: integer;
  DATA: string;
begin

  if DBEdit2.Text = '' then
  begin
    Application.MESSAGEBOX('Favor informar o nome da conta!', 'Aten��o', mb_ok + MB_ICONerror);
    DBEdit2.setfocus;
    exit;
  end;

  if frmmodulo.qrplano.State = dsinsert then
  begin
    if COMBOGRUPO.ItemIndex = 0 then
    begin
      frmmodulo.qrplano.fieldbyname('TIPO').ASINTEGER := 2;
    end
    else
    begin
      frmmodulo.qrplano.fieldbyname('TIPO').ASINTEGER := 1;
    end;
    if Length(frmmodulo.qrplano.fieldbyname('CLASSIFICACAO').asstring) > 4 then
      frmmodulo.qrplano.fieldbyname('NIVEL').ASINTEGER := 3
    else
      frmmodulo.qrplano.fieldbyname('NIVEL').ASINTEGER := 2;
  end;

  if (frmmodulo.qrplano.State = dsinsert) then
  begin
    frmprincipal.logUC('Incluiu Plano de Contas - ' + DBEdit2.Text, 1);
    frmmodulo.qrplano.post;
  end;

  if (frmmodulo.qrplano.State = dsedit) then
  begin
    frmprincipal.logUC('Alterou Plano de Contas - ' + DBEdit2.Text, 2);
    frmmodulo.qrplano.post;
  end;

  frmmodulo.Conexao.commit;
  pficha.Enabled := false;
  pgravar.visible := false;
  PopupMenu := Pop1;

end;

procedure Tfrmplano.bcancelarClick(Sender: TObject);
begin
  if (frmmodulo.qrplano.State = dsinsert) or (frmmodulo.qrplano.State = dsedit) then
  begin
    if (frmmodulo.qrplano.State = dsinsert) then
    begin
      frmprincipal.qrmestre.close;
      frmprincipal.qrmestre.SQL.clear;
      frmprincipal.qrmestre.SQL.add('update c000000 set sequencia = sequencia - 1 where codigo = ''000035''');
      frmprincipal.qrmestre.ExecSQL;
    end;

    frmmodulo.qrplano.cancel;
  end;

  pficha.Enabled := false;
  pgravar.visible := false;
  PopupMenu := Pop1;
  comando := '';
end;

procedure Tfrmplano.enomeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    PERFORM(WM_NEXTDLGCTL, 0, 0);
end;

procedure Tfrmplano.BitBtn1Click(Sender: TObject);
begin
  frmmodulo.qrplano.first;
end;

procedure Tfrmplano.BitBtn2Click(Sender: TObject);
begin
  frmmodulo.qrplano.last;
end;

procedure Tfrmplano.BitBtn3Click(Sender: TObject);
begin
  frmmodulo.qrplano.prior;
end;

procedure Tfrmplano.BitBtn4Click(Sender: TObject);
begin
  frmmodulo.qrplano.next;
end;

procedure Tfrmplano.etipoExit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;
end;

procedure Tfrmplano.edata_cadastroEnter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
  if frmmodulo.qrplano.State = dsinsert then

end;

procedure Tfrmplano.elimiteKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    bgravar.setfocus;
end;

procedure Tfrmplano.DBEdit1Enter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
end;

procedure Tfrmplano.DBEdit1Exit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;

end;

procedure Tfrmplano.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    PERFORM(WM_NEXTDLGCTL, 0, 0);
end;

procedure Tfrmplano.RxDBCalcEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    bgravar.setfocus;
end;

procedure Tfrmplano.DateEdit1Exit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;
end;

procedure Tfrmplano.DBEdit4Exit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;
end;

procedure Tfrmplano.ERENDAKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    bgravar.setfocus;
end;

procedure Tfrmplano.COMBOGRUPOEnter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
end;

procedure Tfrmplano.COMBOGRUPOExit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;
end;

procedure Tfrmplano.cySpeedButton1Click(Sender: TObject);
begin
  PageView1.ActivePageIndex := 0;
end;

procedure Tfrmplano.cySpeedButton2Click(Sender: TObject);
begin
  PageView1.ActivePageIndex := 1;
end;

procedure Tfrmplano.blocClick(Sender: TObject);
var
  conta: string;
begin
  if (frmmodulo.qrplano.State = dsinsert) or (frmmodulo.qrplano.State = dsedit) then
  begin
    if COMBOGRUPO.ItemIndex = 0 then
      parametro_pesquisa := ' and tipo = 2 and nivel < 3 '
    else
      parametro_pesquisa := ' and tipo = 1 and nivel < 3 ';
    frmxloc_CONTA := tfrmxloc_CONTA.create(self);
    frmxloc_CONTA.showmodal;
    if resultado_pesquisa1 <> '' then
    begin

      if resultado_pesquisa2 = '2' then
      begin
        frmmodulo.qrplano.fieldbyname('codgrupo').asstring := resultado_pesquisa1;
        query1.close;
        query1.SQL.clear;
        query1.SQL.add('select * from c000035 where atb like :atb and classificacao like ''' + resultado_pesquisa3 + '%'' and nivel = 3 order by classificacao');
        query1.ParamByName('atb').Value := ME_FiltraATB('TB_PLANO_CONTA');
        query1.open;
        if query1.RecordCount > 0 then
        begin
          query1.last;
          conta := copy(query1.fieldbyname('classificacao').asstring, 6, 3);
          conta := resultado_pesquisa3 + '.' + frmprincipal.texto_justifica(inttostr(strtoint(conta) + 1), 3, '0', 'E');
        end
        else
        begin
          conta := resultado_pesquisa3 + '.001';
        end;
        frmmodulo.qrplano.fieldbyname('classificacao').asstring := conta;

        DBEdit2.setfocus;
      end
      else
      begin
        Application.MESSAGEBOX('Conta inv�lida para subgrupo!', 'Aten��o', mb_ok + MB_ICONWARNING);
      end;

    end
    else
    begin

      query1.close;
      query1.SQL.clear;
      if COMBOGRUPO.ItemIndex = 0 then
        query1.SQL.add('select * from c000035 where atb like :atb and classificacao like ''2%'' and nivel = 2 order by classificacao');
      if COMBOGRUPO.ItemIndex = 1 then
        query1.SQL.add('select * from c000035 where atb like :atb and classificacao like ''1%'' and nivel = 2 order by classificacao');
      query1.ParamByName('atb').Value := ME_FiltraATB('TB_PLANO_CONTA');
      query1.open;
      if query1.RecordCount > 0 then
      begin
        query1.last;
        conta := copy(query1.fieldbyname('classificacao').asstring, 3, 2);
        if COMBOGRUPO.ItemIndex = 0 then
          conta := '2.' + frmprincipal.texto_justifica(inttostr(strtoint(conta) + 1), 2, '0', 'E');
        if COMBOGRUPO.ItemIndex = 1 then
          conta := '1.' + frmprincipal.texto_justifica(inttostr(strtoint(conta) + 1), 2, '0', 'E');
      end
      else
      begin
        if COMBOGRUPO.ItemIndex = 0 then
          conta := '2.01';
        if COMBOGRUPO.ItemIndex = 1 then
          conta := '1.01';

      end;
      frmmodulo.qrplano.fieldbyname('classificacao').asstring := conta;
      DBEdit2.setfocus;
    end;
  end;
  parametro_pesquisa := '';
end;

procedure Tfrmplano.DBEdit28Exit(Sender: TObject);
begin
  tedit(Sender).Color := clwindow;
end;

procedure Tfrmplano.DBEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    bgravar.setfocus;
end;

procedure Tfrmplano.Visualizaoemrvore1Click(Sender: TObject);
begin
  PageView1.activepageindex := 1;
end;

procedure Tfrmplano.W7ActiveLabel1Click(Sender: TObject);
begin
  PageView1.ActivePageIndex := 0;
end;

procedure Tfrmplano.W7ActiveLabel2Click(Sender: TObject);
begin
  PageView1.ActivePageIndex := 1;
end;

procedure Tfrmplano.FichadeCadastro1Click(Sender: TObject);
begin
  PageView1.activepageindex := 0;
end;

procedure Tfrmplano.PageView1Change(Sender: TObject);
var
  item: integer;
  texto: string;
  topo: TTreeNode;
begin

  if PageView1.activepageindex = 0 then
  begin

  end;

  if PageView1.activepageindex = 1 then
  begin

    query1.close;
    query1.SQL.clear;
    query1.SQL.add('select * from c000035 where atb like :atb order by classificacao');
    query1.ParamByName('atb').Value := ME_FiltraATB('TB_PLANO_CONTA');
    query1.open;

    arvore.Items.clear;

    query1.first;
    while not query1.eof do
    begin
      texto := query1.fieldbyname('classificacao').asstring;
      if Length(texto) = 1 then
      begin
        with arvore.Items.AddChild(nil, query1.fieldbyname('classificacao').asstring + ' ' + query1.fieldbyname('conta').asstring) do
        begin
          SelectedIndex := query1.fieldbyname('tipo').ASINTEGER;
          ImageIndex := query1.fieldbyname('tipo').ASINTEGER;
          Selected := true;
          topo := arvore.Selected;
        end;
      end;
      if Length(texto) = 4 then
      begin
        with arvore.Items.AddChild(topo, query1.fieldbyname('classificacao').asstring + ' ' + query1.fieldbyname('conta').asstring) do
        begin
          if query1.fieldbyname('tipo').ASINTEGER = 1 then
          begin
            SelectedIndex := 6;
            ImageIndex := 6;
          end
          else
          begin
            SelectedIndex := 5;
            ImageIndex := 5;
          end;
          Selected := true;
        end;
      end;
      if Length(texto) = 8 then
      begin
        with arvore.Items.AddChild(arvore.Selected, query1.fieldbyname('classificacao').asstring + ' ' + query1.fieldbyname('conta').asstring) do
        begin
          if query1.fieldbyname('tipo').ASINTEGER = 1 then
          begin
            SelectedIndex := 3;
            ImageIndex := 3;
          end
          else
          begin
            SelectedIndex := 4;
            ImageIndex := 4;
          end;
        end;
      end;
      query1.next;
    end;

  end;

end;

procedure Tfrmplano.BitBtn5Click(Sender: TObject);
begin
  frmlista_planocontas2 := tfrmlista_planocontas2.create(self);
  frmlista_planocontas2.showmodal;
end;

end.

