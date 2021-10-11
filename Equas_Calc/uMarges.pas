unit uMarges;

// Cette unité contient quelques utilitaires pour l'impression

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Printers, uFun2;

type
  TfrmMarges = class(TForm)
    nbk: TNotebook;
    LabHaut: TLabel;
    labBas: TLabel;
    labGauche: TLabel;
    labDroite: TLabel;
    labImpDft: TLabel;
    edHaute: TEdit;
    edBasse: TEdit;
    edGauche: TEdit;
    edDroite: TEdit;
    btnOK: TButton;
    btnEch: TButton;
    plPortrait: TPanel;
    Portrait: TImage;
    plPaysage: TPanel;
    Paysage: TImage;
    memoParams: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEchClick(Sender: TObject);
    procedure edHauteChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure PortraitClick(Sender: TObject);
    procedure PaysageClick(Sender: TObject);
    procedure memoParamsDblClick(Sender: TObject);
    procedure nbkDblClick(Sender: TObject);
    procedure LabHautDblClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmMarges: TfrmMarges;

var
  orienta: TPrinterOrientation; // poPortrait, poLandscape
  MargeG, margeD, MargeH, MargeB: byte; // marges valeurs en mm / bord du papier
  MiseEnPageChangee: boolean;
var
  ImpPixParPouceX, ImpPixParPouceY,
    ImpPixParCmX, ImpPixParCmY,
    NonImprimablePixelsX, NonImprimablePixelsY: integer;
  EchelleX, EchelleY: real;
var
  FormePixParPouce, FormePixParCm: integer;

procedure smTi(s: string; i: integer);

procedure ParamsImprimante;
// Convertir les millimètres en nombre de Pixels :
function mmVersPixX(mmX: integer): integer;
function mmVersPixY(mmY: integer): integer;
// Convertir les Pixels en millimètres :
function PixVersmmX(pixX: integer): integer;
function PixVersmmY(pixY: integer): integer;
// Imprimer à la queue-leu-leu
function Imprimer(cooMm: tPoint; Texte: string): tPoint;

// --------------------------------------------------------------------------
var
  ymh, xmg, xmd, ymb: integer; // rectangle marges Dixièmes de mm
  hlp: integer; // hauteur d'une ligne en pixels

procedure Params2; // Rect marges dixièmes de mm
procedure Beg_Doc;
procedure End_Doc;
procedure PolImpr(nomPol: string; stylPol: tFontStyles; taillePol: byte);
function SauteLignes(xyDmm: tPoint; n: byte): tPoint;

type
  tPosition = (poNormal, poExposant, poIndice);

function ImprMM(xyDmm: tPoint; ss: string; posit: tPosition): tPoint;
  // en Dixièmes de mm
function ImprImg(img: tImage; xyDmm: tPoint; mmLarg, mmHaut: integer): tPoint;

implementation

{$R *.DFM}

procedure smTi(s: string; i: integer);
begin
  ShowMessage(s + ' : ' + intToStr(i));
end;

var
  imprimante: tPrinter;

procedure TfrmMarges.FormCreate(Sender: TObject);
begin
  caption := 'Marges + Orientation';
  MargeH := 20;
  MargeB := 20;
  MargeG := 25;
  MargeD := 15;
  edHaute.text := intToStr(MargeH);
  edBasse.text := intToStr(MargeB);
  edGauche.text := intToStr(MargeG);
  edDroite.text := intToStr(MargeD);
  imprimante := tPrinter.Create;
  labImpDft.caption := imprimante.Printers[imprimante.PrinterIndex];
  Orienta := poPortrait;
  Printer.Orientation := Orienta;
  plPortrait.color := clLime;
  Portrait.ShowHint := false;
  Paysage.ShowHint := true;
  MiseEnPageChangee := false;
  ParamsImprimante;
  Params2;
end;

var
  oMargeG, oMargeD, oMargeH, oMargeB: integer; // Marges + O à l'ouverture
  oOrienta: TPrinterOrientation;

procedure TfrmMarges.FormShow(Sender: TObject);
begin
  edHaute.SetFocus;
  oMargeG := MargeG;
  oMargeD := MargeD;
  oMargeH := MargeH;
  oMargeB := MargeB;
  oOrienta := Orienta;
end;

procedure TfrmMarges.btnOKClick(Sender: TObject);
begin
  Params2;
  Close;
end;

procedure TfrmMarges.btnEchClick(Sender: TObject); // Echappe = Rétablissement
begin
  MargeG := oMargeG;
  MargeD := oMargeD;
  MargeH := oMargeH;
  MargeB := oMargeB;
  edHaute.text := intToStr(MargeH);
  edBasse.text := intToStr(MargeB);
  edGauche.text := intToStr(MargeG);
  edDroite.text := intToStr(MargeD);
  Orienta := oOrienta;
  MiseEnPageChangee := false;
  Close;
end;

procedure ParamsImprimante;
begin
  ImpPixParPouceX := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
  ImpPixParPouceY := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  ImpPixParCmX := trunc(ImpPixParPouceX / 2.54);
  ImpPixParCmY := trunc(ImpPixParPouceY / 2.54);
  // Marges non imprimables :
  NonImprimablePixelsX := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETX);
  NonImprimablePixelsY := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETY);
  // Forme :
  FormePixParPouce := frmMarges.PixelsPerInch;
  FormePixParCm := trunc(FormePixParPouce / 2.54);
  // Echelles d'impression :
  EchelleX := ImpPixParPouceX / FormePixParPouce;
  EchelleY := ImpPixParPouceY / FormePixParPouce;
  with frmMarges.memoParams.lines do
  begin
    clear;
    add('Imprimante : ');
    add('- Hauteur imprimable page en pixels : ' +
      intToStr(Printer.PageHeight));
    add('- Largeur imprimable page en pixels : ' + intToStr(Printer.PageWidth));
    add('- Largeur physique page en pixels : ' +
      intToStr(GetDeviceCaps(Printer.Handle, PHYSICALWIDTH)));
    add('- Hauteur physique page en pixels : ' +
      intToStr(GetDeviceCaps(Printer.Handle, PHYSICALHEIGHT)));

    if ImpPixParPouceX <> ImpPixParPouceY then
    begin
      add('- Pixels/PouceX : ' + intToStr(ImpPixParPouceX));
      add('- Pixels/cm     : ' + intToStr(ImpPixParCmX));
      add('- Pixels/PouceY : ' + intToStr(ImpPixParPouceY));
    end
    else
    begin
      add('- Pixels/Pouce : ' + intToStr(ImpPixParPouceX));
      add('- Pixels/cm    : ' + intToStr(ImpPixParCmX));
    end;
    if NonImprimablePixelsX <> NonImprimablePixelsY then
    begin
      add('- Pix non imprimables X : ' + intToStr(NonImprimablePixelsX));
      add('- Pix non imprimables Y : ' + intToStr(NonImprimablePixelsY));
    end
    else
      add('- Pix non imprimables : ' + intToStr(NonImprimablePixelsX));
    add('Forme : ');
    add('- Pixels/Pouce : ' + intToStr(FormePixParPouce));
    add('- Pixels/Cm    : ' + intToStr(FormePixParCm));
    if EchelleX <> EchelleY then
    begin
      add('Echelles d''impression : ');
      add('- EchelleX : ' + chnFloat(EchelleX, 2));
      add('- EchelleY : ' + chnFloat(EchelleY, 2));
    end
    else
    begin
      add('Echelle d''impression : ');
      add('- Echelle : ' + chnFloat(EchelleX, 2));
    end;
  end;
end;

// Convertir les millimètres en nombre de Pixels

function mmVersPixX(mmX: integer): integer;
begin
  result := Trunc(mmX * ImpPixParPouceX / 25.4);
end;

function mmVersPixY(mmY: integer): integer;
begin
  result := Trunc(mmY * ImpPixParPouceY / 25.4);
end;

// Convertir les Pixels en millimètres

function PixVersmmX(pixX: integer): integer;
begin
  result := Trunc(pixX * 25.4 / ImpPixParPouceX);
end;

function PixVersmmY(pixY: integer): integer;
begin
  result := Trunc(pixY * 25.4 / ImpPixParPouceY);
end;

function Imprimer(coomm: tPoint; Texte: string): tPoint;
var
  wt: integer;
begin
  with Printer.Canvas do
  begin
    TextOut(mmVersPixX(coomm.x) - NonImprimablePixelsX,
      mmVersPixY(coomm.y) - NonImprimablePixelsY, Texte);
    wt := textWidth(Texte);
    Result.x := coomm.x + PixVersMmX(wt);
    Result.y := coomm.y;
  end;
end;

// Approche avec MM_LOMETRIC ---------------------------------------------------

procedure Params2; // Rect marges dixièmes de mm
var
  hpPhys: integer;
begin
  ymh := (MargeH * 10); {- 10*PixVersmmY(NonImprimablePixelsY);}
  xmg := (MargeG * 10) - 10 * PixVersmmX(NonImprimablePixelsX);
  xmd := (pixVersMmX(Printer.PageWidth) - margeD +
    PixVersmmX(NonImprimablePixelsX)) * 10;
  hpPhys := GetDeviceCaps(Printer.Handle, PHYSICALHEIGHT);
  ymb := (PixVersmmX(hpPhys - NonImprimablePixelsY) - margeB) * 10;
  ymh := -ymh;
  ymb := -ymb; // inversion axe vertical
end;

procedure Beg_Doc;
begin
  Printer.BeginDoc;
  SetMapMode(Printer.Canvas.Handle, MM_LOMETRIC);
end;

procedure End_Doc;
begin
  Printer.EndDoc;
end;

var
  pixPerCm: byte;

procedure PolImpr(nomPol: string; stylPol: tFontStyles; taillePol: byte);
begin
  with Printer.Canvas.Font do
  begin
    Name := nomPol;
    Style := stylPol;
    Size := taillePol;
    PixelsPerInch := getDeviceCaps(Printer.Canvas.Handle, LOGPIXELSY);
    pixPerCm := trunc(PixelsPerInch / 2.54);
  end;
  hlp := (Printer.Canvas.TextHeight('Bonjour')) * 100 div pixPerCm;
    // : calibrage
end;

function SauteLignes(xyDmm: tPoint; n: byte): tPoint; // en Dixièmes de mm
var
  dy: integer;
begin
  dy := n * round(hlp * 1.4);
  xyDmm.y := xyDmm.y + dy;
  if (xyDmm.y) >= abs(ymb) then
  begin
    Printer.newPage;
    SetMapMode(Printer.Canvas.Handle, MM_LOMETRIC);
    xyDmm.y := abs(ymh);
  end;
  Result.x := xmg;
  Result.y := xyDmm.y;
end;

function ImprMM(xyDmm: tPoint; ss: string; posit: tPosition): tPoint;
  // en Dixièmes de mm
var
  x: integer;
  lg: integer;
  TaillePol, TailleRed: integer;
begin
  lg := Printer.Canvas.TextWidth(ss);
  TaillePol := Printer.canvas.font.Size;
  TailleRed := round(TaillePol * 3 / 4);
  if (xyDmm.x + lg) > xmd then
  begin
    xyDmm.x := xmg;
    xyDmm.y := xyDmm.y + round(hlp * 1.4);
  end;
  if (xyDmm.y + round(hlp * 1.4)) >= abs(ymb) then
  begin
    Printer.newPage;
    SetMapMode(Printer.Canvas.Handle, MM_LOMETRIC);
    xyDmm.y := abs(ymh);
  end;
  with Printer.canvas do
  begin
    if posit = poNormal then
      TextOut(xyDmm.x, -xyDmm.y, ss)
    else if posit = poExposant then
    begin
      font.Size := TailleRed;
      TextOut(xyDmm.x, -xyDmm.y + (hlp div 2), ss)
    end
    else if posit = poIndice then
    begin
      font.Size := TailleRed;
      Printer.Canvas.TextOut(xyDmm.x, -xyDmm.y - (hlp div 2), ss);
    end;
    Printer.canvas.font.Size := TaillePol;
  end;
  x := xyDmm.x + lg;
  Result.x := x;
  Result.y := xyDmm.y;
end;

function ImprImg(img: tImage; xyDmm: tPoint; mmLarg, mmHaut: integer): tPoint;
var
  EchelleX, EchelleY: Integer;
  R: TRect;
begin
  with frmMarges do
  begin
    with Printer do
    try
      EchelleX := GetDeviceCaps(Handle, logPixelsX) div PixelsPerInch;
      EchelleY := GetDeviceCaps(Handle, logPixelsY) div PixelsPerInch;
      R := Rect(xyDmm.x, -xyDmm.y, img.Picture.Width * EchelleX,
        -(xyDmm.y + img.Picture.Height * EchelleY));
      Canvas.StretchDraw(R, img.Picture.Graphic);
    except
      Result := xyDmm;
      EXIT;
    end;
    Result.x := xyDmm.x;
    Result.y := xyDmm.y + img.Picture.Height * EchelleY;
  end;
end;

procedure TfrmMarges.edHauteChange(Sender: TObject);
const
  esp = ['0'..'9'];
var
  ed: tEdit;
  s: shortString;
  i, marge, code: integer;
begin
  ed := (Sender as tEdit);
  s := ed.Text;
  i := 1;
  while (i <= length(s)) do
    if not (s[i] in esp) then
      Delete(s, i, 1)
    else
      inc(i);
  if length(s) <> length(ed.text) then
  begin
    ed.text := s;
    EXIT;
  end;
  val(s, marge, code);
  if ed.name = 'edHaute' then
    MargeH := marge
  else if ed.name = 'edBasse' then
    MargeB := marge
  else if ed.name = 'edGauche' then
    MargeG := marge
  else if ed.name = 'edDroite' then
    MargeH := marge;
  MiseEnPageChangee := true;
end;

procedure TfrmMarges.PortraitClick(Sender: TObject); // impression mode Portrait
begin
  Orienta := poPortrait;
  Printer.Orientation := Orienta;
  plPortrait.color := clLime;
  plPaysage.color := clScrollBar;
  Paysage.ShowHint := true;
  Portrait.ShowHint := false;
  MiseEnPageChangee := true;
  ParamsImprimante;
  Params2;
end;

procedure TfrmMarges.PaysageClick(Sender: TObject); // impression mode Paysage
begin
  Orienta := poLandscape;
  Printer.Orientation := Orienta;
  plPaysage.color := clLime;
  plPortrait.color := clScrollBar;
  Paysage.ShowHint := false;
  Portrait.ShowHint := true;
  MiseEnPageChangee := true;
  ParamsImprimante;
  Params2;
end;

procedure TfrmMarges.memoParamsDblClick(Sender: TObject);
begin
  nbk.ActivePage := 'Facade';
end;

procedure TfrmMarges.nbkDblClick(Sender: TObject);
begin
  nbk.ActivePage := 'Params';
end;

procedure TfrmMarges.LabHautDblClick(Sender: TObject);
begin
  Params2;
  with Printer do
  begin
    Printer.BeginDoc;
    SetMapMode(Canvas.Handle, MM_LOMETRIC);
    PolImpr('Arial', [], 12);

    Canvas.Pen.Style := psSolid;
    Canvas.Rectangle(0, 0, 2069, -2939); // visu marges techniques

    canvas.rectangle(xmg, ymh, xmd, ymb);

    Canvas.Pen.Style := psDash; // série de tirets

    Canvas.Pen.Style := psDot; // série de points
    //Canvas.Rectangle(margeG*10,-MargeH*10,2100-MargeD*10,-2970+MargeB*10); //<- visu marges choisies
    EndDoc;
  end;
end;

end.

