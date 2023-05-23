unit xloc_cartao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, ExtCtrls, Collection,
  TFlatPanelUnit, Menus, Grids, Wwdbigrd, Wwdbgrid, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  Tfrmxloc_cartao = class(TForm)
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
  frmxloc_cartao: Tfrmxloc_cartao;
  voltar: boolean;

implementation

uses
  modulo;

{$R *.dfm}

procedure Tfrmxloc_cartao.Localizarpor1Click(Sender: TObject);
var
  X: INTEGER;
begin
  X := combo_localizar.Items.Count - 1;
  if combo_localizar.ItemIndex = X then
    combo_localizar.ItemIndex := 0
  else
    combo_localizar.ItemIndex := combo_localizar.ItemIndex + 1
end;

procedure Tfrmxloc_cartao.Referncia1Click(Sender: TObject);
var
  X: INTEGER;
begin
  X := combo_referencia.Items.Count - 1;
  if combo_referencia.ItemIndex = X then
    combo_referencia.ItemIndex := 0
  else
    combo_referencia.ItemIndex := combo_referencia.ItemIndex + 1

end;

procedure Tfrmxloc_cartao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CAFREE;
end;

procedure Tfrmxloc_cartao.Fechar1Click(Sender: TObject);
begin
  if voltar then
    loc.setfocus
  else
  begin
    resultado_pesquisa1 := '';
    resultado_pesquisa2 := '';
    close;
  end;
end;

procedure Tfrmxloc_cartao.locKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_down then
  begin
    grid.setfocus;
  end;
end;

procedure Tfrmxloc_cartao.GRIDKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if query.RecNo > 0 then
    begin
      resultado_pesquisa1 := query.fieldbyname('NUMERO').asstring;
      resultado_pesquisa2 := query.fieldbyname('BANCO').asstring;
      resultado_pesquisa3 := QUERY.FIELDBYNAME('rec_debito').ASSTRING;
      resultado_pesquisa4 := QUERY.FIELDBYNAME('rec_credito').ASSTRING;
      resultado_pesquisa5 := query.fieldbyname('comissao_debito').asstring;
      resultado_pesquisa6 := query.fieldbyname('comissao_credito').asstring;
      close;
    end;
  end;
end;

procedure Tfrmxloc_cartao.locKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if query.RecNo > 0 then
    begin
      resultado_pesquisa1 := query.fieldbyname('NUMERO').asstring;
      resultado_pesquisa2 := query.fieldbyname('BANCO').asstring;
      resultado_pesquisa3 := QUERY.FIELDBYNAME('rec_debito').ASSTRING;
      resultado_pesquisa4 := QUERY.FIELDBYNAME('rec_credito').ASSTRING;
      resultado_pesquisa5 := query.fieldbyname('comissao_debito').asstring;
      resultado_pesquisa6 := query.fieldbyname('comissao_credito').asstring;
      close;
    end;
  end;
end;

procedure Tfrmxloc_cartao.locEnter(Sender: TObject);
begin
  tedit(Sender).color := $00A0FAF8;
  voltar := false;
end;

procedure Tfrmxloc_cartao.locExit(Sender: TObject);
begin
  tedit(Sender).color := clwindow;
end;

procedure Tfrmxloc_cartao.FormShow(Sender: TObject);
begin
  voltar := false;
  query.Close;
  query.SQL.clear;
  query.SQL.Add('select * from c000013 where atb like :atb and NUMERO = ''XXXXXX''');
  query.ParamByName('atb').Value := ME_FiltraATB('TB_BANCO');
  query.open;

end;

procedure Tfrmxloc_cartao.GRIDEnter(Sender: TObject);
begin
  voltar := true;
  lvoltar.Caption := 'VOLTAR';
end;

procedure Tfrmxloc_cartao.GRIDExit(Sender: TObject);
begin
  lvoltar.Caption := 'FECHAR';
  VOLTAR := FALSE;
end;

procedure Tfrmxloc_cartao.locChange(Sender: TObject);
var
  ref, tipo: string;
begin
  if combo_referencia.ItemIndex = 0 then
    ref := ''
  else
    ref := '%';
  case combo_localizar.ItemIndex of
    0:
      tipo := 'BANCO';
    1:
      tipo := 'NUMERO';
  end;

  try
    query.close;
    query.sql.clear;
    if loc.text = '' then
      query.sql.Add('select * from c000013 where atb like :atb and NUMERO = ''xxxxxx''')
    else
      query.sql.Add('select * from c000013 where atb like :atb and cartao_credito = 1 AND upper(' + tipo + ') like ''' + ref + loc.Text + '%'' order by ' + tipo);
    query.ParamByName('atb').Value := ME_FiltraATB('TB_BANCO');
    query.open;
  except
  end;
end;

procedure Tfrmxloc_cartao.GRIDDblClick(Sender: TObject);
begin
  resultado_pesquisa1 := query.fieldbyname('NUMERO').asstring;
  resultado_pesquisa2 := query.fieldbyname('BANCO').asstring;
  resultado_pesquisa3 := QUERY.FIELDBYNAME('rec_debito').ASSTRING;
  resultado_pesquisa4 := QUERY.FIELDBYNAME('rec_credito').ASSTRING;
  resultado_pesquisa5 := query.fieldbyname('comissao_debito').asstring;
  resultado_pesquisa6 := query.fieldbyname('comissao_credito').asstring;
  close;

end;

procedure Tfrmxloc_cartao.ParmetrosdaPesquisa1Click(Sender: TObject);
begin
  LOC.SETFOCUS;
end;

end.

