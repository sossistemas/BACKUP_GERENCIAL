unit cor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, Wwdbigrd, Wwdbgrid, Menus, ExtCtrls, AdvGlowButton,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, UCBase, dxGDIPlusClasses, Vcl.Buttons,
  cyBaseSpeedButton, cySpeedButton, AdvMetroButton, Vcl.StdCtrls, AdvSmoothPanel,
  AdvSmoothExpanderPanel;

type
  Tfrmcor = class(TForm)
    qrcor: TZQuery;
    Panel1: TPanel;
    bfechar: TAdvGlowButton;
    PopupMenu1: TPopupMenu;
    Fechar1: TMenuItem;
    wwDBGrid1: TwwDBGrid;
    dscor: TDataSource;
    bexcluir: TAdvGlowButton;
    Excluir1: TMenuItem;
    qrcorCODIGO: TWideStringField;
    qrcorNOME: TWideStringField;
    qrcorCOR: TWideStringField;
    UCControls1: TUCControls;
    cySpeedButton1: TcySpeedButton;
    AdvSmoothExpanderPanel1: TAdvSmoothExpanderPanel;
    Label20: TLabel;
    AdvMetroButton1: TAdvMetroButton;
    procedure bfecharClick(Sender: TObject);
    procedure qrcorBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure qrcorAfterPost(DataSet: TDataSet);
    procedure bexcluirClick(Sender: TObject);
    procedure AdvMetroButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcor: Tfrmcor;

implementation

uses
  modulo, principal;

{$R *.dfm}

procedure Tfrmcor.bfecharClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmcor.qrcorBeforePost(DataSet: TDataSet);
begin
  if qrcor.state = dsinsert then
    qrcor.fieldbyname('codigo').asstring := frmPrincipal.codifica('000129');
  qrcor.fieldbyname('cor').asstring := ansiuppercase(qrcor.fieldbyname('cor').asstring);
end;

procedure Tfrmcor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure Tfrmcor.FormShow(Sender: TObject);
begin
  qrcor.close;
  qrcor.sql.clear;
  qrcor.sql.add('select * from c000129');
  qrcor.Open;
end;

procedure Tfrmcor.qrcorAfterPost(DataSet: TDataSet);
begin
  frmmodulo.conexao.commit;
end;

procedure Tfrmcor.AdvMetroButton1Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmcor.bexcluirClick(Sender: TObject);
begin
  if application.messagebox('Confirma a exclus�o desta cor?', 'Aviso', mb_yesno + MB_ICONWARNING) = idyes then
  begin
    frmPrincipal.logUC('Excluiu Cor - ' + qrcor.fieldbyname('nome').asstring + ' / ' + qrcor.fieldbyname('cor').asstring, 3);
    qrcor.Delete;
    frmmodulo.conexao.commit;

  end;
end;

end.

