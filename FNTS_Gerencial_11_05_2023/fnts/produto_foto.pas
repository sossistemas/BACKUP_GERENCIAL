unit produto_foto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  Tfrmproduto_foto = class(TForm)
    Image2: TImage;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmproduto_foto: Tfrmproduto_foto;

implementation

{$R *.dfm}

procedure Tfrmproduto_foto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    CLOSE;
end;

procedure Tfrmproduto_foto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CAFREE;
end;

end.

