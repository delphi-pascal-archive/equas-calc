unit uEquas8;

// /////////////////////////////////////////////////////////////////////////////
// Cette unité est l''unit principale qui exploite la METHODE de LAGUERRE
//               pour la résolution des équas de degré N
//                       - EXPERIMENTAL -
////////////////////////////////////////////////////////////////////////////////

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, ComCtrls, uFlotte2, uFun2, Math, shellapi,
  ExtDlgs, uMarges, uCourbe, Menus, uTrace, uCalcGR, UnitGC, UnitGR,
  uAPropos, clipBrd;

type
  TfrmEquas7 = class(TForm)
    SaveDialog1: TSaveDialog;
    SavePictureDialog1: TSavePictureDialog;
    Panel1: TPanel;
    labEqua: TLabel;
    labPrecision: TLabel;
    labRacines: TLabel;
    labMis: TLabel;
    Label2: TLabel;
    bAutreDegre: TSpeedButton;
    edFdeX: TEdit;
    cbAffichage: TCheckBox;
    edDegre: TEdit;
    bResoudre: TSpeedButton;
    bGenerer: TSpeedButton;
    bVoirPlus: TSpeedButton;
    bVoirCourbe: TSpeedButton;
    bImprimer3: TSpeedButton;
    bCalculette: TSpeedButton;
    bAide: TSpeedButton;
    Bevel1: TBevel;
    edCoEqua: TEdit;
    popGenerer: TPopupMenu;
    GenEquaARacineUnique: TMenuItem;
    GenEquaRacineSuppl: TMenuItem;
    GenFragRacineConnue: TMenuItem;
    popImprimer3: TPopupMenu;
    ImprEquation3: TMenuItem;
    ImprRacines3: TMenuItem;
    ImprLesdeux3: TMenuItem;
    N1: TMenuItem;
    Modifiermargesdimpression1: TMenuItem;
    Bevel2: TBevel;
    edPrecision: TEdit;
    ScrollCoeffs: TScrollBox;
    ScrollRacines: TScrollBox;
    plProgress: TPanel;
    plCurProg: TPanel;
    labNC: TLabel;
    edNC: TEdit;
    edMargeAff: TEdit;
    edNA: TEdit;
    Label1: TLabel;
    labDefile: TLabel;
    Timer1: TTimer;
    btnAPropos: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure plHautMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCoEquaChange(Sender: TObject);
    procedure edCoEquaKeyPress(Sender: TObject; var Key: Char);
    procedure GenEquaARacineUniqueClick(Sender: TObject);
    procedure GenEquaRacineSupplClick(Sender: TObject);
    procedure GenFragRacineConnueClick(Sender: TObject);
    procedure edFdeXDblClick(Sender: TObject);
    procedure edDegreChange(Sender: TObject);
    procedure bAutreDegreClick(Sender: TObject);
    procedure bCalculetteClick(Sender: TObject);
    procedure bVoirCourbeClick(Sender: TObject);
    procedure edPrecisionChange(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure popGenererPopup(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImprRacines3Click(Sender: TObject);
    procedure ImprLesdeux3Click(Sender: TObject);
    procedure Modifiermargesdimpression1Click(Sender: TObject);
    procedure bAideClick(Sender: TObject);
    procedure bImprimer3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure labEquaClick(Sender: TObject);
    procedure bResoudreClick(Sender: TObject);
    procedure labProgressDblClick(Sender: TObject);
    procedure bVoirPlusClick(Sender: TObject);
    procedure edDegreKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edNCChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edNAChange(Sender: TObject);
    procedure edNAKeyPress(Sender: TObject; var Key: Char);
    procedure edNCKeyPress(Sender: TObject; var Key: Char);
    procedure btnAProposClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ImprEquation3Click(Sender: TObject);
    procedure bGenererMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edDegreKeyPress(Sender: TObject; var Key: Char);
    procedure edPrecisionKeyPress(Sender: TObject; var Key: Char);
    procedure cbAffichageClick(Sender: TObject);
    procedure edMargeAffChange(Sender: TObject);
    procedure edFdeXKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmEquas7: TfrmEquas7;

  NA: integer;
    // Nbre de Chiffres à afficher pour chacune des composantes d'un résultat
  ChampsResultatsExistent: boolean;

type
  oEqua = object
    // P(X)=A(0)*X^N + A(1)*X^N-1+...+A(N)=0
    ChampsDeSaisieNeufs: boolean;
    Degre: integer; // Degré du polynôme P(X) initial
    N: integer; // Degré du polynôme P(X) au fil des réductions

    cAAiGC: array of tGC; // Coefficients du polynôme P(X) de l'Utilisateur
    cAAUGC: array of tGC; // Coefficients du polynôme P(X) rendu unitaire
    cAAGC: array of tGC;
      // Coefficients du polynôme unitaire au fil des réductions
    cBGC: array of tGC; // Coefficients du polynôme réduit avec ReducDegEquaGC
    vRXGC: array of tGC;
      // Valeurs optimisées des racines : Classées dans l'ordre chrono de la résolution
    vRCGC: array of tGC;
      // Valeurs optimisées des racines : Classées dans l'ordre croissant
    cD1GC: array of tGC; // Coefficients de la dérivée première de P(x) unitaire
    cD2GC: array of tGC; // Coefficients de la dérivée seconde de P(x) unitaire
    cD1GCU: array of tGC;
      // Coefficients de la dérivée première de P(x) de l'Utilisateur
    cD2GCU: array of tGC;
      // Coefficients de la dérivée seconde de P(x) de l'Utilisateur
    cPLGC: array of tGC; // Coefficients du polynôme de Laguerre

    gEv: tGR; // Précision Voulue sur les P(X(I)) à l'affichage

    nBornesLag: Integer; // Nombre de bornes de Laguerre
    BLag1, BLag2: tGC; // Bornes de Laguerre

    DeriveeNulleNewton: boolean;
    DeriveesNullesLag: boolean;

    slRacA: tStringList; // utilisé par AfficherResultat, Courbe et Imprimer3
    nbAppelsDePdeX: integer;
    nbAppelsDePi1deX: integer;
    nbAppelsDePi2deX: integer;
    coeffMD: tGC; // coefficient du monôme dominant

    function Init(iDegre: integer): boolean;

    function TestSurValEntiereGC(vAX: tGC): tGC;
    //<- TestsSurValEntière : utilisée uniquement si racine-unique-multiple

    function EvalHornerGC(P: array of tGC; Deg: integer; vX: tGC): tGC;

    function FdeXGC(vX: tGC): tGC; // renvoie f(X) avec Poly courant
    function FdeXiniGC(vX: tGC): tGC; // renvoie f(X) avec Poly initial

    procedure GenD1deXiniGCU; // génère dérivée première de f(X) de l'Utilisateur
    procedure GenD2deXiniGCU; // génère dérivée seconde de f(X) de l'Utilisateur
    function D1deXiniGCU(vX: tGC): tGC;
      // renvoie valeur de la dérivée première de f(X) de l'Utilisateur
    function D2deXGCU(vX: tGC): tGC; // Valeur de la Dérivée 2 de l'Utilisateur

    function GenEqRacSupplemGC(rac: tGC): tStringList;
    // : Génère equa de degré N+1 avec racine supplémentaire

    function GenEqFragRacConnueGC(rac: tGC): tStringList;
    // : Génère equa de degré N-1 avec racine connue : pour appels Externes

    procedure ReducDegEquaGC(Rac: tGC);
    // : Génère equa de degré N-1 avec racine connue : pour appels Internes

    function GenXBLaguerreGC: Integer;
    procedure GenDeriveePrem; // génère dérivée première de l'unitaire
    procedure GenDeriveeSec; // génère dérivée seconde de l'unitaire
    function D1deXGC(vX: tGC): tGC; // Valeur de la Dérivée 1
    function D2deXGC(vX: tGC): tGC; // Valeur de la Dérivée 2

    function XANewtonGC(vAX: tGC): tGC;
      // Affinage racine approchée par Méthode de Newton
    function XALaguerreGC(vAX: tGC): tGC;
      // Affinage racine approchée par Méthode de Laguerre
    function ResoudreAvecLagGC: boolean; // Résolution avec Laguerre
    procedure TraceCoeffs;
      // Renvoie trace des Coefficients du polynôme P(X) au degré N
    // ( pour cas où les deux dérivées sont simultanément nulles)

    procedure AfficherResultatGC;
  end;

var
  Equa: oEqua;

implementation

{$R *.DFM}

// Champs de saisie des coeffs de l''équa -------------------------------------

type
  oChampsSaisie = object
    Degre: integer;
    iChamp0: integer; // indice component de l'edit pour le SetFocus
    procedure Cree(iDeg: integer);
    procedure Alim(coeffs: tStringList);
    procedure Liberer;
  end;

var
  ChampsSaisie: oChampsSaisie;

  // Champs de résultats ------------------------------------------------------

  // Création des champs : voir procedure oEqua.AfficherResultatGC;

procedure LibererChampsResultats;
var
  i: integer;
begin
  with frmEquas7 do
  begin
    i := 0;
    repeat if (components[i] is tEdit)
      and ((components[i] as tEdit).tag = 4) then
      begin
        (components[i] as tEdit).free;
        ChampsResultatsExistent := False;
      end
      else
        inc(i);
    until i >= ComponentCount;
  end;
end;

procedure CacherVoirChampsResultats; // Agit comme une bascule
var
  i: integer;
begin
  with frmEquas7 do
  begin
    i := 0;
    repeat if (components[i] is tEdit)
      and ((components[i] as tEdit).tag = 4) then
        (components[i] as tEdit).visible := not (components[i] as
          tEdit).visible;
      inc(i);
    until i >= ComponentCount;
  end;
end;

procedure AjusterChampsResultats; // Utilisé après un Resize
var
  i: integer;
begin
  with frmEquas7 do
  begin
    i := 0;
    repeat if (components[i] is tEdit)
      and ((components[i] as tEdit).tag = 4) then
        (components[i] as tEdit).width := edFDeX.width;
      inc(i);
    until i >= ComponentCount;
  end;
end;

// Champs de saisie ------------------------------------------------------------

procedure oChampsSaisie.Cree(iDeg: integer);
const
  wEd = 100;
var
  lab1, lab2: tLabel;
  ed: tMonEdit;
  i: integer;
begin
  Degre := iDeg;
  with frmEquas7 do
  begin
    for i := 0 to Degre do
    begin
      ed := tMonEdit.create(frmEquas7);
      with ed do
      begin
        parent := ScrollCoeffs;
        text := 'a' + intToStr(i);
        left := 10;
        width := wEd;
        top := 4 + i * 20;
        color := clWhite;
        font.color := clFuchsia;
        visible := true;
        tag := -2;
        name := 'ChampS' + intToStr(i);
        onChange := edCoEquaChange;
        onKeyPress := edCoEquaKeyPress;
      end;
      if i = 0 then
        iChamp0 := ComponentCount - 1;
      if i < Degre then
      begin
        lab1 := tLabel.create(frmEquas7);
        with lab1 do
        begin
          parent := ScrollCoeffs;
          parentColor := true;
          autoSize := true;
          font.style := [fsBold];
          caption := 'x';
          left := ed.left + ed.width + 5;
          top := 6 + i * 20;
          visible := true;
          tag := -2;
        end;
        lab2 := tLabel.create(frmEquas7);
        with lab2 do
        begin
          parent := ScrollCoeffs;
          parentColor := true;
          autoSize := true;
          font.name := 'Small Fonts';
          font.style := [fsBold];
          font.size := 7;
          if Degre - i > 1 then
            caption := intToStr(Degre - i)
          else
            caption := '';
          left := lab1.left + lab1.width;
          top := 6 + i * 20;
          visible := true;
          tag := -2;
        end;
      end;
    end;
    { Aligner le texte des tEdit à droite : marche sous XP mais pas sous Vista
      donc remplacé par tMonEdit
    SysLocale.MiddleEast := True;
    for i:=0 to ComponentCount-1
    do if (components[i] is tEdit)
       and ((components[i] as tEdit).tag=-2)
       then (components[i] as tEdit).BiDiMode:=bdRightToLeft; }
    if visible then
      (components[iChamp0] as tMonEdit).SetFocus; //<- pour XP et Vista
  end;
  Equa.ChampsDeSaisieNeufs := true;
end;

procedure oChampsSaisie.Alim(coeffs: tStringList);
var
  i, j, nc: integer;
  s: string;
begin
  nc := 0;
  with frmEquas7 do
  begin
    for i := 0 to ComponentCount - 1 do
      if (components[i] is tMonEdit)
        and (pos('ChampS', (components[i] as tMonEdit).name) > 0) then
      begin
        inc(nc);
        s := (components[i] as tMonEdit).name;
        j := StrToInt(copy(s, 7, maxint));
        (components[i] as tMonEdit).text := coeffs[j];
        (components[i] as tMonEdit).Font.color := clBlack;
        if nc = coeffs.Count then
          EXIT;
      end;
  end;
end;

procedure oChampsSaisie.Liberer;
var
  i: integer;
begin
  Degre := 0;
  with frmEquas7 do
  begin
    i := 0;
    repeat if (components[i] is tMonEdit)
      and ((components[i] as tMonEdit).tag < 0) then
        (components[i] as tMonEdit).free
      else if (components[i] is tLabel)
        and ((components[i] as tLabel).tag < 0) then
        (components[i] as tLabel).free
      else
        inc(i);
    until i >= ComponentCount;
  end;
end;

//  oEqua ----------------------------------------------------------------------

procedure TraceChronoVersZGC(var msg: string; Chrono: oChrono);
begin
  msg := msg + ' : ' + Chrono.Mis;
  TraceZGC(msg);
end;

procedure TraceRacine(iRacines: integer; XL: tGC; info: string);
var
  s: string;
  si: shortString;
begin
  si := intToStr(iRacines);
  TraceZGC2(cls + ' ' + chr(240) + ' ', normal, 'WingDings', 10, [fsBold],
    clGreen);
  s := 'Racine X' + si + ' = ' + GCToStrECut(Equa.vRXGC[iRacines], NAT) + cls;
  TraceZGC2(s, normal, 'Arial', 10, [fsBold], clGreen);
end;

function oEqua.Init(iDegre: integer): boolean;
var
  i, ic: integer;
  sCoef: shortString;
  c0, cp1, cm1, pr: string;
  po: byte;
begin
  N := iDegre;
  Degre := iDegre;
  nbAppelsDePi1deX := 0;
  nbAppelsDePi2deX := 0;
  nbAppelsDePdeX := 0;
  try // précision pour affichage final :
    pr := frmEquas7.edPrecision.text;
    po := pos('E', pr);
    c0 := copy(pr, 1, po - 1);
    cm1 := copy(pr, po + 2, maxInt);
    cp1 := stringOfChar('0', StrToInt(cm1));
    cp1 := cp1 + c0;
    insert(DecimalSeparator, cp1, 2);
    gev := StrToGR(cp1);

    SetLength(cAAiGC, Degre + 3); // indices [0] inutilisés
    // Chargement coeffs
    ic := 0;
    with frmEquas7 do // Récup coeffs de l'utilisateur :
    begin
      for i := 0 to ComponentCount - 1 do
        if (components[i] is tEdit) and ((components[i] as tEdit).tag = -3) then
        begin
          inc(ic);
          sCoef := (components[i] as tEdit).text;
          cAAiGC[ic] := StrToGC(sCoef);
        end;
    end;
    // Polynôme unitaire par division par le coefficient du monôme dominant
    // Ne modifie pas la valeur des racines mais divise également les f(x)
    SetLength(cAAUGC, High(cAAiGC));
    coeffMD := cAAiGC[1]; // coefficient du monôme dominant
    for i := 1 to N + 1 do
      cAAUGC[i] := DivGC(cAAiGC[i], coeffMD);

    SetLength(cAAGC, High(cAAiGC));
    for i := 1 to N + 1 do
      cAAGC[i] := cAAUGC[i];

    SetLength(cBGC, High(cAAGC));

    SetLength(vRXGC, Degre + 3);
    for i := Low(vRXGC) to High(vRXGC) do
      vRXGC[i] := GC0;

    SetLength(cD1GC, High(cAAGC));
    SetLength(cD1GCU, High(cAAGC));
    SetLength(cD2GCU, High(cAAGC));
    SetLength(cPLGC, 3);

    SetLength(cD2GC, High(cAAGC));
    // Pour Newton et Laguerre :
    GenDeriveePrem;
    GenDeriveeSec;
    // Pour Maxi / Mini dans tracé de courbe :
    GenD1deXiniGCU;
    GenD2deXiniGCU;
  except
    raise;
  end;
  Result := true;
end;

function Ro1InfRo2GC(z1, z2: tGC): boolean;
var
  ro1, ro2: tGR;
begin
  ro1 := RoCarreeGR(z1);
  ro2 := RoCarreeGR(z2);
  if CompAbsGR(ro1, ro2) < 0 then
    Result := true
  else
    Result := false;
end; // Ro1InfRo2GC(z1,z2

function Ro1InfOuEgalRo2GC(z1, z2: tGC): boolean;
var
  ro1, ro2: tGR;
  comp: shortInt;
begin
  ro1 := RoCarreeGR(z1);
  ro2 := RoCarreeGR(z2);
  comp := CompAbsGR(ro1, ro2);
  if (comp < 0) or (comp = 0) then
    Result := true
  else
    Result := false;
end; // Ro1InfOuEgalRo2GC

function Z1ZGCInfAOuEgal(z1, z2: tGC): boolean;
var
  ro1, ro2: tGR;
  comp: shortInt;
begin
  ro1 := RoCarreeGR(z1);
  ro2 := RoCarreeGR(z2);
  //if z1.a<0 then ro1:=-ro1 :
  if CompAlgGR(z1.a, GR0) < 0 then
    ro1 := MulGR(GR_1, ro1); //ro1:=-ro1;

  //if z2.a<0 then ro2:=-ro2 :
  if CompAlgGR(z2.a, GR0) < 0 then
    ro2 := MulGR(GR_1, ro2); //ro2:=-ro2;

  //if ro1<=ro2 then Result:=true else Result:=false;
  comp := CompAlgGR(ro1, ro2);
  if (comp < 0) or (comp = 0) then
    Result := true
  else
    Result := false;
end; // Z1ZGCInfAOuEgal

function Z1InfZ2GC(z1, z2: tGC): boolean;
var
  ro1, ro2: tGR;
  comp: shortInt;
begin
  ro1 := RoCarreeGR(z1);
  ro2 := RoCarreeGR(z2);
  //if z1.a<0 then ro1:=-ro1 :
  if CompAlgGR(z1.a, GR0) < 0 then
    ro1 := MulGR(GR_1, ro1); //ro1:=-ro1
  //if z2.a<0 then ro2:=-ro2 :
  if CompAlgGR(z2.a, GR0) < 0 then
    ro2 := MulGR(GR_1, ro2); //ro2:=-ro2
  //if ro1<ro2 then Result:=true else Result:=false;
  comp := CompAlgGR(ro1, ro2);
  if comp < 0 then
    Result := true
  else
    Result := false;
end; // Z1InfZ2GC

function MinGC(z1, z2: tGC): tGC;
begin
  if Z1InfZ2GC(z1, z2) then
    Result := z1
  else
    Result := z2;
end;

function Ro1SurRo2GR(z1, z2: tGC): tGR;
var
  ro1, ro2: tGR;
begin
  ro1 := RoCarreeGR(z1);
  ro2 := RoCarreeGR(z2);
  if GRNul(ro2) then
    Result := GRPlusInfini
  else
    Result := DivGR(ro1, ro2);
end;

function oEqua.TestSurValEntiereGC(vAX: tGC): tGC; //
//        Test sur valeur entière : risque de générer de fausses racines doubles
//        donc utilisé uniquement pour cas de racine unique multiple
var
  vAE, PP, PvAE, mieux: tGC;
  ArrA, ArrB: tGR;
begin
  Result := vAX;
  mieux := vaX;
  PP := FdeXiniGC(vaX);
  ArrA := RoundGR(vaX.a);
  ArrB := RoundGR(vaX.b);

  // Doublement arrondi :
  vAE.a := ArrA;
  vAE.b := ArrB;
  PP := FdeXiniGC(mieux);
  PvAE := FdeXiniGC(vAE);
  if EgalZeroGC(PvAE) then
  begin
    Result := vAE;
    EXIT;
  end;
  if (CompAbsGC(PvAE, PP) <= 0) then
    mieux := vAE;

  // Arrondi sur a
  vAE.a := ArrA;
  vAE.b := vaX.b;
  PP := FdeXiniGC(mieux);
  PvAE := FdeXiniGC(vAE);
  if EgalZeroGC(PvAE) then
  begin
    Result := vAE;
    EXIT;
  end;
  if (CompAbsGC(PvAE, PP) <= 0) then
    mieux := vAE;
  // Arrondi sur b
  vAE.a := mieux.a;
  vAE.b := ArrB;
  PP := FdeXiniGC(mieux);
  PvAE := FdeXiniGC(vAE);
  if EgalZeroGC(PvAE) then
  begin
    Result := vAE;
    EXIT;
  end;
  if (CompAbsGC(PvAE, PP) <= 0) then
    mieux := vAE;

  Result := mieux;
end; // oEqua.TestSurValEntiereGC(vAX

{function  Horner(P : array of extended; Deg : integer; X : Extended) : extended;  (Modèle)
//        indice P[0] inutilisé
//        A appeller après SetLength(P,Deg+2);
var       i : integer;
begin     Result:=P[1];
          for i:=2 to Deg+1 do
          begin Result:=x*Result + P[i];
                sms('i = '+intToStr(i));
          end;
end; }

function oEqua.EvalHornerGC(P: array of tGC; Deg: integer; vX: tGC): tGC;
var
  i: integer;
  Res: tGC;
begin
  Res := GC0;
  Res := P[1];
  for i := 2 to Deg + 1 do
  begin
    Res := MulGC(vX, Res);
    Res := AddGC(Res, P[i]);
  end;
  Result := Res;
end; // oEqua.EvalHornerGC

function oEqua.FdeXGC(vX: tGC): tGC; // Valeurs des P(x) pour Poly courant
//        avec Horner :
begin
  inc(nbAppelsDePdeX);
  Result := EvalHornerGC(cAAGC, N, vX);
end; // oEqua.FdeXGC(vX

function oEqua.FdeXiniGC(vX: tGC): tGC; // pour Poly initial
begin
  inc(nbAppelsDePi2deX);
  Result := EvalHornerGC(cAAiGC, Degre, vX);
end; // oEqua.FdeXiniGC(vX

procedure oEqua.GenDeriveePrem; // de f(x) de l'unitaire
var
  i: integer;
  co: tGC;
begin
  for i := 1 to N do
  begin
    co.a := Int64ToGR(N - i + 1);
    co.b := GR0;
    cD1GC[i] := MulGC(cAAGC[i], co);
  end;
end;

procedure oEqua.GenDeriveeSec; // de f(x) de l'unitaire
var
  i: integer;
  co: tGC;
begin
  for i := 1 to N - 1 do
  begin
    co.a := Int64ToGR(N - i);
    co.b := GR0;
    cD2GC[i] := MulGC(cD1GC[i], co);
  end;
end;

procedure oEqua.GenD1deXiniGCU;
  // génère dérivée première de f(X) de l'utilisateur
var
  i: integer;
  co: tGC;
begin
  for i := 1 to N do
  begin
    co.a := Int64ToGR(N - i + 1);
    co.b := GR0;
    cD1GCU[i] := MulGC(cAAiGC[i], co);
  end;
end;

procedure oEqua.GenD2deXiniGCU;
  // génère dérivée seconde de f(X) de l'utilisateur
var
  i: integer;
  co: tGC;
begin
  for i := 1 to N - 1 do
  begin
    co.a := Int64ToGR(N - i);
    co.b := GR0;
    cD2GCU[i] := MulGC(cD1GCU[i], co);
  end;
end;

function oEqua.GenXBLaguerreGC: integer;
//        B(x) = x²  + (2/n).an-1.x  + [2(n - 1).an-2  - (n - 2).a²n-1]/n.
var
  coDeg, coef, zt1, zt2: tGC;
  rep: tNRacines;
  s: string;
begin
  cPLGC[0] := GC1; //<- coef de x² (= 1)
  coDeg.a := Int64ToGR(N);
  coDeg.b := GR0;
  if N = 0 then // éviter div par 0
  begin
    Result := 0;
    TraceZGC('N = 0 dans GenXBLaguerreGC !!!');
    EXIT;
  end;

  coef := DivGC(GC2, coDeg);
  cPLGC[1] := MulGC(coef, cAAGC[2]); //coef de x (=(2/n).an-1)

  zt1 := DifGC(coDeg, GC1);
  zt1 := MulGC(zt1, GC2);
  zt1 := MulGC(zt1, cAAGC[3]);

  zt2 := DifGC(coDeg, GC2);
  zt2 := MulGC(zt2, cAAGC[2]);
  zt2 := MulGC(zt2, cAAGC[2]);
  coef := DifGC(zt1, zt2);
  cPLGC[2] := DivGC(coef, coDeg); //= [2(n - 1).an-2  - (n - 2).a²n-1]/n.

  rep := Equa2emeDegreGC(cPLGC[0], cPLGC[1], cPLGC[2]);

  BLag1 := GC0;
  BLag2 := GC0;
  nBornesLag := rep.count;
  TraceZGC2(cls, normal, 'Arial', 10, [fsBold], clBlack);
  s := 'Avec bornes de Laguerre au degré ' + intToStr(N) +
    ' : -------------------' + cls;
  TraceZGC2(cls + s, normal, 'Arial', 10, [fsBold], clBlack);
  case nBornesLag of
    1:
      begin
        BLag1 := StrToGC(rep[0]); // borne unique double
        s := cls + '- Borne unique double : ';
        TraceZGC2(s, normal, 'Arial', 10, [fsBold], clBlack);
        s := cls + '  ' + GCToStrECut(BLag1, NAT);
        TraceZGC2(s, normal, 'Arial', 10, [], clBlack);
      end;
    2:
      begin
        BLag1 := StrToGC(rep[1]); // borne inf
        s := cls + '- Borne inférieure : ';
        TraceZGC2(s, normal, 'Arial', 10, [fsBold], clBlack);
        s := cls + '  ' + GCToStrECut(BLag1, NAT) + cls;
        TraceZGC2(s, normal, 'Arial', 10, [], clBlack);

        BLag2 := StrToGC(rep[0]); // borne sup
        s := cls + '- Borne supérieure : ';
        TraceZGC2(s, normal, 'Arial', 10, [fsBold], clBlack);
        s := cls + '  ' + GCToStrECut(BLag2, NAT) + cls;
        TraceZGC2(s, normal, 'Arial', 10, [], clBlack);
      end;
  end;
  Result := nBornesLag;
  rep.free;
end; // oEqua.GenXBLaguerreGC

function oEqua.D1deXGC(vX: tGC): tGC; // Valeur de la Dérivée Première
begin
  Result := EvalHornerGC(cD1GC, N - 1, vX);
end;

function oEqua.D1deXiniGCU(vX: tGC): tGC;
  // renvoie valeur de la dérivée première de f(X) de l'utilisateur
begin
  Result := EvalHornerGC(cD1GCU, Degre - 1, vX);
end;

function oEqua.D2deXGC(vX: tGC): tGC; // Valeur de la Dérivée Seconde
begin
  Result := EvalHornerGC(cD2GC, N - 2, vX);
end;

function oEqua.D2deXGCU(vX: tGC): tGC; // Valeur de la Dérivée 2 de l'Utilisateur
begin
  Result := EvalHornerGC(cD2GCU, Degre - 2, vX);
end;

function oEqua.XANewtonGC(vAX: tGC): tGC; // Affinage par Méthode de Newton
//        Bof : XANewtonGC est globalement 1,6 fois plus lent que XALaguerreGC
//        XANewtonGC converge en 6 fois plus de tours de boucle que XALaguerreGC
//        mais comme les calculs avec XANewtonGC sont moins nombreux il fallait comparer.
//        Donc utilisé ici uniquement par l'unité uCourbe pour les Maxi/Mini
label
  Sortie;
var
  vA, vAN, FDe, FPrec, DDe, XN, dx: tGC;
  cmpaEv, cmpbEv: shortInt;
  Epsilon: tGR;
begin
  vA := vAX;
  DeriveeNulleNewton := false;
  FDe := D1deXiniGCU(vA); // FDe = f(x)
  vAN := vAX;
  if AbsInfOuEgalALimiteGC(FDe, gEv) then
  begin
    vAN := vAX;
    goto Sortie;
  end;

  Epsilon := ExtendedToGR(1E-8);
  FPrec.a := AbsGR(FDe.a);
  FPrec.a := AddGR(Epsilon, FPrec.a);
  FPrec.b := AbsGR(FDe.b);

  while Ro1InfRo2GC(FDe, FPrec) do
  begin
    vAN := vA;
    if EgalZeroGC(Fde) then
      goto Sortie;

    DDe := D2deXGCU(vA); // DDe = f'(x)
    if not AbsInfAEpsilonGC(DDe) then
    begin
      dx := DivGC(FDe, DDe);
      XN := DifGC(vA, dx);
    end
    else
    begin // Dérivée nulle peut coincider avec racine multiple
      cmpaEv := CompAbsGR(FDe.a, gEv);
      cmpbEv := CompAbsGR(FDe.b, gEv);
      if (cmpaEv < 0) and (cmpbEv < 0) then
      begin
        XN := vA;
        vAN := vA;
      end
      else
        DeriveeNulleNewton := true;
      goto Sortie;
    end;
    if Echapper then
      Break;
    vA := XN;
    FPrec := FDe;
    FDe := D1deXiniGCU(vA);
  end; // while
  Sortie:
  Result := vAN;
end; // oEqua.XANewtonGC(vX

procedure oEqua.TraceCoeffs;
  // Renvoie trace des Coefficients du polynôme P(X) au degré N
var
  i: integer;
begin
  frmTrace.red2.lines.add('Coeffs de l''équa à ce degré :');
  for i := 1 to N + 1 do
    frmTrace.red2.lines.add('   - a' + intToStr(i - 1) + '=' +
      GCToStrNS15(cAAGC[i]));
end;

function oEqua.XALaguerreGC(vAX: tGC): tGC;
  // Affinage d'une racine par Méthode de Laguerre
label
  Sortie;
var
  cn, cnMoinsUn, PDe, vALag, vAi, FPrec: tGC;

  function XAL(vA: tGC): tGC;
    //       Result = vA + DeltaX
  var
    f, fPrim, fPrimKr, fSec, num, den1, den2, sousRac, sousRac2,
      rac1, rac2, Xden1, Xden2: tGC;
    DeuxRacines: tNRacines;
    Div0_2x: integer;
    s: string;
    ok1, ok2: boolean;
  begin
    f := FdeXGC(vA);
    // Exit si "f(vA) = 0" car :
    // a) le deltaX est nul
    // b) et en plus si vA est une racine multiple f' et f'' seraient aussi nuls
    if EgalZeroGC(f) then
    begin
      Result := vA;
      EXIT;
    end;

    fPrim := D1deXGC(vA);
    fSec := D2deXGC(vA);

    if EgalZeroGC(fPrim) and EgalZeroGC(fSec) then
    begin
      DeriveesNullesLag := true;
      Result := vA;
      s := 'Deux dérivées f'' et f'''' nulles chez Laguerre (Division par zéro) au degré '
        + intToStr(N) + cLS
        + '  pour X = ' + GCToStrE(vA) + cLS
        + '  f = ' + GCToStrE(f) + cLS
        + '  f'' = ' + GCToStrE(fPrim) + cLS
        + '  f'''' = ' + GCToStrE(fSec) + cLS;
      TraceZGC(s);
      TraceCoeffs;
      EXIT;
    end
    else
      DeriveesNullesLag := false;

    num := MulGC(cn, f);

    sousRac := CarreGC(cnMoinsUn);
    fPrimKr := CarreGC(fPrim);
    sousRac := MulGC(sousRac, fPrimKr);

    sousRac2 := MulGC(cn, cnMoinsUn);
    sousRac2 := MulGC(sousRac2, f);
    sousRac2 := MulGC(sousRac2, fSec);

    sousRac := DifGC(sousRac, sousRac2);

    DeuxRacines := RacineCarree4GC(sousRac);

    fPrim.a := ChangeSigneGR(fPrim.a);
    fPrim.b := ChangeSigneGR(fPrim.b); // - f'
    Div0_2x := 0;
    ok1 := false;
    ok2 := false;

    rac1 := StrToGC(DeuxRacines[0]); // rad positif
    den1 := AddGC(fPrim, rac1);
    if EgalZeroGC(den1) then
      inc(Div0_2x)
    else
    begin
      Xden1 := DivGC(num, den1);
      Xden1 := AddGC(Xden1, vA);
      ok1 := true;
    end;

    rac2 := StrToGC(DeuxRacines[1]); // rad négatif

    den2 := AddGC(fPrim, rac2);
    if EgalZeroGC(den2) then
      inc(Div0_2x)
    else
    begin
      Xden2 := DivGC(num, den2);
      Xden2 := AddGC(Xden2, vA);
      ok2 := true;
    end;

    if (not ok1) and (not ok2) then
      Result := vA;
    if ok1 and (not ok2) then
      Result := Xden1;
    if ok2 and (not ok1) then
      Result := Xden2;
    if ok1 and ok2 then
    begin
      if Ro1InfRo2GC(den1, den2) then
        Result := Xden2
      else
        Result := Xden1;
    end;
    DeuxRacines.free;
    if Div0_2x = 2 then
    begin
      s := 'Cas particulier : Deux dénominateurs nuls chez Laguerre au degré ' +
        intToStr(N) + cLS
        + '  pour X = ' + GCToStrE(vA) + cLS
        + '  f = ' + GCToStrE(f) + cLS
        + '  f'' = ' + GCToStrE(fPrim) + cLS
        + '  f'''' = ' + GCToStrE(fSec) + cLS;
      TraceZGC(s);
      TraceCoeffs;
      DeriveesNullesLag := true;
      sms('Deux dénominateurs nuls chez Laguerre : Division par zéro' + cLS
        + 'au degré ' + intToStr(N));
      Result := vA;
    end;
  end; // XAL(vA)

begin // Test avec Newton :
  // Result:=XANewtonGC(vAX); Newton : 1,6 fois plus lent
  // EXIT;
  PDe := FdeXGC(vAX);
  DeriveesNullesLag := false;

  if EgalZeroGC(PDe) then
  begin
    vALag := vAX;
    goto Sortie;
  end;

  cn.a := Int64ToGR(N);
  cn.b := GR0;
  cnMoinsUn.a := Int64ToGR(N - 1);
  cnMoinsUn.b := GR0;

  fPrec := StrToGC('100000000000000000000000');
  vALag := vAX;
  repeat vAi := XAL(vALag);
    PDe := FdeXiniGC(vAi);
    if Ro1InfRo2GC(PDe, FPrec) then
    begin
      vALag := vAi;
      fPrec := PDe;
    end
    else
      Break;
    if AbsInfAEpsilonGC(PDe) or DeriveesNullesLag then
      Break;
  until Echapper;
  Sortie:
  Result := vALag;
end; // oEqua.XALaguerreGC(vAX

function oEqua.GenEqRacSupplemGC(rac: tGC): tStringList;
// Génère equa de degré N+1 avec une racine supplémentaire
var
  CoeffN, CoeffS: tStringlist;
  CoefC, Cic, Cpc, Prod: tGC;
  i: integer;
begin
  CoeffN := tStringList.create;
  with frmEquas7 do
  begin
    for i := 0 to ComponentCount - 1 do
      if (components[i] is tEdit) and ((components[i] as tEdit).tag = -3) then
        CoeffN.Add((components[i] as tEdit).text);
    CoeffS := tStringList.create;
    for i := 0 to Degre + 1 do
    begin
      if i = 0 then
      begin
        CoefC := StrToGC(CoeffN[0]);
      end
      else if i = Degre + 1 then
      begin
        CoefC := StrToGC(CoeffN[Degre]);
        CoefC := MulGC(Rac, CoefC);
        CoefC := MulGC(GC_1, CoefC);
      end
      else
      begin
        Cic := StrToGC(CoeffN[i]);
        Cpc := StrToGC(CoeffN[i - 1]);
        Prod := MulGC(Rac, Cpc);
        Prod := MulGC(GC_1, Prod);
        CoefC := AddGC(Cic, Prod);
      end;
      CoeffS.add(GCToStrE(CoefC));
    end;
    Degre := Degre + 1;
  end;
  CoeffN.free;
  Result := CoeffS;
end; // oEqua.GenEqRacSupplemGC

function oEqua.GenEqFragRacConnueGC(rac: tGC): tStringList;
// Génère equa de degré N-1 avec racine connue : Appels externes
var
  i, p: integer;
  CoeffN, CoeffS: tStringlist;
  coefA, coefB, Somm: tGC;
begin
  CoeffN := tStringList.create;
  with frmEquas7 do
  begin
    for i := 0 to ComponentCount - 1 do
      if (components[i] is tEdit)
        and (((components[i] as tEdit).tag = -2) or
        ((components[i] as tEdit).tag = -3)) then
        CoeffN.Add((components[i] as tEdit).text);
    CoeffS := tStringList.create;
    for p := 0 to CoeffN.count - 2 do
    begin
      if p = 0 then // "b0 = a0"
      begin
        coefA := StrToGC(CoeffN[0]);
        coefB := coefA;
      end
      else if p = 1 then // "b1 = a1 + r.a0"
      begin
        coefA := StrToGC(CoeffN[1]);
        Somm := MulGC(rac, StrToGC(CoeffN[0]));
        Somm := AddGC(coefA, Somm);
        coefB := Somm;
      end
      else if p > 1 then // "bp = ap + r.bp-1 où bp-1 = Somm"
      begin
        coefA := StrToGC(CoeffN[p]);
        Somm := MulGC(rac, Somm);
        Somm := AddGC(coefA, Somm);
        coefB := Somm;
      end;
      CoeffS.add(GCToStrE(coefB));
    end; // for p:=0
    N := N - 1;
  end; // with frm
  CoeffN.free;
  Result := CoeffS;
end; // oEqua.GenEqFragRacConnueGC

procedure oEqua.ReducDegEquaGC(Rac: tGC);
//        Génère équa de degré N-1 avec racine connue
var
  p: integer;
  Somm: tGC;
begin
  for p := 1 to High(cBGC) do
    cBGC[p] := GC0;
  for p := 1 to N do
  begin
    if p = 1 then
      cBGC[1] := cAAGC[1]; // si p=1 alors "b0 = a0" donc cAAGC[1] inchangé
    if p = 2 then // "b1 = a1 + r.a0"
    begin
      Somm := MulGC(rac, cAAGC[1]);
      Somm := AddGC(cAAGC[2], Somm);
      cBGC[2] := Somm;
    end
    else if p > 2 then // "bp = ap + r.bp-1 où bp-1 = Somm "
    begin
      Somm := MulGC(rac, Somm);
      Somm := AddGC(cAAGC[p], Somm);
      cBGC[p] := Somm;
    end;
  end;
  N := N - 1;
  for p := 1 to High(cBGC) do
    cAAGC[p] := cBGC[p];
  SetLength(cBGC, N + 1);
  GenDeriveePrem;
  GenDeriveeSec;
end; // oEqua.ReducDegEquaGC

function oEqua.ResoudreAvecLagGC: boolean;
//        Résolution par calcul, à chaque degré, de la plus petite et de la plus grande racine
//        broutage depuis le HAUT et le BAS
label
  Saut, Sortie;
var
  i, iRacines: integer;
  cmpa, cmpb: shortInt;
  s: string;

  procedure Progression;
  begin
    with frmEquas7 do
    begin
      plCurProg.caption := intToStr(iRacines) + '/' + intToStr(Degre);
      plCurProg.width := round(iRacines * plProgress.ClientWidth / Degre);
      plCurProg.refresh;
      plProgress.refresh;
    end;
  end;

  procedure TraceNumEtape(i: integer);
  begin
    frmTrace.red2.lines.add('Etape ' + intToStr(i));
  end;

begin
  iRacines := 0;
  Result := false;
  with frmEquas7 do
  begin
    plCurProg.width := 0;
    plProgress.top := 50;
    plProgress.left := 0;
    plProgress.visible := true;
  end;
  RazTrace;
  TraceZGC2('Ordre chronologique de résolution', normal, 'Arial', 10, [fsBold],
    clGreen);
  Saut:
  nBornesLag := GenXBLaguerreGC;
  case nBornesLag of
    0:
      begin
        Result := false;
        TraceZGC('Pas de borne de Laguerre');
      end;
    1:
      begin //Borne unique donne racine unique de degré N si DeriveesNullesLag=False
        inc(iRacines);
        Progression;
        vRXGC[iRacines] := XALaguerreGC(BLag1);
        if DeriveesNullesLag then
        begin
          TraceZGC2(cls + cls + 'Racine(s) indéterminée(s)', normal, 'Arial', 10,
            [fsBold], clRed);
          s := cls + 'Générer une équa de degré N+1 avec une racine-joker'
            + ' et lancer sa résolution pour trouver cette racine plus celles'
            + ' de l''équation précédente de degré N';
          TraceZGC2(s, normal, 'Arial', 10, [fsBold], clTeal);
          Result := False;
          goto Sortie;
        end;
        vRXGC[iRacines] := TestSurValEntiereGC(vRXGC[iRacines]);
        i := Degre;
        repeat cmpa := CompAlgGR(vRXGC[i].a, GR0);
          cmpb := CompAlgGR(vRXGC[i].b, GR0);
          if (cmpa = 0) and (cmpb = 0) then
            vRXGC[i] := vRXGC[iRacines];
          dec(i);
        until (i = 0) or (cmpa <> 0) or (cmpb <> 0);
        if N = 1 then
          s := ''
        else
          s := 'multiple';
        TraceZGC2(' ' + chr(240) + ' ', normal, 'WingDings', 10, [fsBold],
          clGreen);
        TraceZGC2('Racine unique ' + s + ' X' + intToStr(iRacines) + ' = '
          + GCToStrECut(vRXGC[iRacines], NAT), normal, 'Arial', 10, [fsBold],
            clGreen);
        Result := true;
        goto Sortie;
      end;
    2:
      begin // racine la plus grande à ce degré :
        inc(iRacines);
        Progression;
        vRXGC[iRacines] := XALaguerreGC(BLag2);
        if DeriveesNullesLag then
          goto Sortie;
        TraceRacine(iRacines, BLag2, '');

        // racine la plus petite à ce degré :
        inc(iRacines);
        Progression;
        vRXGC[iRacines] := XALaguerreGC(BLag1);
        if DeriveesNullesLag then
          goto Sortie;
        TraceRacine(iRacines, BLag1, '');
        //Réduc Deg équa de 2
        ReducDegEquaGC(vRXGC[iRacines - 1]);
        ReducDegEquaGC(vRXGC[iRacines]);
        if iRacines < Degre then
          goto Saut
        else
          Result := True;
      end;
  end; // case of
  Sortie:
  frmEquas7.plProgress.visible := false;
end; // oEqua.ResoudreAvecLagGC

function ExtMinAbs(Val1: tGR; Val2: Extended): Extended;
var
  Val1E: Extended;
begin
  Val1E := Abs(GRToExtended(Val1));
  if Val1E < Val2 then
    Result := Val1E
  else
    Result := Val2;
end;

function ExtMaxAbs(Val1: tGR; Val2: Extended): Extended;
var
  Val1E: Extended; // s1 : string; code : integer;
begin
  Val1E := Abs(GRToExtended(Val1));
  if Val1E > Val2 then
    Result := Val1E
  else
    Result := Val2;
end;

procedure oEqua.AfficherResultatGC;
var
  i, j, nrm, jrd, po: integer;
  ed: tEdit;
  slRacNum: tStringList;
  fr: tGC;
  sri: shortString;
  s: string;
  ecMax, ecMin: Extended;
  rac: tGC;
  cmpa, cmpb: shortInt;
  Epsa: tGR;
  RXAff: array of tGC;

begin // Racines intégrales triées en ordre croissant
  SetLength(vRCGC, length(vRXGC));
  for i := 1 to Degre do
    vRCGC[i] := vRXGC[i];
  QuickSortGC(vRCGC);
  // Racines éventuellement tronquées pour affichage triées en ordre croissant
  SetLength(RXAff, length(vRXGC));
  for i := 1 to Degre do
    RXAff[i] := vRCGC[i];

  if not frmEquas7.cbAffichage.Checked then
    //pas afficher si val<10puissance-Epsa
  begin
    Epsa := StrToGR('1.0E' + frmEquas7.edMargeAff.text);
    for i := 1 to Degre do
    begin
      if CompAbsGR(RXAff[i].a, Epsa) < 0 then
        RXAff[i].a := GR0;
      if CompAbsGR(RXAff[i].b, Epsa) < 0 then
        RXAff[i].b := GR0;
    end;
  end;
  slRacA := tStringList.create;
  for i := 1 to Degre do
    slRacA.Add(GCToStrECut(RXAff[i], NA));
  if slRacA.count >= 2 then
  begin
    i := 0;
    j := 1;
    nrm := 1; // recherche racines multiples
    repeat sri := slRacA[i];
      while (j <= slRacA.Count - 1) and (slRacA[j] = slRacA[i]) do
      begin
        inc(nrm);
        slRacA.Delete(j);
      end;
      if nrm > 1 then // marquage racines multiples
      begin
        slRacA[i] := 'rm' + intToStr(nrm) + ' = ' + sri;
        nrm := 1;
      end;
      inc(i);
      inc(j);
    until (j > slRacA.count - 1);
  end;
  jrd := 0; // marquage des racines isolées
  for i := 0 to slRacA.count - 1 do
    if pos('rm', slRacA[i]) = 0 then
    begin
      inc(jrd);
      slRacA[i] := 'x' + intToStr(jrd) + ' = ' + slRacA[i];
    end;
  // Récup val num
  slRacNum := tStringList.create;
  slRacNum.addStrings(slRacA);
  for i := 0 to slRacNum.Count - 1 do
  begin
    po := pos('=', slRacNum[i]);
    sri := slRacNum[i];
    Delete(sri, 1, po + 1);
    slRacNum[i] := sri;
  end;
  // Affichage :
  ecMax := 0;
  ecMin := 1E4931;
  for i := 0 to slRacA.Count - 1 do
  begin
    ed := tEdit.create(frmEquas7);
    with ed do
    begin
      parent := frmEquas7.ScrollRacines;
      font.style := [fsBold];
      fr := FdeXiniGC(StrToGC(slRacNum[i]));
      //si fr.a<>0 :
      if not GRNul(fr.a) then
      begin
        ecMin := ExtMinAbs(fr.a, ecMin);
        ecMax := ExtMaxAbs(fr.a, ecMax);
      end;
      //si fr.b<>0 :
      if not GRNul(fr.b) then
      begin
        ecMin := ExtMinAbs(fr.b, ecMin);
        ecMax := ExtMaxAbs(fr.b, ecMax);
      end;
      //si <= Epsilon :
      if AbsInfAEpsilonGC(fr) then
      begin
        font.color := clGreen;
        ecMin := 0;
      end
      else
      begin
        if AbsInfOuEgalALimiteGC(fr, gEv) then
        begin
          font.color := clTeal;
        end
        else
        begin //si (abs(fr.a)<=1) et (abs(fr.b)<=1)
          cmpa := CompAbsGR(fr.a, GR1);
          cmpb := CompAbsGR(fr.b, GR1);
          if ((cmpa < 0) or (cmpa = 0))
            and ((cmpb < 0) or (cmpb = 0)) then
            font.color := clFuchsia
          else
            font.color := clRed;
        end;
      end;
      BorderStyle := bsNone;
      color := clBtnHighlight;
      rac := StrToGC(slRacNum[i]);
      po := pos('=', slRacA[i]);
      text := Copy(slRacA[i], 1, po + 1) + GCToStrECut(rac, NA);
      left := 0;
      autoSize := false;
      width := frmEquas7.edFdeX.width;
      top := 6 + i * 20;
      height := 17;
      visible := true;
      onDblClick := frmEquas7.edFdeXDblClick;
      Hint := 'Dbl-click = vérification de f(x) = Epsilon' + cls
        + '(avec la valeur affichée)';
      ShowHint := true;
      tag := +4;
      UpDate;
    end; // with ed
  end; // for
  ChampsResultatsExistent := True;
  s := 'Ecarts par rapport à f(x) = 0' + cLS
    + '- min  = ' + FloatToStr(ecMin) + cLS
    + '- max = ' + FloatToStr(ecMax);
  LRFlotte(s, 60, clBeige, clWhite);
end; // oEqua.AfficherResultatGC

// Gestion Fiche >>>-----------------------------------------------------------

procedure TfrmEquas7.FormResize(Sender: TObject);
var
  cw: integer;
begin
  cw := ClientWidth;
  panel1.width := cw - 10;
  edFdeX.width := panel1.Width - edFdeX.left - 30;
  edFdeX.Update;
  bevel2.width := edFdeX.width;
  scrollRacines.width := edFdeX.width;
  plProgress.width := edFdeX.width;
  scrollRacines.height := scrollCoeffs.height;
  labDefile.top := ClientHeight - labDefile.height - 1;
  AjusterChampsResultats;
end;

procedure TfrmEquas7.plHautMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssLeft in Shift then
    Deplacement(frmEquas7, X, Y);
end;

//        Texte défilant dans labDefile

procedure TfrmEquas7.Timer1Timer(Sender: TObject);
const
  Saut = 1;
begin
  labDefile.Caption := Copy(labDefile.Caption, Saut + 1,
    Length(labDefile.Caption) - Saut)
    + Copy(labDefile.Caption, 1, Saut);
end;

procedure TfrmEquas7.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ssCtrl in shift then
  begin
    case key of
      77: {M} frmFlotte2.show; // restitution courante
      220, 106: { * } sms('G. Geyer 2007-2009');
    end;
  end;
end;

var
  AncSysLocale: TSysLocale;

procedure TfrmEquas7.FormCreate(Sender: TObject);
begin
  caption := 'Equations de Degré N à coefficients réels ou complexes';
  ChampsSaisie.Cree(5);
  edFDeX.text := '';
  edFDeX.Hint := 'Dbl-click = f(x) pour toute valeur de x' + cls
    + '(entrer x et double-clicker dessus)';
  edDegre.enabled := false;
  AncSysLocale := SysLocale;
  SysLocale.MiddleEast := True;
  edDegre.BiDiMode := bdRightToLeft;
  labPrecision.top := bAutreDegre.top + 4;
  edPrecision.top := bAutreDegre.top + 4;
  edPrecision.hint := '0 < Epsilon < 1';
  edDegre.hint := 'Degré de l''équation' + cLS + 'mini = 2';
  bResoudre.enabled := false;
  bVoirCourbe.enabled := false;
  bImprimer3.enabled := false;
  bImprimer3.hint := 'Click-souris-Gauche = imprimer équation ET racines' + cLS
    + 'Click-souris-Droite = imprimer équation OU racines, ...';
  Equa.ChampsDeSaisieNeufs := true;

  bResoudre.Hint := 'Résolution utilisant des chaînes numériques' + cls
    + '(nombre de chiffres significatifs au choix)';
  bVoirPlus.Hint := 'Voir plus de détails';
  bVoirPlus.enabled := false;
  Application.HintHidePause := 10000;
  if FileExists(RepAppli + 'Aide_Equas_Calc8.chm') then
    bAide.enabled := True
  else
  begin
    bAide.Hint := 'Fichier d''Aide non trouvé';
    bAide.enabled := False;
  end;
  if bAide.enabled then
  begin
    bAide.Hint := 'Aide :' + cls
      + 'Si l''aide ne fonctionne pas sous Vista, ouvrir sous' + cls
      + 'l''Explorateur les propriétés du fichier Aide_Equas_Calc7.chm' + cls
      + 'avec un click-souris-Droite sur ce fichier, puis clicker' + cls
      + 'sur ''Débloquer'' de l''option ''Sécurité''';
  end;
end;

var
  ancDecimalSepartor: char;

procedure TfrmEquas7.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DecimalSeparator := ancDecimalSepartor;
  SysLocale := AncSysLocale;
end;

const
  esp = ['0'..'9', '+', '-', '.', 'i', '*', 'e', 'E', Chr(VK_BACK)];

procedure TfrmEquas7.edCoEquaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = 'e' then
    Key := 'E';
  if not (Key in esp) then
    Key := #0;
end;

procedure TfrmEquas7.edFdeXKeyPress(Sender: TObject; var Key: Char);
begin
  edCoEquaKeyPress(Sender, Key);
end;

procedure TfrmEquas7.edCoEquaChange(Sender: TObject);
var
  ed: tEdit;
begin
  cacheFlotte2(frmEquas7, nil);
  if frmCourbe.Visible then
    frmCourbe.Hide;
  ed := (Sender as tMonEdit);
  ed.tag := -3;
  if pos('a', ed.text) > 0 then
    ed.Font.Color := clFuchsia
  else
    ed.Font.Color := clBlack;
  bResoudre.enabled := True;
  bVoirCourbe.enabled := False;
  if ChampsResultatsExistent then
    LibererChampsResultats;
end;

procedure TfrmEquas7.GenEquaARacineUniqueClick(Sender: TObject);
var
  valRac, scoeff: string;
  p, Deg, coDegMoinsP, code, ied: integer;
  coCoef, coSigne, coPuiss, coRu, fru: tGC;
  ClickOk: boolean;

  function idEditSuivant(var i: integer): tMonEdit;
  var
    ok: boolean;
  begin
    ok := false;
    repeat inc(i);
      if (components[i] is tMonEdit)
        and (((components[i] as tMonEdit).tag = -2) or
        ((components[i] as tMonEdit).tag = -3)) then
        ok := true;
    until ok or (i = ComponentCount - 1);
    if ok then
      Result := (components[i] as tMonEdit)
    else
      Result := nil;
  end;

begin
  valRac := '1';
  ClickOK := InputQuery('Générer équa de degré ' + edDegre.text +
    ' à racine unique'
    , 'Entrer une racine : Format a+i*b si complexe', valRac);
  if not ClickOK then
    EXIT;
  NettSaisieGC(valRac);
  if valRac = '' then
    EXIT;
  if ChampsResultatsExistent then
    LibererChampsResultats;
  val(edDegre.text, Deg, code);
  coRu := StrToGC(valRac);
  ied := -1;
  coSigne := GC1;
  for p := Deg downto 0 do
  begin
    scoeff := GrToStrE(CombinaisonsGR(int64ToGR(Deg), int64ToGR(p)));
    coCoef := StrToGC(scoeff);
    coCoef := MulGC(coSigne, coCoef);
    coDegMoinsP := Deg - p;
    coPuiss := PowerIntGC(coRu, coDegMoinsP);
    coCoef := MulGC(coCoef, coPuiss);
    coSigne.a := ChangeSigneGR(coSigne.a);
    idEditSuivant(ied).text := GCToStrE(coCoef);
  end;
  bResoudre.enabled := True;
  bVoirCourbe.enabled := False;
  bVoirPlus.enabled := False;

  Equa.init(Deg);
  fru := Equa.FdeXiniGC(coRu);
  labMis.caption := '';
end; //TfrmEquas6.GenEquaARacineUniqueClick

procedure TfrmEquas7.GenEquaRacineSupplClick(Sender: TObject);
var
  CoeffS: tStringlist;
  valRac: string;
  ClickOK: boolean;
  ZGCRacComp: tGC;
  NewDeg: integer;
begin
  if frmCourbe.Visible then
    frmCourbe.close;
  valRac := '1';
  ClickOK :=
    InputQuery('Générer équa de degré N+1 avec racine distincte suivante'
    , 'Entrer une racine : Format a+i*b si complexe', valRac);
  if not ClickOK then
    EXIT;
  if ChampsResultatsExistent then
    LibererChampsResultats;
  NettSaisieGC(valRac);
  if valRac = '' then
    EXIT;
  ZGCRacComp := StrToGC(valRac);
  CoeffS := Equa.GenEqRacSupplemGC(ZGCRacComp);
  NewDeg := Equa.Degre;
  ChampsSaisie.Liberer;
  ChampsSaisie.Cree(NewDeg);
  ChampsSaisie.Alim(CoeffS);
  edDegre.text := intToStr(NewDeg);
  with bAutreDegre do
  begin
    caption := 'Autre degré';
    hint := 'Changement de degré';
    font.Style := [];
    font.color := clBlack;
  end;
  edDegre.enabled := false;
  Equa.init(NewDeg);
  CoeffS.free;
  bResoudre.enabled := True;
  bVoirCourbe.enabled := False;
  bVoirPlus.enabled := False;
  labMis.caption := '';
end; // TfrmEquas6.GenEquaRacineSupplClick

procedure TfrmEquas7.GenFragRacineConnueClick(Sender: TObject);
var
  CoeffS: tStringlist;
  valRac: string;
  ClickOK: boolean;
  N, code: integer;
  ZGCRacComp: tGC;
begin
  valRac := '';
  ClickOK := InputQuery('Générer équa de degré N-1 connaissant racine du degré N'
    , 'Entrer une racine : Format a+i*b si complexe', valRac);
  if not ClickOK then
    EXIT;
  NettSaisieGC(valRac);
  if valRac = '' then
    EXIT;
  if ChampsResultatsExistent then
    LibererChampsResultats;
  ZGCRacComp := StrToGC(valRac);
  val(edDegre.text, N, code);
  CoeffS := Equa.GenEqFragRacConnueGC(ZGCRacComp);
  ChampsSaisie.Liberer;
  ChampsSaisie.Cree(N - 1);
  ChampsSaisie.Alim(CoeffS);
  edDegre.text := intToStr(N - 1);
  with bAutreDegre do
  begin
    caption := 'Autre degré';
    hint := 'Changement de degré';
    font.Style := [];
    font.color := clBlack;
  end;
  edDegre.enabled := false;
  CoeffS.free;
  bResoudre.enabled := True;
  bVoirCourbe.enabled := False;
  bVoirPlus.enabled := False;
  labMis.caption := '';
end; // TfrmEquas6.GenFragRacineConnueClick

procedure TfrmEquas7.edFdeXDblClick(Sender: TObject);
var
  sX, x, sF: string;
  ed: tEdit;
  po: integer;
  zX: tGC;
begin
  if not ChampsResultatsExistent then
  begin
    AFlotte('Initialiser d''abord l''équation en la résolvant', 15, clYellow);
    EXIT;
  end;
  ed := (Sender as tEdit);
  sX := ed.text;
  if ed.name = 'edFdeX' then
  begin
    NettSaisieGC(sX);
    ed.text := sX;
    zX := StrToGC(sX);
    sF := GCToStrNS15(Equa.FdeXiniGC(zX));
    sF := ' f(' + sX + ') = ' + sF;
    AFlotte(sF, 30, clYellow);
  end
  else
  begin
    po := pos('=', sX);
    x := copy(sx, 1, po - 2);
    Delete(sX, 1, po);
    NettSaisieGC(sX);
    zX := StrToGC(sX);
    sF := GCToStrNS15(Equa.FdeXiniGC(zX));
    sF := 'f(' + x + ') : -> f(' + GCToStrNS15(zX) + ') = ' + sF;
    AFlotte(sF, 30, clYellow);
  end;
end;

procedure TfrmEquas7.edDegreKeyPress(Sender: TObject; var Key: Char);
begin
  FiltreNumeriqueEntier(Sender, Key);
end;

procedure TfrmEquas7.edDegreKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
    bAutreDegreClick(Sender);
end;

procedure TfrmEquas7.edDegreChange(Sender: TObject);
var
  deg: integer;
begin
  cacheFlotte2(frmEquas7, nil);
  if edDegre.text = '' then
  begin
    AFlotte('Entrer un Degré d''au moins 2', 30, clYellow);
    edDegre.SetFocus;
    EXIT;
  end;
  deg := StrToInt(edDegre.text);
  if deg < 2 then
  begin
    AFlotte('Entrer un Degré d''au moins 2', 30, clYellow);
    edDegre.SetFocus;
    EXIT;
  end;
  if deg < 2 then
  begin
    edDegre.text := '2';
  end;
  cacheFlotte1;
  with bAutreDegre do
  begin
    caption := 'Valider';
    font.Style := [fsBold];
    font.color := clYellow;
    hint := 'Valider nouveau degré : Régénère les champs de saisie';
    enabled := true;
  end;
  if edDegre.enabled then
    edDegre.setFocus;
end;

procedure TfrmEquas7.bAutreDegreClick(Sender: TObject);
var
  code, iDegre: integer;
begin
  cacheFlotte1;
  if frmCourbe.Visible then
    frmCourbe.Hide;
  if ChampsSaisie.Degre <> 0 then
  begin
    ChampsSaisie.Liberer;
    edDegre.enabled := true;
    if ChampsResultatsExistent then
      LibererChampsResultats;
    bAutreDegre.enabled := false;
    bVoirCourbe.enabled := false;
    bImprimer3.enabled := false;
    bGenerer.enabled := false;
    bVoirPlus.enabled := false;
    bResoudre.enabled := false;
    edDegre.SetFocus;
  end
  else
  begin
    val(edDegre.text, iDegre, code);
    if code <> 0 then
      EXIT;
    ChampsSaisie.Cree(iDegre);
    with bAutreDegre do
    begin
      caption := 'Autre degré';
      hint := 'Changement de degré';
      font.Style := [];
      font.color := clBlack;
    end;
    bGenerer.enabled := true;
    edDegre.enabled := false;
    (components[ChampsSaisie.iChamp0] as tEdit).SetFocus;
  end;
  labMis.caption := '';
end;

procedure TfrmEquas7.bCalculetteClick(Sender: TObject);
begin
  frmCalcGR.show;
  cacheFlotte2(frmCalcGR, frmCalcGR.Affiche);
end;

procedure TfrmEquas7.bVoirCourbeClick(Sender: TObject);
var
  FF: tFonc;
  slCoefs: tStringList;
  i: Integer;
begin
  cacheFlotte1;
  slCoefs := tStringList.create;
  with frmEquas7 do
  begin
    for i := 0 to ComponentCount - 1 do
      if (components[i] is tEdit)
        and ((components[i] as tEdit).tag = -3) then
        slCoefs.add((components[i] as tEdit).text);
  end;
  FF := Equa.FdeXiniGC;
  Courbe.init(FF, Equa.slRacA, slCoefs, frmCourbe.imgF.width,
    frmCourbe.imgF.height);
  slCoefs.free;
  frmCourbe.show;
end;

procedure TfrmEquas7.edPrecisionKeyPress(Sender: TObject; var Key: Char);
begin
  FiltreNumeriqueReel(Sender, Key);
end;

procedure TfrmEquas7.edPrecisionChange(Sender: TObject);
var
  s: string;
  ev, evlim: Extended;
begin
  cacheFlotte2(frmEquas7, nil);
  s := edPrecision.text;
  if (s[length(s)] = 'E') or (s[length(s)] = '-') then
    EXIT;
  if edPrecision.text = '' then
  begin
    AFlotte('Entrer une valeur comprise entre 0 et 1 : Ex : 1E-8', 30,
      clYellow);
    edPrecision.SetFocus;
    EXIT;
  end;
  ev := StrToFloat(s);
  Equa.gev := StrToGR(s);
  if (ev <= 0) or (ev >= 1) then
  begin
    AFlotte('Entrer une valeur comprise entre 0 et 1 : Ex : 1E-18', 30,
      clYellow);
    edPrecision.setFocus;
    EXIT;
  end;
  evlim := Power(10, -nbCsGr);
  if (ev < evlim) then
  begin
    edPrecision.text := FloatToStr(evlim);
    LRFlotte('Inutile de dépasser 1E-NC soit ' + FloatToStr(evlim) + cls
      + 'n''agit de toutes façons que sur les couleurs' + cls
      + 'd''affichage des résultats', 30, clBeige, clYellow);
    EXIT;
  end;
  if (ev <= 0) or (ev >= 1) then
  begin
    ev := 1E-15;
    Equa.gev := StrToGR('1E-15');
  end;
  edMargeAff.text := '-' + intToStr(round(log10(1 / ev)));
  if ChampsResultatsExistent then
    LibererChampsResultats;
end;

procedure TfrmEquas7.FormDblClick(Sender: TObject);
begin
  CacherVoirChampsResultats;
end;

procedure TfrmEquas7.popGenererPopup(Sender: TObject);
begin
  GenEquaRacineSuppl.enabled := not Equa.ChampsDeSaisieNeufs;
  GenFragRacineConnue.enabled := not Equa.ChampsDeSaisieNeufs;
end;

procedure TfrmEquas7.FormShow(Sender: TObject);
var
  s: string;
begin
  plProgress.width := edFdeX.width;
  (components[ChampsSaisie.iChamp0] as tEdit).SetFocus;
  s := '<- Pour résoudre une équation : ' + cls
    + '- Remplacer les coefficients a0 à an par des valeurs' + cls
    + '  ( format a + i*b si coefficient complexe )' + cls
    + '- Ou bien, générer les coefficients de l''équation ayant' + cls
    + '  comme racine une racine unique de degré N.' + cls
    + '- Puis bouton Résoudre.';
  if Equa.ChampsDeSaisieNeufs then
    LRFlotte(s, 60, clBeige, clWhite);
end;

// Impression :

var
  psuite: tPoint;

procedure TfrmEquas7.ImprEquation3Click(Sender: TObject);
var
  menuIt: tMenuItem;

  procedure ImprFonction;
  var
    i, poi, Deg: integer;
    s, sa, sb: shortString;
    cmpa, cmpb: shortInt;
  begin
    Deg := Equa.Degre;
    for i := 1 to Deg + 1 do
    begin
      s := GCToStrE(Equa.cAAiGC[i]);
      s := trim(s);
      poi := pos('i', s);
      if (poi > 0) and (s <> '-i') and (s <> '+i') then
      begin
        cmpa := CompAlgGR(Equa.cAAiGC[i].a, GR0);
        cmpb := CompAlgGR(Equa.cAAiGC[i].b, GR0);
        sa := GRToStrE(Equa.cAAiGC[i].a);
        sb := GRToStrE(Equa.cAAiGC[i].b);
        if (cmpa < 0) and (cmpb < 0) then
        begin
          Delete(sa, 1, 1);
          Delete(sb, 1, 1);
          s := '-(' + sa + ' + i*' + sb + ')';
        end
        else
          s := '(' + s + ')';
      end;
      if (i < Deg + 1) and (s = '1') then
        s := '+';
      if (i < Deg + 1) and (s = '-1') then
        s := '-';
      if (s[1] <> '-') and (s[1] <> '+') then
        s := '+' + s;
      if i < Deg + 1 then
        s := s + '.x';
      if s[2] = '.' then
        Delete(s, 2, 1);
      insert(' ', s, 2);
      if (i = 1) and (pos('+ x', s) = 1) then
        Delete(s, 1, 2);
      if i = Deg + 1 then
        s := ' ' + s + ' = 0';
      if s <> '+ 0.x' then
        psuite := ImprMM(psuite, s, poNormal);
      if (i < Deg) and (s <> '+ 0.x') then // exposant
      begin
        s := intToStr(Deg - i + 1) + ' ';
        psuite := ImprMM(psuite, s, poExposant);
      end;
    end;
  end; // ImprFonction

begin
  menuIt := (Sender as tMenuItem);
  if menuIt = ImprEquation3 then
  begin
    Beg_Doc;
    psuite.x := xmg; // Dixièmes de mm
    psuite.y := -ymh; // ymh est <0
  end;
  PolImpr('Arial', [fsBold], 8);
  psuite := ImprMM(psuite, 'Racines de f(x) = ', poNormal);
  PolImpr('Arial', [], 8);
  ImprFonction;
  if menuIt = ImprEquation3 then
    End_Doc;
end;

procedure TfrmEquas7.ImprRacines3Click(Sender: TObject);
var
  i: integer;
  menuIt: tMenuItem;
begin
  menuIt := (Sender as tMenuItem);
  if menuIt = ImprRacines3 then
  begin
    Beg_Doc;
    psuite.x := xmg; // Dixièmes de mm
    psuite.y := -ymh; // ymh est <0
  end;
  if menuIt = ImprRacines3 then
  begin
    PolImpr('Arial', [fsBold], 8);
    psuite := ImprMM(psuite, 'Racines : ', poNormal);
    psuite := SauteLignes(psuite, 1);
  end;
  PolImpr('Arial', [], 8);
  for i := 0 to Equa.slRacA.count - 1 do
  begin
    psuite := SauteLignes(psuite, 1);
    psuite.x := (MargeG * 10) + 100;
    psuite := ImprMM(psuite, Equa.slRacA[i], poNormal);
  end;
  if menuIt = ImprRacines3 then
    End_Doc;
end;

procedure TfrmEquas7.ImprLesdeux3Click(Sender: TObject);
begin
  Beg_Doc;
  psuite.x := xmg; // Dixièmes de mm
  psuite.y := -ymh; // ymh est <0
  ImprEquation3Click(Sender);
  psuite := SauteLignes(psuite, 1);
  ImprRacines3Click(Sender);
  End_Doc;
end;

procedure TfrmEquas7.bImprimer3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Sender := ImprLesdeux3;
  if Button = mbLeft then
    ImprLesdeux3Click(Sender);
end;

procedure TfrmEquas7.Modifiermargesdimpression1Click(Sender: TObject);
begin
  frmMarges.showModal;
end;

procedure TfrmEquas7.bAideClick(Sender: TObject);
begin
  cacheFlotte1;
  ShellExecute(0, 'OPEN', PChar(RepAppli + 'Aide_Equas_Calc8.chm'), nil, nil,
    SW_SHOW);
end;

procedure TfrmEquas7.labEquaClick(Sender: TObject);
begin
  LRFlotte(Memoire, 25, clBeige, clWhite);
end;

function CoeffsIncorrects(var info: string): boolean;
var
  i, j: integer;
  v: string;
begin
  j := 0;
  Result := False;
  with frmEquas7 do
  begin
    for i := 0 to ComponentCount - 1 do
      if (components[i] is tMonEdit)
        and (((components[i] as tMonEdit).tag = -2) or
        ((components[i] as tMonEdit).tag = -3)) then
      begin
        inc(j);
        v := (components[i] as tMonEdit).text;
        if pos('a', v) > 0 then
        begin
          info := 'Coefficient(s) non numériques(s) : incorrect.';
          Result := True;
          EXIT;
        end;
        if (v = '') or (v = '0') then
        begin
          (components[i] as tMonEdit).text := '0';
          if j = 1 then
          begin
            info := 'Le  premier  coefficient  de l''équation' + cls
              + 'doit obligatoirement être différent de 0.';
            Result := True;
            EXIT;
          end;
        end;
        // Nettoyage des saisies
        NettSaisieGC(v);
        (components[i] as tMonEdit).text := v;
      end;
  end;
end;

procedure TfrmEquas7.bResoudreClick(Sender: TObject);
var
  Degre, code: integer;
  Chrono: oChrono;
  s: string;
begin // Initialisation
  clipboard.clear;
  CacheFlotte2(frmEquas7, edFdeX);
  if CoeffsIncorrects(s) then
  begin
    sms(s);
    EXIT;
  end;
  if edDegre.text = '1' then
  begin
    AFlotte('Réservé aux équas de Degré >= 2', 30, clYellow);
    bAutreDegre.enabled := True;
    EXIT;
  end;
  RazTrace;
  Chrono.Top;
  labMis.caption := '';
  labMis.Update;
  val(edDegre.text, Degre, code);
  if not Equa.Init(Degre) then
    EXIT
  else
    Equa.ChampsDeSaisieNeufs := false;
  Sablier;
  if ChampsResultatsExistent then
    LibererChampsResultats;
  if Equa.ResoudreAvecLagGC then
  begin
    Equa.AfficherResultatGC;
    bVoirCourbe.enabled := true;
    bImprimer3.enabled := true;
    bVoirPlus.enabled := true;
  end
  else
  begin
    if Equa.DeriveesNullesLag then
    begin
      s := 'Cas particulier : ' + cls;
      s := s + 'Dérivées première et seconde simultanément nulles' + cLS;
      s := s + 'Méthode de Laguerre mise en échec.(Division par zéro)' + cLS +
        cLS;
      s := s + 'Parade : Ré-essayer en générant une équa de degré N+1' + cLS;
      s := s + 'admettant une racine-joker de valeur entière par exemple' + cLS;
      s := s +
        '(si une racine positive ne donne rien tester avec une racine négative)';
      LRFlotte(s, 30, clBeige, clYellow);
      bVoirPlus.enabled := true;
    end
    else
      AFlotte('Y a eu un pb', 30, clYellow);
  end;
  Sablier;
  labMis.caption := 'Mis ' + Chrono.Mis;
end; // Résoudre

procedure TfrmEquas7.labProgressDblClick(Sender: TObject);
begin
  plProgress.visible := not plProgress.visible;
end;

procedure TfrmEquas7.bVoirPlusClick(Sender: TObject);
begin
  cacheFlotte1;
  frmTrace.show;
end;

procedure TfrmEquas7.edNCKeyPress(Sender: TObject; var Key: Char);
begin
  FiltreNumeriqueEntier(Sender, Key);
end;

procedure TfrmEquas7.edNCChange(Sender: TObject);
begin
  if ChampsResultatsExistent then
    LibererChampsResultats;
  if edNC.text = '' then
  begin
    AFlotte('NC mini = 20', 30, clYellow);
    edNC.SetFocus;
    nbCsGr := 20;
    Exit;
  end;
  nbCsGr := StrToInt(edNC.text);
  if nbCsGr < 20 then
  begin
    AFlotte('NC mini = 20', 30, clYellow);
    edNC.SetFocus;
    nbCsGr := 20;
    Exit;
  end;
  if nbCsGr >= 20 then
    CacheFlotte1;
  frmTrace.edNAT.text := edNC.Text;
  ActuLgConstantes; //< actualisation des autres paramètres en fonction de nbCsGr
end;

procedure TfrmEquas7.FormActivate(Sender: TObject);
begin
  edNC.text := IntToStr(nbCsGr);
    // Actualisation pour cas où NC affiché a été modifié via une autre fiche
end;

procedure TfrmEquas7.edNAKeyPress(Sender: TObject; var Key: Char);
begin
  FiltreNumeriqueEntier(Sender, Key);
end;

procedure TfrmEquas7.edNAChange(Sender: TObject);
begin
  if ChampsResultatsExistent then
    LibererChampsResultats;
  if edNA.text = '' then
  begin
    AFlotte('NA mini = 4', 30, clYellow);
    NA := 4;
    edNA.SetFocus;
    Exit;
  end;
  NA := StrToInt(edNA.text);
  if NA < 4 then
  begin
    AFlotte('NA mini = 4', 30, clYellow);
    NA := 4;
    edNA.SetFocus;
    Exit;
  end;
  if NA > nbCsGr then
  begin
    AFlotte('NA maxi = NC = ' + intToStr(nbCsGr), 30, clYellow);
    NA := nbCsGR;
    edNA.SetFocus;
    Exit;
  end;
  if (NA >= 4) and (NA <= nbCsGr) then
    CacheFlotte1;
end;

procedure TfrmEquas7.btnAProposClick(Sender: TObject);
begin
  cacheFlotte1;
  frmAPropos.Show;
end;

procedure TfrmEquas7.bGenererMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  p: tPoint;
begin
  p.x := bGenerer.Left + X;
  p.y := bGenerer.Top + Y;
  p := clientToScreen(p);
  popGenerer.Popup(p.x, p.y);
  cacheFlotte1;
end;

procedure TfrmEquas7.cbAffichageClick(Sender: TObject);
begin
  if ChampsResultatsExistent then
    LibererChampsResultats;
end;

procedure TfrmEquas7.edMargeAffChange(Sender: TObject);
begin
  if ChampsResultatsExistent then
    LibererChampsResultats;
end;

initialization

  ancDecimalSepartor := DecimalSeparator;
  if ancDecimalSepartor = ',' then
    DecimalSeparator := '.';
  Equa.gev := StrToGR(FloatToStr(1E-8));
  NA := 22;
  ChampsResultatsExistent := false;

end. // ========================================================================

