unit uCouleurs;

// Cette unité est utilisée par l'unité uCourbe pour la tracé des courbes
// et le choix de la couleur du tracé qui peut être rendu :
// - soit avec les couleurs de l''arc en ciel représentant l''importance de
//   la partie imaginaire (dans ce cas la couleur cyan marque les plages où la
//   part imaginaire est relativement faible ou nulle).
// - soit avec une couleur unique. (utile pour l'impression si le contraste
//   cyan/blanc donne un rendu trop pâle)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, uFun2;

type
  TfrmCouleurs = class(TForm)
    imgArcEnCiel: TImage;
    imgNuancesGris: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Image2: TImage;
    procedure imgArcEnCielMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgNuancesGrisMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure imgArcEnCielDblClick(Sender: TObject);
    procedure imgArcEnCielClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    choixCouleur: tColor;
  end;

var
  frmCouleurs: TfrmCouleurs;

function BmpArcEnCiel360x3(Sat, Lum: byte): tBitMap;
//       Renvoie BitMap de 360 x 3 pixels aux couleurs de l'arc en ciel

implementation

{$R *.DFM}

// Couleurs -------------------------------------------------------------------

// RGB = Red Green Blue intervalle 0..255
// Hue          H = 0° to 360° (correspond à la couleur)
// Saturation   S = 0 (niveau de gris) à 255 (couleur pure)
// Valeur       V = 0 (noir) à 255 (blanc)

procedure HSVtoRGB(const zH, zS, zV: integer; var aR, aG, aB: integer);
const
  d = 255 * 60;
var
  a: integer;
  hh: integer;
  p, q, t: integer;
  vs: integer;
begin
  if (zH = 0) or (zS = 0) or (ZV = 0) then // niveaux de gris
  begin
    aR := zV;
    aG := zV;
    aB := zV;
  end
  else
  begin // en couleur
    if zH = 360 then
      hh := 0
    else
      hh := zH;
    a := hh mod 60; // a intervalle  0..59
    hh := hh div 60; // hh intervalle 0..6
    vs := zV * zS;
    p := zV - vs div 255;
    q := zV - (vs * a) div d;
    t := zV - (vs * (60 - a)) div d;
    case hh of
      0:
        begin
          aR := zV;
          aG := t;
          aB := p;
        end;
      1:
        begin
          aR := q;
          aG := zV;
          aB := p;
        end;
      2:
        begin
          aR := p;
          aG := zV;
          aB := t;
        end;
      3:
        begin
          aR := p;
          aG := q;
          aB := zV;
        end;
      4:
        begin
          aR := t;
          aG := p;
          aB := zV;
        end;
      5:
        begin
          aR := zV;
          aG := p;
          aB := q;
        end;
    else
      begin
        aR := 0;
        aG := 0;
        aB := 0;
      end;
    end;
  end;
end; // HSVtoRGB

function BmpArcEnCiel360x3(Sat, Lum: byte): tBitMap;
//       Renvoie BitMap de 360 x 3 pixels aux couleurs de l'arc en ciel
var
  bmp: tBitMap;
  i: integer;
  colo: Tcolor;
  R, G, B: integer;
begin
  bmp := tBitMap.create;
  bmp.width := 360;
  bmp.height := 3;
  bmp.pixelformat := pf24bit;
  for i := 0 to bmp.width - 1 do
  begin
    HSVtoRGB(bmp.width - 1 - i, Sat, Lum, R, G, B);
    colo := RGB(R, G, B);
    with bmp.canvas do
    begin
      pen.color := colo;
      moveto(i, 0);
      lineto(i, bmp.height - 1);
    end;
  end;
  result := bmp;
end;

var
  CoulMouseDown: tColor;

procedure TfrmCouleurs.imgArcEnCielMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CoulMouseDown := imgArcEnCiel.Canvas.Pixels[X, Y];
end;

procedure TfrmCouleurs.imgNuancesGrisMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CoulMouseDown := imgNuancesGris.Canvas.Pixels[X, Y];
end;

procedure TfrmCouleurs.imgArcEnCielClick(Sender: TObject);
var
  r: tRect;
begin
  choixCouleur := CoulMouseDown;
  r := rect(0, 0, image2.width, image2.height);
  image2.canvas.brush.color := choixCouleur;
  image2.canvas.FillRect(r);
  label2.visible := false;
  image2.visible := true;
end;

procedure TfrmCouleurs.FormCreate(Sender: TObject);
begin
  imgArcEnCiel.hint := 'Clicker sur la couleur à choisir' + cLS
    + 'Double-click = rétablir la polychromie';
  imgNuancesGris.hint := 'Clicker sur la nuance à choisir' + cLS
    + 'Double-click = rétablir la polychromie';
  image2.width := label2.width;
  image2.height := label2.height;
  image2.left := label2.left;
  choixCouleur := -1;
end;

procedure TfrmCouleurs.imgArcEnCielDblClick(Sender: TObject);
begin
  choixCouleur := -1;
  label2.Color := clBtnFace;
  image2.visible := false;
  label2.visible := true;
end;

end. //=========================================================================

