unit xloc_cheque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, ExtCtrls,
  TFlatPanelUnit, Menus, Grids, Wwdbigrd, Wwdbgrid, DB, ZAbstractRODataset,
  ZDataset, ZAbstractDataset;

type
  Tfrmxloc_cheque = class(TForm)
    FlatPanel1: TFlatPanel;
    combo_localizar: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    combo_referencia: TComboBox;
    Bevel1: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    loc: TEdit;
    PopupMenu1: TPopupMenu;
    Localizarpor1: TMenuItem;
    Referncia1: TMenuItem;
    ParmetrosdaPesquisa1: TMenuItem;
    GRID: TwwDBGrid;
    ds: TDataSource;
    query: TZQuery;
    Bevel2: TBevel;
    Label7: TLabel;
    lvoltar: TLabel;
    N1: TMenuItem;
    Fechar1: TMenuItem;
    Bevel3: TBevel;
    queryCODIGO: TWideStringField;
    qrinventarioEMISSAO: TDateField;
    qrinventarioVENCIMENTO: TDateField;
    qrinventarioDATA_DEPOSITO1: TDateField;
    qrinventarioDATA_DEPOSITO2: TDateField;
    qrinventarioDATA_DEVOLUCAO1: TDateField;
    qrinventarioDATA_DEVOLUCAO2: TDateField;
    querySITUACAO: TIntegerField;
    queryCODCLIENTE: TWideStringField;
    queryTITULAR: TWideStringField;
    queryCODBANCO: TWideStringField;
    queryAGENCIA: TWideStringField;
    queryCONTA: TWideStringField;
    qrinventarioDATA_CONTA: TDateField;
    queryNUMERO: TWideStringField;
    queryVALOR: TFloatField;
    queryDESCONTO: TFloatField;
    queryLIQUIDO: TFloatField;
    queryCODVENDA: TWideStringField;
    queryOBS1: TWideStringField;
    queryOBS2: TWideStringField;
    queryCODCONTAS_PAGAR: TWideStringField;
    queryDESTINO: TWideStringField;
    qrinventarioDATA_BAIXA: TDateField;
    queryCODCONTA_CORRENTE: TWideStringField;
    queryCODCONTA: TWideStringField;
    procedure Localizarpor1Click(Sender: TObject);
    procedure Referncia1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Fechar1Click(Sender: TObject);
    procedure locKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GRIDKeyPress(Sender: TObject; var Key: Char);
    procedure locKeyPress(Sender: TObject; var Key: Char);
    procedure locEnter(Sender: TObject);
    procedure locExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GRIDEnter(Sender: TObject);
    procedure GRIDExit(Sender: TObject);
    procedure locChange(Sender: TObject);
    procedure GRIDDblClick(Sender: TObject);
    procedure ParmetrosdaPesquisa1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmxloc_cheque: Tfrmxloc_cheque;
  voltar: boolean;

implementation

uses
  modulo;

{$R *.dfm}

procedure Tfrmxloc_cheque.Localizarpor1Click(Sender: TObject);
var
  X: INTEGER;
begin
  X := combo_localizar.Items.Count - 1;
  if combo_localizar.ItemIndex = X then
    combo_localizar.ItemIndex := 0
  else
    combo_localizar.ItemIndex := combo_localizar.ItemIndex + 1
end;

procedure Tfrmxloc_cheque.Referncia1Click(Sender: TObject);
var
  X: INTEGER;
begin
  X := combo_referencia.Items.Count - 1;
  if combo_referencia.ItemIndex = X then
    combo_referencia.ItemIndex := 0
  else
    combo_referencia.ItemIndex := combo_referencia.ItemIndex + 1

end;

procedure Tfrmxloc_cheque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PARAMETRO_PESQUISA := '';
  Action := CAFREE;
end;

procedure Tfrmxloc_cheque.Fechar1Click(Sender: TObject);
begin
  if voltar then
    loc.setfocus
  else
  begin
    resultado_pesquisa1 := '';
    resultado_pesquisa2 := '';
    resultado_pesquisa3 := '';
    RESULTADO_PESQUISA4 := '';
    close;
  end;
end;

procedure Tfrmxloc_cheque.locKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_down then
  begin
    grid.setfocus;
  end;
end;

procedure Tfrmxloc_cheque.GRIDKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if query.RecNo > 0 then
    begin
      resultado_pesquisa1 := query.fieldbyname('CODIGO').asstring;
      resultado_pesquisa2 := query.fieldbyname('TITULAR').asstring;
      close;
    end;
  end;
end;

procedure Tfrmxloc_cheque.locKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if query.RecNo > 0 then
    begin
      resultado_pesquisa1 := query.fieldbyname('CODIGO').asstring;
      resultado_pesquisa2 := query.fieldbyname('TITULAR').asstring;
      close;
    end;
  end;
end;

procedure Tfrmxloc_cheque.locEnter(Sender: TObject);
begin
  tedit(Sender).color := $00A0FAF8;
  voltar := false;
end;

procedure Tfrmxloc_cheque.locExit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
end;

procedure Tfrmxloc_cheque.FormShow(Sender: TObject);
begin
  voltar := false;
  query.Close;
  query.SQL.clear;
  if parametro_pesquisa = '' then
  begin
    query.SQL.Add('select * from c000040 where atb like :atb and CODIGO Is NOT NULL and  TIPO ' + PARAMETRO_PESQUISA + '  ORDER BY VENCIMENTO');
  end
  else
  begin
    query.SQL.Add('select * from c000040 where atb like :atb and CODIGO Is NOT NULL AND TIPO ' + PARAMETRO_PESQUISA + ' ORDER BY VENCIMENTO');
  end;
  query.ParamByName('atb').Value := ME_FiltraATB('TB_CHEQUE');
  query.open;
  LOC.SETFOCUS;

end;

procedure Tfrmxloc_cheque.GRIDEnter(Sender: TObject);
begin
  voltar := true;
  lvoltar.Caption := 'VOLTAR';
end;

procedure Tfrmxloc_cheque.GRIDExit(Sender: TObject);
begin
  lvoltar.Caption := 'FECHAR';
  VOLTAR := FALSE;
end;

procedure Tfrmxloc_cheque.locChange(Sender: TObject);
var
  ref, tipo: string;
begin
  if combo_referencia.ItemIndex = 0 then
    ref := ''
  else
    ref := '%';
  case combo_localizar.ItemIndex of
    0:
      tipo := 'NUMERO';
    1:
      tipo := 'VENCIMENTO';
    2:
      tipo := 'TITULAR';
  end;

  try
    query.close;
    query.sql.clear;
    if loc.text = '' then
      query.sql.Add('select * from c000040 where atb like :atb and CODIGO IS NOT NULL and tipo ' + parametro_pesquisa + ' ORDER BY VENCIMENTO')
    else
      query.sql.Add('select * from c000040 where atb like :atb and upper(' + tipo + ') like ''' + ref + loc.Text + '%'' and tipo ' + parametro_pesquisa + ' order by ' + tipo);
    query.ParamByName('atb').Value := ME_FiltraATB('TB_CHEQUE');
    query.open;
  except
  end;
end;

procedure Tfrmxloc_cheque.GRIDDblClick(Sender: TObject);
begin
  resultado_pesquisa1 := query.fieldbyname('CODIGO').asstring;
  resultado_pesquisa2 := query.fieldbyname('TITULAR').asstring;
  close;

end;

procedure Tfrmxloc_cheque.ParmetrosdaPesquisa1Click(Sender: TObject);
begin
  LOC.SETFOCUS;
end;

end.

