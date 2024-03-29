unit os_fechamento_auto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, TFlatPanelUnit, Buttons, Menus,
  DB, ZAbstractRODataset, ZDataset, AdvGlowButton,
  AdvShapeButton, JvExMask, JvToolEdit, JvBaseEdits, ZAbstractDataset;

type
  Tfrmos_fechamento_auto = class(TForm)
    PopupMenu1: TPopupMenu;
    Cancelar1: TMenuItem;
    qrcontasreceber: TZQuery;
    Bevel1: TBevel;
    Shape6: TShape;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edinheiro: TShape;
    echequeav: TShape;
    echequeap: TShape;
    ecartaocred: TShape;
    ecartaodeb: TShape;
    ecrediario: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Label11: TLabel;
    Label12: TLabel;
    Shape15: TShape;
    Shape16: TShape;
    Label13: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    Label14: TLabel;
    Label15: TLabel;
    Panel3: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    AdvShapeButton1: TAdvShapeButton;
    Bevel3: TBevel;
    rdesconto2: TJvCalcEdit;
    racrescimo2: TJvCalcEdit;
    rdesconto1: TJvCalcEdit;
    racrescimo1: TJvCalcEdit;
    Panel1: TPanel;
    rsubtotal: TJvCalcEdit;
    Panel2: TPanel;
    rtotal: TJvCalcEdit;
    rdinheiro: TJvCalcEdit;
    rchequeav: TJvCalcEdit;
    rchequeap: TJvCalcEdit;
    rcartaocred: TJvCalcEdit;
    rcartaodeb: TJvCalcEdit;
    rcrediario: TJvCalcEdit;
    rsoma: TJvCalcEdit;
    rdiferenca: TJvCalcEdit;
    FlatPanel2: TFlatPanel;
    Panel4: TPanel;
    bgravar: TAdvGlowButton;
    bcancelar: TAdvGlowButton;
    Bevel2: TBevel;
    Shape7: TShape;
    rPix: TJvCalcEdit;
    ePix: TShape;
    Label16: TLabel;
    procedure rdesconto1KeyPress(Sender: TObject; var Key: Char);
    procedure racrescimo2KeyPress(Sender: TObject; var Key: Char);
    procedure rdesconto1Enter(Sender: TObject);
    procedure rdesconto1Exit(Sender: TObject);
    procedure rdesconto2Exit(Sender: TObject);
    procedure racrescimo1Exit(Sender: TObject);
    procedure racrescimo2Exit(Sender: TObject);
    procedure rdinheiroExit(Sender: TObject);
    procedure bgravarClick(Sender: TObject);
    procedure bcancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rdinheiroEnter(Sender: TObject);
    procedure rchequeavEnter(Sender: TObject);
    procedure rchequeapEnter(Sender: TObject);
    procedure rcartaocredEnter(Sender: TObject);
    procedure rcartaodebEnter(Sender: TObject);
    procedure rcrediarioEnter(Sender: TObject);
    procedure rcrediarioKeyPress(Sender: TObject; var Key: Char);
    procedure Cancelar1Click(Sender: TObject);
    procedure rchequeavExit(Sender: TObject);
    procedure rchequeapExit(Sender: TObject);
    procedure rcartaocredExit(Sender: TObject);
    procedure rcartaodebExit(Sender: TObject);
    procedure rcrediarioExit(Sender: TObject);
    procedure rPixEnter(Sender: TObject);
    procedure rPixExit(Sender: TObject);
    procedure rPixKeyPress(Sender: TObject; var Key: Char);
  private
    procedure TotalizarTela;
  public
    { Public declarations }
  end;

var
  frmos_fechamento_auto: Tfrmos_fechamento_auto;

implementation

uses
  os_auto, modulo, principal, os_contasreceber_auto, troco, OS_impressao;

{$R *.dfm}

procedure Tfrmos_fechamento_auto.rdesconto1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    perform(wm_nextdlgctl, 0, 0);
end;

procedure Tfrmos_fechamento_auto.racrescimo2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    rdinheiro.SetFocus;
end;

procedure Tfrmos_fechamento_auto.rdesconto1Enter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
end;

procedure Tfrmos_fechamento_auto.rdesconto1Exit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
  if rdesconto1.value <> 0 then
  begin
    rdesconto2.Value := rsubtotal.value * (rdesconto1.Value / 100);
  end
  else
    rdesconto2.value := 0;
  rtotal.value := rsubtotal.value - rdesconto2.value + racrescimo2.Value;
end;

procedure Tfrmos_fechamento_auto.rdesconto2Exit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
  if rsubtotal.value <> 0 then
  begin
    rdesconto1.Value := (rdesconto2.Value * 100) / rsubtotal.value;
  end
  else
    RDESCONTO1.VALUE := 0;
  rtotal.value := rsubtotal.value - rdesconto2.value + racrescimo2.value;
end;

procedure Tfrmos_fechamento_auto.racrescimo1Exit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
  if racrescimo1.value <> 0 then
  begin
    racrescimo2.Value := rsubtotal.value * (racrescimo1.Value / 100);
  end
  else
    RACRESCIMO2.VALUE := 0;
  rtotal.value := rsubtotal.value - rdesconto2.value + racrescimo2.Value;
end;

procedure Tfrmos_fechamento_auto.racrescimo2Exit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
  if rsubtotal.value <> 0 then
  begin
    racrescimo1.Value := (racrescimo2.Value * 100) / rsubtotal.value;
  end
  else
    RACRESCIMO1.VALUE := 0;
  rtotal.value := rsubtotal.value - rdesconto2.value + racrescimo2.value;
end;

procedure Tfrmos_fechamento_auto.rdinheiroExit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
  edinheiro.Brush.Color := clwindow;

  TotalizarTela;
end;

procedure Tfrmos_fechamento_auto.rPixEnter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
  ePix.Brush.Color    := $00A0FAF8;
end;

procedure Tfrmos_fechamento_auto.rPixExit(Sender: TObject);
begin
  tedit(Sender).color    := clwindow;
  ecartaodeb.Brush.Color := clwindow;

  TotalizarTela;
end;

procedure Tfrmos_fechamento_auto.rPixKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    perform(wm_nextdlgctl, 0, 0);
end;

procedure Tfrmos_fechamento_auto.TotalizarTela;
begin
  rsoma.Value := rdinheiro.value + rchequeav.value + rchequeap.Value + rcartaocred.value + rcartaodeb.Value + rcrediario.Value + rPix.Value;
  rdiferenca.Value := rtotal.Value - rsoma.Value;
end;

procedure Tfrmos_fechamento_auto.bgravarClick(Sender: TObject);
var
  texto: PWideChar;
begin
  if (rdinheiro.Value = 0.00) and (rchequeav.Value = 0.00) and (rchequeap.Value = 0.00) and (rcartaocred.Value = 0.00) and (rcartaodeb.Value = 0.00) and (rcrediario.Value = 0.00) and (rPix.Value = 0.00) and (rsoma.Value = 0.00) and (rdiferenca.Value = 0.00) then
  begin
    Exit;
  end;
  try
    FRMMODULO.QRCONFIG.OPEN;
    if rcrediario.Value > 0 then
    begin
      if FRMMODULO.QRCONFIG.FieldByName('VENDA_LIMITE_CLIENTE').ASINTEGER = 1 then
      begin
        if rcrediario.Value > limite_disponivel then
        begin
          texto := PWideChar('Este cliente possue um limite dispon�vel de:' + #13 + ' ---> R$ ' + FLATPANEL2.Caption + '  <--- ' + #13 + '� necess�rio autoriza��o para prosseguir! ' + #13 + 'Deseja continuar?');
          if application.MessageBox(texto, 'Aten��o', mb_yesno + MB_ICONWARNING) = idyes then
          begin
            if not frmPrincipal.autentica('Liberar O.S.', 4) then
            begin
              application.messagebox('Desculpe! Seu acesso n�o foi autorizado!', 'Aviso', mb_ok + MB_ICONERROR);
              rcrediario.SetFocus;
              exit;
            end;
          end
          else
          begin
            rcrediario.SetFocus;
            exit;
          end;
        end;
      end;
    end;

    if rdiferenca.Value <> 0 then
    begin
      if RDINHEIRO.VALUE > RDIFERENCA.VALUE then
      begin
        frmvenda_troco := tfrmvenda_troco.create(self);
        frmvenda_troco.ltroco.caption := FORMATFLOAT('###,###,##0.00', (RDIFERENCA.VALUE) * (-1));
        frmvenda_troco.showmodal;
        RDINHEIRO.VALUE := RDINHEIRO.VALUE + RDIFERENCA.VALUE;
        RDIFERENCA.VALUE := 0;
        APPLICATION.ProcessMessages;
      end
      else
      begin
        application.MessageBox('Os valores informados nas formas de pagamento n�o confere com o valor total desta O.S.! Favor verificar!', 'Aten��o', mb_ok + MB_ICONWARNING);
        rdinheiro.setfocus;
        exit;
      end;
    end;

    CONTINUAR := TRUE;

    frmmodulo.qrconfig.open;
    if frmmodulo.qrconfig.fieldbyname('VENDA_CADASTRO_CHEQUE').asinteger = 1 then
    begin
      // cadastrar cheques

    end;
    if not CONTINUAR then
      EXIT;

    frmmodulo.qrconfig.open;
    if frmmodulo.qrconfig.fieldbyname('VENDA_CADASTRO_CHEQUE').asinteger = 1 then
    begin
      // cadastrar cheques
    end;

    if not CONTINUAR then
      EXIT;

    if rcrediario.Value <> 0 then
    begin
      frmOS_contasreceber_auto := tfrmOS_contasreceber_auto.create(self);
      frmOS_contasreceber_auto.showmodal;
    end;

    if not CONTINUAR then
      EXIT;
    //  LANCAMENTOS ESPECIFICOS DE CADA FORMA DE PAGAMENTO
    frmmodulo.qrcaixa_mov.OPEN;
    frmmodulo.qrconfig.open;

    frmmodulo.qrcaixa_mov.insert;
    frmmodulo.qrcaixa_mov.FieldByName('codigo').asstring      := frmprincipal.codifica('000044');
    frmmodulo.qrcaixa_mov.fieldbyname('codcaixa').asstring    := frmmodulo.qrcaixa_operador.FIELDBYNAME('CODIGO').ASSTRING;
    frmmodulo.qrcaixa_mov.fieldbyname('codoperador').asstring := frmmodulo.qrcaixa_operador.FIELDBYNAME('CODIGO').ASSTRING;
    frmmodulo.qrcaixa_mov.fieldbyname('data').asstring        := frmmodulo.qrcaixa_operador.FIELDBYNAME('DATA').ASSTRING;
    frmmodulo.qrcaixa_mov.fieldbyname('saida').asfloat        := 0;


    if rdinheiro.Value <> 0 then
    begin
      frmmodulo.qrcaixa_mov.fieldbyname('entrada').asfloat     := rdinheiro.value;
      frmmodulo.qrcaixa_mov.FieldByName('valor').asfloat       := rdinheiro.value;
      frmmodulo.qrcaixa_mov.fieldbyname('codconta').asstring   := frmmodulo.qrconfig.fieldbyname('PLANO_OS_AV').asstring;
      frmmodulo.qrcaixa_mov.fieldbyname('movimento').asINTEGER := 18; // os em dinheiro
    end;
    if rchequeav.Value <> 0 then
    begin
      frmmodulo.qrcaixa_mov.fieldbyname('entrada').asfloat     := 0;
      frmmodulo.qrcaixa_mov.FieldByName('valor').asfloat       := rchequeav.value;
      frmmodulo.qrcaixa_mov.fieldbyname('codconta').asstring   := frmmodulo.qrconfig.fieldbyname('PLANO_OS_AV').asstring;
      frmmodulo.qrcaixa_mov.fieldbyname('movimento').asINTEGER := 20; // os em cheque a vista
    end;
    if rchequeap.Value <> 0 then
    begin
      frmmodulo.qrcaixa_mov.fieldbyname('entrada').asfloat     := 0;
      frmmodulo.qrcaixa_mov.FieldByName('valor').asfloat       := rchequeap.value;
      frmmodulo.qrcaixa_mov.fieldbyname('codconta').asstring   := frmmodulo.qrconfig.fieldbyname('PLANO_OS_AP').asstring;
      frmmodulo.qrcaixa_mov.fieldbyname('movimento').asINTEGER := 21; // os em cheque a prazo
    end;
    if rcartaocred.Value <> 0 then
    begin
      frmmodulo.qrcaixa_mov.fieldbyname('entrada').asfloat     := 0;
      frmmodulo.qrcaixa_mov.FieldByName('valor').asfloat       := rcartaocred.value;
      frmmodulo.qrcaixa_mov.fieldbyname('codconta').asstring   := frmmodulo.qrconfig.fieldbyname('PLANO_OS_AP').asstring;
      frmmodulo.qrcaixa_mov.fieldbyname('movimento').asINTEGER := 22; // os em cartao de credito
    end;
    if rcartaodeb.Value <> 0 then
    begin
      frmmodulo.qrcaixa_mov.fieldbyname('entrada').asfloat     := 0;
      frmmodulo.qrcaixa_mov.FieldByName('valor').asfloat       := rcartaoDEB.value;
      frmmodulo.qrcaixa_mov.fieldbyname('codconta').asstring   := frmmodulo.qrconfig.fieldbyname('PLANO_OS_AP').asstring;
      frmmodulo.qrcaixa_mov.fieldbyname('movimento').asINTEGER := 23; // os em cartao de credito
    end;
    if rcrediario.Value <> 0 then
    begin
      frmmodulo.qrcaixa_mov.fieldbyname('entrada').asfloat     := 0;
      frmmodulo.qrcaixa_mov.FieldByName('valor').asfloat       := rcrediario.value;
      frmmodulo.qrcaixa_mov.fieldbyname('codconta').asstring   := frmmodulo.qrconfig.fieldbyname('PLANO_OS_AP').asstring;
      frmmodulo.qrcaixa_mov.fieldbyname('movimento').asINTEGER := 19; // os em CREDIARIO
      // lancamento do contas a receber

      frmmodulo.qrcontasreceber.open;
      if rdinheiro.value <> 0 then
      begin
        frmmodulo.qrcontasreceber.insert;
        frmmodulo.qrcontasreceber.fieldbyname('codigo').asstring := FRMMODULO.cdsos.FIELDBYNAME('CODIGO').ASSTRING + 's00';
        frmmodulo.qrcontasreceber.fieldbyname('codvenda').asstring := FRMMODULO.cdsos.FIELDBYNAME('CODIGO').ASSTRING + 's';
        frmmodulo.qrcontasreceber.fieldbyname('codcliente').asstring := FRMMODULO.cdsos.FIELDBYNAME('CODCLIENTE').ASSTRING;
        frmmodulo.qrcontasreceber.fieldbyname('codvendedor').asstring := FRMMODULO.cdsos.FIELDBYNAME('CODATENDENTE').ASSTRING;
        frmmodulo.qrcontasreceber.fieldbyname('codcaixa').asstring := frmmodulo.qrcaixa_operador.FIELDBYNAME('CODIGO').ASSTRING;
        frmmodulo.qrcontasreceber.fieldbyname('data_emissao').asstring := FRMMODULO.cdsos.FIELDBYNAME('DATA').ASSTRING;
        frmmodulo.qrcontasreceber.fieldbyname('data_vencimento').asstring := FRMMODULO.cdsos.FIELDBYNAME('DATA').ASSTRING;
        frmmodulo.qrcontasreceber.fieldbyname('valor_original').asfloat := RDINHEIRO.VALUE;
        frmmodulo.qrcontasreceber.fieldbyname('valor_pago').asfloat := RDINHEIRO.VALUE;
        frmmodulo.qrcontasreceber.fieldbyname('valor_atual').asfloat := 0;
        frmmodulo.qrcontasreceber.fieldbyname('documento').asstring := 'ENTRADA';
        frmmodulo.qrcontasreceber.fieldbyname('tipo').asstring := frmOS_auto.qrOS_contasreceber.fieldbyname('tipo').asstring;
        frmmodulo.qrcontasreceber.FieldByName('situacao').asinteger := 2;
        frmmodulo.qrcontasreceber.FieldByName('filtro').asinteger := 0;
        frmmodulo.qrcontasreceber.post;
      end;
      frmos_auto.qros_contasreceber.First;
      while not frmos_auto.qros_contasreceber.eof do
      begin
        frmmodulo.qrcontasreceber.insert;
        frmmodulo.qrcontasreceber.fieldbyname('codigo').asstring := FRMMODULO.cdsos.FIELDBYNAME('CODIGO').ASSTRING + 's' + frmprincipal.zerarcodigo(frmos_auto.qrOS_contasreceber.fieldbyname('prestacao').asstring, 2);
        frmmodulo.qrcontasreceber.fieldbyname('codvenda').asstring := FRMMODULO.cdsos.FIELDBYNAME('CODIGO').ASSTRING + 's';
        frmmodulo.qrcontasreceber.fieldbyname('codcliente').asstring := FRMMODULO.cdsos.FIELDBYNAME('CODCLIENTE').ASSTRING;
        frmmodulo.qrcontasreceber.fieldbyname('codvendedor').asstring := FRMMODULO.cdsos.FIELDBYNAME('CODATENDENTE').ASSTRING;
        frmmodulo.qrcontasreceber.fieldbyname('codcaixa').asstring := frmmodulo.qrcaixa_operador.FIELDBYNAME('CODIGO').ASSTRING;
        frmmodulo.qrcontasreceber.fieldbyname('data_emissao').asstring := FRMMODULO.cdsos.FIELDBYNAME('DATA').ASSTRING;
        frmmodulo.qrcontasreceber.fieldbyname('data_vencimento').asstring := frmos_auto.qrOS_contasreceber.fieldbyname('vencimento').asstring;
        frmmodulo.qrcontasreceber.fieldbyname('valor_original').asfloat := frmos_auto.qrOS_contasreceber.fieldbyname('valor').asfloat;
        frmmodulo.qrcontasreceber.fieldbyname('valor_atual').asfloat := frmos_auto.qrOS_contasreceber.fieldbyname('valor').asfloat;
        frmmodulo.qrcontasreceber.fieldbyname('documento').asstring := frmos_auto.qrOS_contasreceber.fieldbyname('documento').asstring;
        frmmodulo.qrcontasreceber.fieldbyname('tipo').asstring := frmos_auto.qrOS_contasreceber.fieldbyname('tipo').asstring;
        frmmodulo.qrcontasreceber.FieldByName('situacao').asinteger := 1;
        frmmodulo.qrcontasreceber.FieldByName('filtro').asinteger := 0;
        frmmodulo.qrcontasreceber.post;
        frmos_auto.qrOS_contasreceber.next;
      end;
    end;
    if rPix.Value <> 0 then
    begin
      frmmodulo.qrcaixa_mov.fieldbyname('entrada').asfloat     := 0;
      frmmodulo.qrcaixa_mov.FieldByName('valor').asfloat       := rcrediario.value;
      frmmodulo.qrcaixa_mov.fieldbyname('codconta').asstring   := frmmodulo.qrconfig.fieldbyname('PLANO_OS_AV').asstring;
      frmmodulo.qrcaixa_mov.fieldbyname('movimento').asINTEGER := 44; // os em Pix
    end;

    frmmodulo.qrcaixa_mov.fieldbyname('historico').asstring := 'O.S. No. ' + FRMMODULO.cdsos.FIELDBYNAME('CODIGO').ASSTRING + ' - ' + FRMMODULO.cdsos.FIELDBYNAME('CLIENTE').ASSTRING;
    frmmodulo.qrcaixa_mov.post;

    frmmodulo.cdsos.fieldbyname('TOTAL').asfloat           := rtotal.value;
    frmmodulo.cdsos.fieldbyname('SUBTOTAL').asfloat        := rsubtotal.value;
    FRMMODULO.cdsos.FIELDBYNAME('meio_dinheiro').asfloat   := rdinheiro.Value;
    FRMMODULO.cdsos.FIELDBYNAME('meio_chequeav').asfloat   := rchequeav.Value;
    FRMMODULO.cdsos.FIELDBYNAME('meio_chequeap').asfloat   := rchequeap.Value;
    FRMMODULO.cdsos.FIELDBYNAME('meio_cartaocred').asfloat := rcartaocred.Value;
    FRMMODULO.cdsos.FIELDBYNAME('meio_cartaodeb').asfloat  := rcartaodeb.Value;
    FRMMODULO.cdsos.FIELDBYNAME('meio_crediario').asfloat  := rcrediario.Value;
    FRMMODULO.cdsos.FIELDBYNAME('meio_pix').AsFloat        := rPix.Value;
    FRMMODULO.cdsos.FIELDBYNAME('desconto').asfloat        := rdesconto2.Value;
    FRMMODULO.cdsos.FIELDBYNAME('acrescimo').asfloat       := racrescimo2.Value;
    FRMMODULO.cdsos.FIELDBYNAME('CODCAIXA').ASSTRING       := frmmodulo.qrcaixa_operador.FIELDBYNAME('CODIGO').ASSTRING;
    FRMMODULO.cdsos.FIELDBYNAME('SITUACAO').ASSTRING       := 'FECHADA';
    FRMMODULO.cdsos.FIELDBYNAME('ST').ASSTRING             := '4';

    if cupom_fiscal then
    begin
      frmmodulo.cdsos.fieldbyname('cupomfiscal').asinteger := 1;
      frmmodulo.cdsos.fieldbyname('NUMERO_cupom_fiscal').asstring := nxcupom;
    end;
    frmmodulo.cdsos.post;
    frmmodulo.cdsos.ApplyUpdates(-1);
    FRMMODULO.QRCLIENTE.Locate('CODIGO', FRMMODULO.cdsos.FIELDBYNAME('CODCLIENTE').ASSTRING, [loCaseInsensitive]);

    frmos_impressao := tfrmos_impressao.create(self);
    frmos_impressao.showmodal;

    frmmodulo.Conexao.Commit;
    finalizado := true;
    close;
    frmos_auto.Close;
  except
    application.MessageBox('Esta O.S. n�o poder ser conclu�da por ter gerado erros! Todos os lan�amentos feitos nela ser�o cancelados!', 'Erro', mb_ok + MB_ICONERROR);
    FRMMODULO.cdsos.Cancel;
    frmmodulo.Conexao.Rollback;
    close;
    finalizado := true;
    frmos_auto.close;
  end;

end;

procedure Tfrmos_fechamento_auto.bcancelarClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmos_fechamento_auto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure Tfrmos_fechamento_auto.FormShow(Sender: TObject);
var
  LIMITE: REAL;
begin
  qrcontasreceber.close;
  qrcontasreceber.sql.clear;
  qrcontasreceber.sql.add('select SUM(VALOR_ATUAL) TOTAL_CLIENTE from c000049 where atb like :atb and codcliente = ''' + frmmodulo.cdsos.fieldbyname('codcliente').asstring + ''' and situacao = 1');
  qrcontasreceber.ParamByName('atb').Value := ME_FiltraATB('TB_CONTA_RECEBER');
  qrcontasreceber.Open;

  limite_disponivel := (FRMMODULO.qrcliente.FIELDBYNAME('LIMITE').ASFLOAT - QRCONTASRECEBER.FIELDBYNAME('TOTAL_CLIENTE').ASFLOAT);

  LIMITE := (FRMMODULO.qrcliente.FIELDBYNAME('LIMITE').ASFLOAT - QRCONTASRECEBER.FIELDBYNAME('TOTAL_CLIENTE').ASFLOAT);
  if LIMITE > 0 then
    FLATPANEL2.Font.COLOR := CLBLACK
  else
    FLATPANEL2.Font.COLOR := CLRED;
  FLATPANEL2.CAPTION := 'R$ ' + formatfloat('###,###,##0.00', LIMITE);

  rsubtotal.value := frmmodulo.cdsos.fieldbyname('subtotal').asfloat;
  rtotal.value := frmmodulo.cdsos.fieldbyname('total').asfloat;
  rdesconto1.SetFocus;
end;

procedure Tfrmos_fechamento_auto.rdinheiroEnter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
  edinheiro.Brush.Color := $00A0FAF8;
end;

procedure Tfrmos_fechamento_auto.rchequeavEnter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
  echequeav.Brush.Color := $00A0FAF8;
end;

procedure Tfrmos_fechamento_auto.rchequeapEnter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
  echequeap.Brush.Color := $00A0FAF8;
end;

procedure Tfrmos_fechamento_auto.rcartaocredEnter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
  ecartaocred.Brush.Color := $00A0FAF8;
end;

procedure Tfrmos_fechamento_auto.rcartaodebEnter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
  ecartaodeb.Brush.Color := $00A0FAF8;
end;

procedure Tfrmos_fechamento_auto.rcrediarioEnter(Sender: TObject);
begin
  tedit(Sender).Color := $00A0FAF8;
  ecrediario.Brush.Color := $00A0FAF8;
end;

procedure Tfrmos_fechamento_auto.rcrediarioKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    bgravar.setfocus;
end;

procedure Tfrmos_fechamento_auto.Cancelar1Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmos_fechamento_auto.rchequeavExit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
  echequeav.Brush.Color := clwindow;

  TotalizarTela;
end;

procedure Tfrmos_fechamento_auto.rchequeapExit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
  echequeap.Brush.Color := clwindow;

  TotalizarTela;
end;

procedure Tfrmos_fechamento_auto.rcartaocredExit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
  ecartaocred.Brush.Color := clwindow;

  TotalizarTela;
end;

procedure Tfrmos_fechamento_auto.rcartaodebExit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
  ecartaodeb.Brush.Color := clwindow;

  TotalizarTela;
end;

procedure Tfrmos_fechamento_auto.rcrediarioExit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
  ecrediario.Brush.Color := clwindow;

  TotalizarTela;
end;

end.

