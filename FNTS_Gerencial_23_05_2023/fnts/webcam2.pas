unit webcam2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Camera, ExtCtrls, PiconeBarreTache;

type
  TTabImage = array[0..230399] of byte;

type
  Tfrmwebcam2 = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Camera1: TCamera;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmwebcam2: Tfrmwebcam2;

implementation

uses
  modulo, cliente;

{$R *.dfm}

procedure Tfrmwebcam2.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmwebcam2.FormCreate(Sender: TObject);
var
  p: ^TTabImage;
begin
  Camera1.Actif := True;
  New(p);
end;

procedure Tfrmwebcam2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure Tfrmwebcam2.BitBtn1Click(Sender: TObject);
begin
  ForceDirectories('C:\SOS\Server\img\Clientes');
  camera1.FichierImage := 'C:\SOS\Server\img\Clientes\ft' + frmmodulo.qrcliente.fieldbyname('codigo').asstring + '.BMP';
  camera1.CaptureImageDisque;
  frmcliente.image2.picture.loadfromfile('C:\SOS\Server\img\Clientes\ft' + frmmodulo.qrcliente.fieldbyname('codigo').asstring + '.BMP');
  FRMMODULO.QRCLIENTE.FIELDBYNAME('FOTO').ASSTRING := 'C:\SOS\Server\img\Clientes\ft' + frmmodulo.qrcliente.fieldbyname('codigo').asstring + '.BMP';
  close;
end;

end.

