unit UnitGR;

interface //*********************************************************
//   Pour calculs avec Grands Réels à nombre de chiffres  *
//            significatifs supérieur à 20                *
//            Code : EXPERIMENTAL                         *
//*********************************************************

uses Windows, Dialogs, Controls, SysUtils, math, Forms, Graphics,
  clipbrd, NewGCent, uFun2, uConstPrecalculees, uFlotte2, buttons;

type
  tGR = record
    Signe: ShortString;
    Sv: GCent;
      // chaîne numérique représentée en base 100 expurgée des puissances de 10
    Expo: Int64;
      // Expo correspond aux puissances de 10 mais renseigne aussi sur la position du DecimalSeparator
    // dans la représentation décimale après conversion du nombre :
    // - si Expo < 0 alors Expo = Décalage du Séparateur Décimal par rapport à la fin de la chaîne Sv
    // - si Expo = 0 alors Sv = valeur entière
    // - si Expo > 0 alors Sv = valeur entière et Expo équivaut au nombre de '0' à ajouter en fin de Sv
    //   dans une représentation intégrale du nombre (représentation au format non scientifique)
  end;

var
  GR0, GR1, GR_1, GR2, GR3, GR4, GR5, GR6, GR8, GR9, GR10, GR11, GR16, GR30,
    GR45, GR60, GR90,
    GR120, GR135, GR150, GR180, GR200, GR210, GR225, GR240, GR270, GR300, GR315,
      GR330, GR360: tGR;
  GRPlusInfini, GRMoinsInfini, GREpsilon,
    GRPi, GRPiSur2, GRPiSur3, GRPiSur4, GR3PiSur4, GR2Pi,
    GRRacCarreeDe2Sur2, GRLn10: tGR;
  //<- variables utilisées en tant que constantes 0, 1, -1, 2, ... Pi, Ln(10) etc
  //   initialisées dans la partie initialization

var
  nbCsGr: int64; //<- nombre de Chiffres significatifs souhaités lors des
  //   calculs. Ce nombre correspond à celui de la représentation décimale d'une valeur (hors Exposant)
  //   D'où : - Nombre de décimales = nbCsGr - 1
  //          - Epsilon = 10^(-nbCsGr) = 10^(-NC) où NC = valeur affichée en interfaces
  //   nbCsGr correspond à la valeur de NC choisie par l'utilisateur.

var
  nbDecimalesGr: int64; //<- Nombre de décimales

var
  nbToursGR: Int64; // nombre de tours de boucle (pour tests)

  // Routines de nettoyage des chaînes saisies en interface :
procedure NettSaisieGR(var s: string);
procedure TrimD0(var s: string; var nz: int64);
procedure TrimG0(var s: string);

// Routines de conversion :
function StrToGR(Saisie: string): tGR;
function GrToStr(Nb: tGR): string;
  //<- Réservé aux nombres entiers (pour Factorielle par exemple,
  //si on veut voir la floppée de zéros terminaux)
function GrToStrE(Nb: tGR): string;
  //<- Pour tous nombres : notation scientifique
function GrToStrECut(Nb: tGR; LCut: longInt): string;
  //<- Pour tous nombres : notation scientifique, affichage tronqué à LCut

function Int64ToGR(Nb: Int64): tGR;
function GRToInt64(G: tGR): Int64;
function GRToExtended(G: tGR): Extended;
function ExtendedToGR(Ext: Extended): tGR;

function AbsGR(const Nb: tGR): tGR; // renvoie valeur absolue de Nb
function ChangeSigneGR(const Nb: tGR): tGR;

function TruncGR(const Nb: tGR): tGR;

function TruncRoundGR(V: tGR; poDecimale: longword): tGR;
function RoundGR(V: tGR): tGR; // équivalent à round
function RoundSurAvDernDecimale(V: tGR): tGR;

// Routines de test :

function GRNul(G: tGR): boolean;
//        renvoie True si G = 0

function AbsGREgaux(G1, G2: tGR): boolean;
//        Renvoie True si Abs(G1) = Abs(G2)

function AbsGRInfAEpsilon(G: tGR): boolean;
//        Compare la valeur Absolue de G à celle de GREpsilon

function CompAbsGR(G1, G2: tGR): shortInt;
//        CompAbsGR : Compare la valeur Absolue de G1 à celle de G2

function CompAlgGR(G1, G2: tGR): shortInt;
//        CompAlgGR : Compare la valeur Algébrique de G1 à celle de G2

type
  TPairImpairFract = (Pair, Impair, Fractionnaire);
function GRPair(G: tGR): TPairImpairFract;

// Routines agissant directement sur les exposants :
function GRMulN10(G: tGR; N: Int64): tGR;
//        GRMulN10 : Renvoie un GR Multiplié par 10^N que N soit positif ou négatif

function GRMulN100(G: tGR; N: Int64): tGR;
//        GRMulN100 : Renvoie un GR multiplié N fois par 100 que N soit positif ou négatif

// Routines de calcul appelant les GCent directement ou indirectement :

function AddGR(G1, G2: tGR): tGR;
function DifGR(G1, G2: tGR): tGR;
function DivGR(G1, G2: tGR): tGR;
procedure DivModGR(G1, G2: tGR; var Q, R: tGR);
  // G1 : réel, G2 : entier : Renvoie Q entier
function MulGR(G1, G2: tGR): tGR;
function CarreGR(G: tGR): tGR;
function SqrtGR(G: tGR): tGR;
function RandomGR(NbDigits: longword; const Impair: boolean): tGR;
//<--     Appeler Randomize avant RandomGR

function IncGR(G: tGR): tGR;
function DecGR(G: tGR): tGR;
function DemiGR(G: tGR): tGR;
function DoubleGR(G: tGR): tGR;

function FactorielleGR(G: tGR): tGR;
function CombinaisonsGR(n, p: tGR): tGR;
function ArrangementsGR(const n, p: tGR): tGR;

function PuissanceGR(G: tGR; Exp: Int64): tGR;
function ExponentielleGR(X: tGR): tGR;

function LogNep10GR: tGR; //<- Renvoie Ln(10) : A utiliser uniquement
// pour reconstituer le cas échéant la constante sLn10 de l'unit uConstPrecalculees vu la lenteur
// (Pour nbCSGR = 400 -> nbTours = 2268 : mis 32734 ms avec Pentium III à 1,13 GHz)

function LogNep2GR: tGR;
  // Renvoie Ln(2) : (Pour nbCSGR = 400 -> nbTours = 416 : mis 5969 ms)
function LogNep5GR: tGR;
  // Renvoie Ln(5) : (Pour nbCSGR = 400 -> nbTours = 1123 : mis 16125 ms)

function LogNepGR(const X: tGR): tGR; //<- Renvoie Log Népérien de X pour X > 0
// <-     Accéléré par l'utilisation de Ln(10) précalculé

function LogBase10GR(X: tGR): tGR; //<- Renvoie Log décimal de X pour X > 0

function FracGR(X: tGR): tGR;
  //<- FracGr(123.456) = 0.456 et FracGR(-123.456) = -0.456
procedure TruncFractGR(X: tGR; var Trun, Fra: tGR);
function PowerGR(const Base, Expo: tGR): tGR;
  //<- Renvoie Base^Expo si Base > 0 et Expo = qcq
function DixPuissXGR(const Expo: tGR): tGR;
  //<- Renvoie 10^X avec X réel ou entier

function RacNiemeGR(const Base, Expo: tGR): tGR;
  //<- Renvoie Racine Expo-ième de Base avec Expo positif
// ou négatif même fractionnaire si Base > 0 de même que si Base < 0 et que Expo est impair

// Routines pour les constantes :
procedure ActuLgConstantes; // Actualise la longueur des constantes Pi etc
// en fonction du nombre de chiffes significatifs à partir des constantes
// précalculées de l'unit uPrecalcule

function cPi: tGR;
  // Renvoie Pi = 3.1415926 ... via algo de Plouffe : FAIRE GAFFE : HYPER-LENT

// TRIGONOMETRIE ---------------------------------------------------------------

function RadToDegGR(Rad: tGR): tGR; // Conversion Radians -> Degrés
function DegToRadGR(Deg: tGR): tGR; // Conversion Degrés  -> Radians

function ArcTangente2(const Y, X: Extended): Extended; // Maquette Delphi retenue
function ArcTan2DLGR(const Y, X: tGR): tGR;
  // renvoie ArcTangente(Y/X) en Radians
function ArcTangenteDLGR(Tan: tGR): tGR; // renvoie ArcTangente(Tan) en Radians

function ArcSinusGR(X: tGR): tGR; // renvoie ArcSinus(X) en Radians
function ArcCosinusGR(X: tGR): tGR; // renvoie ArcCosinus(X) en Radians

function SinusDLGR(const ADeg: tGR): tGR; // renvoie Sinus(Degrés)
function CosinusDLGR(const ADeg: tGR): tGR; // renvoie Cosinus(Degrés)
function TangenteDLGR(const xDeg: tGR): tGR; // renvoie Tangente(Degrés)
procedure SinCosDLGR(const ADeg: tGR; var Sinu, Cosi: tGR);
// <-- renvoie simultanément Sinus et Cosinus pour ADeg en Degrés
// plus rapide que 3 appels à SinusDLGR puis Cos, puis Tan

procedure SinCosGR(Y, X: tGR; var Sinu, Cosi: tGR);
// <--    Renvoie Sinus et Cosinus de l'angle dont Tangente = Y/X
procedure SinCosMiAngleGR(Y, X: tGR; var Sinu, Cosi: tGR);
// <--    Renvoie Sinus(a) et Cosinus(a) à partir de Y/X = Tangente(2a)

// Hyperboliques et réciproques :

function ChxGR(const X: tGR): tGR; // Cosinus hyperbolique qq soit x
function ShxGR(const X: tGR): tGR; // Sinus hyperbolique qq soit x
function ThxGR(const X: tGR): tGR; // Tangente hyperbolique qq soit x

function ArgChGR(const X: tGR): tGR; // Argument Sinus hyperbolique
function ArgShGR(const X: tGR): tGR; // Argument Cosinus hyperbolique
function ArgThGR(const X: tGR): tGR; // Argument Tangente hyperbolique

implementation

procedure SMS(s: string);
begin
  clipboard.AsText := s;
  Showmessage(s);
end;

function Echapper: boolean; // Pour interrompre une boucle avec touche Echapp
begin
  if getAsyncKeyState(VK_ESCAPE) <> 0 then
    Result := true
  else
    Result := false;
end;

// Routines de nettoyage des chaînes saisies :

procedure TrimD0(var S: string; var nz: int64);
//        suppression des 0 à droite de S et nz renvoie le nombre de 0 supprimés
//        si S est une série de 0 alors S renvoyée = '0' et nz = 0
var
  lg: integer;
begin
  lg := length(s);
  while (lg > 0) and (s[lg] = '0') do
    dec(lg);
  if lg > 0 then
  begin
    nz := length(s) - lg;
    s := copy(s, 1, lg);
  end
  else
  begin
    nz := 0;
    s := '0';
  end;
end;

procedure TrimG0(var s: string);
  // suppression des 0 superflus à gauche de s : renvoie au min un '0'
var
  i, lg: Integer;
begin
  lg := Length(s);
  i := 1;
  while (i < lg) and (s[i] = '0') do
    Inc(i);
  s := Copy(s, i, maxInt);
end;

procedure NettSaisieGR(var s: string);
//        Supprime les caractères autres que [0..9] + DecimalSeparator + E et convertit 'e' en E
//        Renvoie au mininimum un '0'
var
  i: integer;
  po: integer;
begin
  if s = '' then
  begin
    s := '0';
    EXIT;
  end;
  // Elimination caractères indésirables
  i := length(s);
  repeat if not (s[i] in [DecimalSeparator, '0'..'9', '-', 'E', 'e']) then
      Delete(s, i, 1);
    dec(i);
  until (i = 0);
  // Suppression de e ou E au début :
  while (length(s) > 0) and (s[1] = 'E') do
    Delete(s, 1, 1);
  while (length(s) > 0) and (s[1] = 'e') do
    Delete(s, 1, 1);
  // Elimination répétitions accidentelles d'appuis de touches :
  po := pos('--', s);
  while po > 0 do
  begin
    Delete(s, po, 1);
    po := pos('--', s);
  end;
  po := pos('++', s);
  while po > 0 do
  begin
    Delete(s, po, 1);
    po := pos('++', s);
  end;
  // Répétitions du DecimalSeparator ou Seperator incorrect
  i := 1;
  while i <= length(s) - 1 do
  begin
    if s[i] = ',' then
      s[i] := '.';
    if (s[i] = '.') and ((s[i + 1] = '.') or (s[i + 1] = ',')) then
      Delete(s, i + 1, 1)
    else
      inc(i);
  end;
  // Répétitions ee ou EE
  po := pos('EE', s);
  while po > 0 do
  begin
    Delete(s, po, 1);
    po := pos('EE', s);
  end;
  po := pos('ee', s);
  while po > 0 do
  begin
    Delete(s, po, 1);
    po := pos('ee', s);
  end;
  // Conversion e -> E :
  po := pos('e', s);
  if po > 0 then
    s[po] := 'E';
  // Suppression d'un 1er signe s'il est suivi d'un 2ième contradictoire
  i := 1;
  while i <= length(s) - 1 do
  begin
    if ((s[i] = '+') and (s[i + 1] = '-'))
      or ((s[i] = '-') and (s[i + 1] = '+')) then
      Delete(s, i, 1)
    else
      inc(i);
  end;
  // Suppression d'un signe accollé devant E
  i := 1;
  while i <= length(s) - 1 do
  begin
    if ((s[i] = '+') or (s[i] = '-')) and (s[i + 1] = 'E') then
      Delete(s, i, 1)
    else
      inc(i);
  end;
  // Elimination de caractères indésirables en fin de s
  while (s <> '') and (s[length(s)] in (['+', '-', '.', ',', 'E'])) do
    Delete(s, length(s), 1);
  if (s = '') then
    s := '0';
end;

// Routines de conversion :

function StrToGR(Saisie: string): tGR;
//       Formats de saisie possibles
//       a : -12300e2500 -> transformé en -123E2502
//       b : 0.002500E45 -> +25E41
//       c : 008000      -> +8E3
//       d : -0025.12000 -> -25.12E0
var
  s, sE: string;
  poDS, poE, nz, lg: int64;
begin
  try
    s := Saisie;
    // NettSaisieGR(s); <- Nett : fait en amont sauf i,*,+
    s := SupprCharS(s, 'i*+');
    if (s = '0') or (s = '') then
      with Result do
      begin
        Sv := #0;
        Expo := 0;
        signe := '+';
        Exit;
      end;
    // Recup signe :
    Result.Signe := '+';
    if s[1] = '-' then
    begin
      Result.Signe := '-';
      Delete(s, 1, 1);
    end;
    // Récup exposant si déclaré :
    Result.Expo := 0;
    poE := pos('E', s);
    if poE > 0 then
    begin
      sE := copy(s, poE, maxInt);
      Delete(sE, 1, 1);
      Delete(s, poE, maxInt);
      Result.Expo := Result.Expo + StrToInt64(sE);
    end;
    poDS := pos(DecimalSeparator, s);
    TrimD0(s, nz);
    if (poDS = 0) and (nz > 0) then
      Result.Expo := Result.Expo + nz;
    TrimG0(s);
    // Achèvement cas b : 0.002500E45
    lg := length(s);
    poDS := pos(DecimalSeparator, s);

    if poDs > 0 then
    begin
      Result.Expo := Result.Expo - lg + poDS;
      Delete(s, poDS, 1);
      TrimG0(s);
    end;
    // arrivé ici s est une valeur numérique entière positive
    Result.Sv := FStrToGCent(s);
  except
    Result := GR0;
    raise;
  end;
end;

function GrToStr(Nb: tGR): string;
//       Renvoie str-base10 avec le cas échéant la floppée de zéros terminaux
//       si Nb.Expo < 1000 sinon renvoie result avec exposant E
var
  lg0: int64;
  signe: string;
begin
  if Nb.sv = #0 then
  begin
    Result := '0';
    EXIT;
  end;
  if pos('infini', Nb.Signe) > 0 then
  begin
    Result := Nb.Signe;
    Exit;
  end;
  if Nb.signe = '+' then
    signe := ''
  else
    signe := '-';

  if (Nb.Expo >= 1000) or (Nb.Expo <= -1000) then
  begin
    Result := signe + FGCentToStr(Nb.sv) + 'E' + intToStr(Nb.Expo);
    EXIT;
  end;

  Result := signe + FGCentToStr(Nb.sv);
  lg0 := length(Result);
  SetLength(Result, lg0 + Nb.Expo);
  FillMemory(@Result[lg0 + 1], Nb.Expo, Byte('0'));
end;

function GrToStrE(Nb: tGR): string;
var
  s, signe: string;
  expo, aex, nz, lg: Int64;
begin
  if Nb.sv = #0 then
  begin
    Result := '0';
    Exit;
  end;
  if pos('infini', Nb.Signe) > 0 then
  begin
    Result := Nb.Signe;
    Exit;
  end;
  if Nb.signe = '+' then
    signe := ''
  else
    signe := '-';
  s := FGCentToStr(Nb.sv);
  TrimD0(s, nz);
  lg := length(s);
  expo := Nb.Expo + nz;
  if Expo >= 0 then
  begin
    lg := length(s) + Expo;
    if lg <= nbCsGr then
    begin
      Result := signe + s + StringOfChar('0', Expo);
    end
    else
    begin
      if Expo > 0 then
        Result := signe + s + 'E' + IntToStr(Expo)
      else
        Result := signe + s;
    end;
    EXIT;
  end;
  aex := abs(expo);
  if (Expo < 0) and (aex <= lg) then
  begin
    Insert(DecimalSeparator, s, lg - aex + 1);
    if pos(DecimalSeparator, s) = 1 then
      s := '0' + s;
    Result := Signe + s;
  end
  else
  begin
    expo := expo + lg - 1;
    if lg > 1 then
      Insert(DecimalSeparator, s, 2);
    if expo <> 0 then
      Result := Signe + s + 'E' + IntToStr(expo)
    else
      Result := Signe + s;
  end;
end;

function GrToStrECut(Nb: tGR; LCut: longInt): string;
//       string Result = s1 contenant LCut chiffres significatifs
//                      + une substring pour l'exposant
var
  expo, lg: Int64;
  signe, s1: string;
begin
  if Nb.sv = #0 then
  begin
    Result := '0';
    Exit;
  end;
  if pos('infini', Nb.Signe) > 0 then
  begin
    Result := Nb.Signe;
    Exit;
  end;
  if Nb.signe = '+' then
    signe := ''
  else
    signe := '-';
  s1 := FGCentToStr(Nb.sv);
  lg := length(s1);
  expo := lg - 1 + Nb.Expo;
  if LCut >= lg then
  begin
    if lg > 1 then
      Insert(DecimalSeparator, s1, 2);
    if expo <> 0 then
      Result := signe + s1 + 'E' + intToStr(Expo)
    else
      Result := signe + s1;
    EXIT;
  end;
  // lg > LCut :
  s1 := Copy(s1, 1, LCut);
  if lg > 1 then
    Insert(DecimalSeparator, s1, 2);
  if expo <> 0 then
    Result := signe + s1 + 'E' + IntToStr(Expo)
  else
    Result := signe + s1;
end;

procedure TrimD0GCent(var Nv: GCent; var nz: int64);
//        Utilisée pour raccourcir la string du GCent en lui supprimant, le cas échéant,
//        tous les zéros terminaux en vue de les reporter sur l'Exposant d'un tGR
var
  P10: boolean;
begin
  nz := IsDiv10GCent(Nv, P10);
  if nz > 0 then
    Nv := FGCentDivN10(Nv, nz);
end;

function Int64ToGR(Nb: Int64): tGR;
const
  longwordMax = 4294967295;
var
  nz: Int64;
begin
  with Result do
  begin
    if Nb < 0 then
      Signe := '-'
    else
      Signe := '+';
    if abs(Nb) <= longwordMax then
      Sv := FIntToGCent(Abs(Nb))
    else
      Sv := FStrToGCent(IntToStr(Abs(Nb)));
    if Sv <> #0 then
    begin
      TrimD0GCent(Sv, nz);
      Result.Expo := nz;
    end;
  end;
end;

function GRToInt64(G: tGR): Int64;
const
  Int64Max = '9223372036854775807'; // = 2^63–1
var
  s: string;
  GC: GCent;
  code: integer;
begin
  Result := 0;
  try
    if G.Expo < 0 then
      Exit;
    GC := FGCentMulN10(G.Sv, G.Expo);
    s := FGCentToStr(GC);
    if s > Int64Max then
      Exit;
    if G.signe = '+' then
      Val(s, Result, code)
    else if G.signe = '-' then
    begin
      s := '-' + s;
      Val(s, Result, code);
    end;
  except
    raise;
  end;
end;

function GRToExtended(G: tGR): Extended;
begin
  try
    Result := StrToFloat(G.Signe + FGCentToStr(G.Sv) + 'E' + intToStr(G.Expo));
  except
    raise;
  end;
end;

function ExtendedToGR(Ext: Extended): tGR;
var
  s: string;
  lg, poDS, poE: int64;
begin
  Result := GR0;
  try
    s := FloatToStr(Ext);
    poDS := pos(DecimalSeparator, s);
    poE := pos('E', s);
    if poE > 0 then
    begin
      Result.Expo := StrToInt64(copy(s, poE + 1, maxInt));
      s := copy(s, 1, poE - 1);
    end;
    lg := length(s);
    if poDS > 0 then
    begin
      Result.Expo := Result.Expo - (lg - poDS);
      Delete(s, poDS, 1);
    end;
    if s[1] = '-' then
    begin
      Result.Signe := '-';
      Delete(s, 1, 1);
    end;
    TrimG0(s);
    Result.Sv := FStrToGCent(s);
  except
    on EConvertError do
      ShowMessage('Exception dans ExtendedToGR');
  end;
end;

function AbsGR(const Nb: tGR): tGR;
begin
  Result := Nb;
  Result.Signe := '+';
end;

function ChangeSigneGR(const Nb: tGR): tGR;
begin
  Result := Nb;
  if Result.Signe = '+' then
    Result.Signe := '-'
  else
    Result.Signe := '+';
end;

function TruncGR(const Nb: tGR): tGR;
//       Troncature de Sv en fonction de nbCsGr afin d'éviter l'allongement
//       excessif de Sv et des durées d'exécution par calculs portant sur des
//       décimales superflues
const
  FacteurDmax = 2; //<- facteur max de décompactage des GCent
var
  lg, de: int64; //<- un signé pour 'de' négatif et pour expo
begin
  Result := Nb;
  if Nb.Expo = 0 then
    Exit;
  lg := length(Nb.Sv) * FacteurDmax;
  de := lg - nbCsGr;
  if de <= 0 then
    Exit; // lg <= nbCsGr
  // sinon écrétage :
  Result.Sv := FGCentDivN10(Result.Sv, de);
  Result.Expo := Result.Expo + de;
end;

// Routines de tests

function AbsGREgaux(G1, G2: tGR): boolean;
//        Renvoie True si Abs(G1) = Abs(G2)
begin
  Result := (G1.sv = G2.sv) and (G1.Expo = G2.Expo);
end;

function GRNul(G: tGR): boolean;
//        renvoie True si G = 0
begin
  Result := (G.sv = #0) and (G.Expo = 0);
end;

function AbsGRInfAEpsilon(G: tGR): boolean;
//        Renvoie True si la valeur Absolue de G est inférieure à celle de GREpsilon
var
  e1, e2: int64;
begin
  try
    e1 := G.Expo;
    e2 := -nbCsGR - 2 * (length(G.sv) - 1);
    Result := e1 < e2;
  except
    raise;
  end;
end; // AbsGRInfAEpsilon

function CompAbsGR(G1, G2: tGR): shortInt;
//        Compare la valeur Absolue de G1 à celle de G2
var
  C1, C2: GCent;
  e1, e2: int64;
  de: longword;
begin
  e1 := G1.Expo;
  e2 := G2.Expo;
  C1 := G1.Sv;
  C2 := G2.Sv;
  try //if e1=e2 then comparaison sur C1 et C2 inchangés
    if e1 > e2 then
    begin
      de := e1 - e2;
      C1 := FGCentMulN10(G1.sv, de)
    end
    else if e1 < e2 then
    begin
      de := e2 - e1;
      C2 := FGCentMulN10(G2.sv, de)
    end;
    Result := isCompGCent(C1, C2);
  except
    raise;
  end;
end; // CompAbsGR

function CompAlgGR(G1, G2: tGR): shortInt;
//        Result = -1 si G1<G2, = +1 si G1>G2, = 0 si G1 = G2
var
  cmp: shortInt;
begin
  Result := 0;
  // Exit sur cas particuliers :
  if (pos('-', G1.Signe) > 0) and (pos('+', G2.Signe) > 0) then // G1<G2
  begin
    Result := -1;
    Exit;
  end;
  if (pos('+', G1.Signe) > 0) and (pos('-', G2.Signe) > 0) then // G1>G2
  begin
    Result := +1;
    Exit;
  end;
  if (G1.Signe = G2.Signe) and (G1.Sv = G2.Sv) and (G1.Expo = G2.Expo) then
    Exit; // G1=G2

  // ici G1.Signe = G2.Signe
  if (G1.Signe = '+infini')
    or (G2.Signe = '-infini') then
  begin
    Result := +1;
    Exit;
  end;
  if (G1.Signe = '-infini')
    or (G2.Signe = '+infini') then
  begin
    Result := -1;
    Exit;
  end;

  try
    cmp := CompAbsGR(G1, G2);
    if cmp = 0 then
    begin
      Result := 0;
      Exit;
    end;
    if G1.Signe = '+' then
    begin
      if cmp > 0 then
        Result := +1
      else
        Result := -1;
      Exit;
    end;
    if G1.Signe = '-' then
    begin
      if cmp > 0 then
        Result := -1
      else
        Result := +1;
      Exit;
    end;
  except
    raise;
  end;
end; // CompAlgGR

function GRPair(G: tGR): TPairImpairFract;
begin
  Result := Impair;
  if G.Expo > 0 then
    Result := Pair
  else if G.Expo < 0 then
    Result := Fractionnaire
  else if G.Expo = 0 then
    if isGCentPair(G.sv) then
      Result := Pair;
end;

// Routines de calcul appelant les GCent :

function AddGR(G1, G2: tGR): tGR;
var
  C1, C2: GCent;
  tmp: tGR;
  nz: int64;
begin
  Result := GR0;
  if (G1.sv = #0) or (G1.sv = '') then
  begin
    Result := G2;
    Exit;
  end
  else if (G2.sv = #0) or (G2.sv = '') then
  begin
    Result := G1;
    Exit;
  end;

  if ((G1.Signe = '+infini') and (G2.Signe = '-infini'))
    or ((G1.Signe = '-infini') and (G2.Signe = '+infini')) then
  begin
    Result := GR0;
    Exit;
  end;

  if (G1.Signe = '+infini') then
  begin
    Result := GRPlusInfini;
    Exit;
  end;
  if (G1.Signe = '-infini') then
  begin
    Result := GRMoinsInfini;
    Exit;
  end;

  if (G2.Signe = '+infini') then
  begin
    Result := GRPlusInfini;
    Exit;
  end;
  if (G2.Signe = '-infini') then
  begin
    Result := GRMoinsInfini;
    Exit;
  end;

  try // Renvoyer le cas échéant vers DifGR :
    if G1.Signe = '-' then
    begin
      if G2.Signe = '-' then // res = -|v1| + (-|v2|) = -(|v1| + |v2|)
      begin
        Result.Signe := '-';
      end
      else // res = -|v1| + |v2| = v2 -|v1|
      begin
        tmp := AbsGR(G1);
        Result := DifGR(G2, tmp);
        EXIT;
      end;
    end
    else if G1.Signe = '+' then
    begin
      if G2.Signe = '-' then //res = v1 + (-|v2|) = v1 - |v2|
      begin
        tmp := AbsGR(G2);
        Result := DifGR(G1, tmp);
        EXIT;
      end
      else
      begin
        Result.Signe := '+';
      end; // v1 et v2 Positifs
    end;

    // Calculs :
    // Inutile d'ajouter des epsilon hors intervalle
    if AbsGRInfAEpsilon(G1) then
    begin
      Result := G2;
      EXIT;
    end;
    if AbsGRInfAEpsilon(G2) then
    begin
      Result := G1;
      EXIT;
    end;
    C1 := G1.sv;
    C2 := G2.sv;
    // Calibrages avant Addition :
    if G1.Expo <> G2.Expo then
    begin
      if G1.Expo < G2.Expo then
      begin
        C2 := FGCentMulN10(C2, G2.Expo - G1.Expo);
        Result.Expo := G1.Expo;
      end
      else if G2.Expo < G1.Expo then
      begin
        C1 := FGCentMulN10(C1, G1.Expo - G2.Expo);
        Result.Expo := G2.Expo;
      end;
    end
    else
      Result.Expo := G1.Expo;

    if isCompGCent(C1, C2) >= 0 then
      Result.Sv := FAddGCent(C1, C2)
    else
      Result.Sv := FAddGCent(C2, C1);

    // Ecrémage des zéros terminaux :
    if Result.Sv <> #0 then
    begin
      TrimD0GCent(Result.Sv, nz);
      Result.Expo := Result.Expo + nz;
    end;
    // Troncature de Sv le cas échéant :
    Result := TruncGR(Result);
  except
    Result := GR0;
    raise;
  end;
end; // AddGr

function DifGR(G1, G2: tGR): tGR;
var
  C1, C2: GCent;
  ChgSigne: boolean;
  tmp: tGR;
  nz: int64;
begin // Exit sur cas particuliers ou renvois vers AddGR :
  Result := GR0;
  if (G2.sv = '') or (G2.sv = #0) then
  begin
    Result := G1;
    EXIT;
  end
  else if (G1.sv = '') or (G1.sv = #0) then // Res:= -G2
  begin
    Result := ChangeSigneGR(G2);
    EXIT;
  end
  else if (G1.sv = G2.sv) and (G1.Expo = G2.Expo) and (G1.Signe = G2.Signe) then
    EXIT; // G1=G2

  if ((G1.Signe = '-infini') and (G2.Signe = '-infini'))
    or ((G1.Signe = '+infini') and (G2.Signe = '+infini')) then
    EXIT;

  if (G1.Signe = '+infini') then
  begin
    Result := GRPlusInfini;
    Exit;
  end;
  if (G1.Signe = '-infini') then
  begin
    Result := GRMoinsInfini;
    Exit;
  end;

  if (G2.Signe = '+infini') then
  begin
    Result := GRMoinsInfini;
    Exit;
  end;
  if (G2.Signe = '-infini') then
  begin
    Result := GRPlusInfini;
    Exit;
  end;

  ChgSigne := false;
  try // Renvoyer le cas échéant vers AddGR :
    if (G1.Signe = '+') and (G2.Signe = '-') then // v1-(-|v2|) = v1+|v2|
    begin
      tmp := AbsGR(G2);
      Result := AddGR(G1, tmp);
      EXIT;
    end
    else if (G1.Signe = '-') and (G2.Signe = '+') then
      //-|v1|-(+v2)= -|v1|-v2 = -(|v1|+v2)
    begin
      tmp := AbsGR(G1);
      Result := AddGR(G2, tmp);
      Result := ChangeSigneGR(Result);
      EXIT;
    end
    else if (G1.Signe = '-') and (G2.Signe = '-') then
      chgSigne := true; //-|v1|-(-|v2|)= -|v1|+|v2| = |v2| - |v1|

    // Calculs :
{$Q+}
    // Inutile de retrancher des epsilon hors intervalle
    if AbsGRInfAEpsilon(G1) then
    begin
      Result := ChangeSigneGR(G2);
      EXIT;
    end;
    if AbsGrInfAEpsilon(G2) then
    begin
      Result := G1;
      EXIT;
    end;
    C1 := G1.Sv;
    C2 := G2.Sv;
    // Calibrages avant Soustraction :
    if G1.Expo < G2.Expo then
    begin
      C2 := FGCentMulN10(C2, G2.Expo - G1.Expo);
      Result.Expo := G1.Expo;
    end
    else if G2.Expo < G1.Expo then
    begin
      C1 := FGCentMulN10(C1, G1.Expo - G2.Expo);
      Result.Expo := G2.Expo;
    end
    else
      Result.Expo := G2.Expo;

    // Inversion éventuelle pour calcul
    if isCompGCent(C1, C2) > 0 then // pas d'inversion
    begin
      Result.Sv := FDifGCent(C1, C2);
      Result.signe := '+';
    end
    else //Inversion
    begin
      Result.Sv := FDifGCent(C2, C1);
      Result.signe := '-';
    end;

    if ChgSigne then
      Result := ChangeSigneGR(Result);

    // Ecrémage des zéros terminaux :
    if Result.Sv <> #0 then
    begin
      TrimD0GCent(Result.Sv, nz);
      Result.Expo := Result.Expo + nz;
    end;
    // Troncature de Sv le cas échéant :
    Result := TruncGR(Result);
  except
    Result := GR0;
    raise;
  end;
end; // DifGR

function DivGR(G1, G2: tGR): tGR;
var
  C1, C2: GCent;
  k1, kd, lg1, lg2: int64;
  R: tGR;
begin // Exit sur cas particuliers :
  Result := GR0;
  if pos('infini', G1.Signe) > 0 then // Div G1=+-Infini/G2 = +-Infini
  begin
    if G1.Signe[1] <> G2.Signe[1] then
      Result := GRMoinsInfini
    else
      Result := GRPlusInfini;
    EXIT;
  end;
  if pos('infini', G2.Signe) > 0 then
    EXIT; // Div G1/+-Infini = 0

  try
    if GRNul(G2) then // G2 = 0
    begin
      ShowMessage('DivGR : Tentative de Division par 0 !');
      if pos('+', G1.Signe) > 0 then
        Result := GRPlusInfini
      else
        Result := GRMoinsInfini;
      EXIT;
    end;
    if GRNul(G1) then
      EXIT; // G1 = 0
    if AbsGREgaux(G2, GR1) then // Div G1 par +/-1
    begin
      Result := G1;
      if G1.Signe <> G2.Signe then
        Result.Signe := '-'
      else
        Result.Signe := '+';
      EXIT;
    end;
    if AbsGREgaux(G1, G2) then // G1 = +/-G2
    begin
      Result := GR1;
      if G1.Signe <> G2.Signe then
        Result.Signe := '-'
      else
        Result.Signe := '+';
      EXIT;
    end;
    // Calculs :
{$Q+}
    if (G1.Signe <> G2.Signe) then
      Result.Signe := '-'
    else
      Result.Signe := '+';

    C1 := G1.sv;
    C2 := G2.Sv;

    // Rattrapage longueur pour obtenir au moins un chiffre :
    k1 := 0;
    while isCompGCent(C1, C2) < 0 do
    begin
      C1 := FGCentMulN10(C1, 1);
      inc(k1);
    end;

    // Rattrapage longueur pour obtenir au moins nbCsGR chiffres significatifs :
    lg1 := length(C1);
    lg2 := length(C2);
    kd := nbCsGR - (lg1 - lg2);
    if kd > 0 then
      C1 := FGCentMulN10(C1, kd)
    else
      kd := 0;

    PDivModGCent(C1, C2, Result.Sv, R.Sv); // <<<< DivMod des GCent
    // Troncature de Sv le cas échéant :
    Result := TruncGR(Result);
    Result.Expo := G1.Expo - G2.Expo - kd - k1;
  except
    Result := GR0;
    raise;
  end;
end; // DivGR

procedure DivModGR(G1, G2: tGR; var Q, R: tGR);
//        G1 : réel, G2 : entier : Renvoie Q entier
var
  C1, C2: GCent;
  e1, e2: longWord;
  M: tGR;
begin // Exit sur cas particuliers :
  Q := GR0;
  R := GR0;
  // G2 doit être un entier :
  if G2.Expo < 0 then
  begin
    Sms('DivModGR2 : G2 doit être un entier');
    EXIT;
  end;

  if pos('infini', G1.Signe) > 0 then // Div G1=+-Infini/G2 = +-Infini
  begin
    if G1.Signe[1] <> G2.Signe[1] then
      Q := GRMoinsInfini
    else
      Q := GRPlusInfini;
    EXIT;
  end;
  if pos('infini', G2.Signe) > 0 then
    EXIT; // Div G1/+-Infini = 0

  try
    if GRNul(G2) then // G2 = 0
    begin
      ShowMessage('DivModGR : Tentative de Division par 0 !');
      if pos('+', G1.Signe) > 0 then
        Q := GRPlusInfini
      else
        Q := GRMoinsInfini;
      EXIT;
    end;
    if GRNul(G1) then
      EXIT; // G1 = 0
    if AbsGREgaux(G2, GR1) then // Div G1 par +/-1
    begin
      Q := G1;
      if G1.Signe <> G2.Signe then
        Q.Signe := '-'
      else
        Q.Signe := '+';
      EXIT;
    end;
    if AbsGREgaux(G1, G2) then // G1 = +/-G2
    begin
      Q := GR1;
      if G1.Signe <> G2.Signe then
        Q.Signe := '-'
      else
        Q.Signe := '+';
      EXIT;
    end;
    if (abs(G1.Expo) > LongwordMax) or (abs(G2.Expo) > LongwordMax) then
    begin
      Sms('DivModGR : réservé pour valeurs <= 4294967295');
      EXIT;
    end;
    // Calculs :
{$Q+}
    if (G1.Signe <> G2.Signe) then
      Q.Signe := '-'
    else
      Q.Signe := '+';

    C1 := G1.sv;
    C2 := G2.Sv;
    e1 := longword(abs(G1.Expo));
    e2 := longword(abs(G2.Expo));
    if G1.Expo > 0 then
      C1 := FGCentMulN10(C1, e1);
    if G1.Expo < 0 then
      C1 := FGCentDivN10(C1, e1);
    if G2.Expo > 0 then
      C2 := FGCentMulN10(C2, e2);
    PDivModGCent(C1, C2, Q.Sv, R.Sv); // < DivMod des GCent
    M.sv := FMultiplie(Q.sv, C2);
    R := DifGR(AbsGR(G1), M);
    if (G1.signe = '-') then
      R.Signe := '-'
    else if (G2.signe = '-') then
      R.Signe := '+';
  except
    Q := GR0;
    R := GR0;
    raise;
  end;
end; // DivModGR

function MulGR(G1, G2: tGR): tGR;
var
  nz: int64;
begin // Exit sur cas particuliers :
  Result := GR0;
  if (G1.sv = #0) or (G2.sv = #0) then
    Exit;
  if G1.Signe = '+infini' then
  begin
    if pos('+', G2.Signe) > 0 then
      Result := GRPlusInfini
    else
      Result := GRMoinsInfini;
    Exit;
  end
  else if G1.Signe = '-infini' then
  begin
    if pos('-', G2.Signe) > 0 then
      Result := GRPlusInfini
    else
      Result := GRMoinsInfini;
    Exit;
  end;
  // Calculs :
{$Q+}
  try
    Result.sv := FMultiplie(G1.sv, G2.sv);
    //écrémage des zéros terminaux produits par Multiplie :
    TrimD0GCent(Result.sv, nz);
    Result.Expo := G1.Expo + G2.Expo;
    Result.Expo := Result.Expo + nz;
    if (G1.Signe <> G2.Signe) then
      Result.Signe := '-'
    else
      Result.Signe := '+';
    // Troncature de Sv le cas échéant :
    Result := TruncGR(Result);
  except
    Result := GR0;
    raise;
  end;
end; //MulGR

function CarreGR(G: tGR): tGR;
begin
  try
    Result := MulGR(G, G);
  except
    Result := GR0;
    raise;
  end;
end;

function SqrtGR(G: tGR): tGR;
//       Racine carrée par algo du goutte à goutte de FRacineGCent
const
  FacteurDmax = 2; //<- facteur max de décompactage des GCent
var
  exp, lg, de: Int64;
  GT: tGR;
begin
  if GRNul(G) or AbsGREgaux(G, GR1) then
  begin
    Result := G;
    Exit;
  end;
  Result := GR1;
  GT := G;
  exp := GT.Expo;
  if Odd(exp) {// Rendre l'exposant pair afin que (expo div 2) soit un entier}
    then
  begin
    dec(exp);
    GT.Sv := FGCentMulN10(GT.Sv, 1);
  end;
  // Calibrage pour les décimales :
  lg := length(GT.Sv) * FacteurDmax;
  de := nbDecimalesGr - lg;
  if de > 0 then
    GT.Sv := FGCentMulN10(GT.Sv, 2 * de)
  else
    de := 0;
  with Result do
  begin
    Sv := FRacineGCent(GT.sv);
    Expo := (exp div 2) - de;
    signe := '+';
  end;
end; // SqrtGR

function IncGR(G: tGR): tGR;
var
  nz: int64;
begin
  try
    Result := AddGr(G, GR1);
    //écrémage des zéros terminaux éventuels :
    if Result.Sv <> #0 then
    begin
      TrimD0GCent(Result.sv, nz);
      Result.Expo := Result.Expo + nz;
    end;
  except
    Result := GR0;
    raise;
  end;
end;

function DecGR(G: tGR): tGR;
var
  nz: int64;
begin
  try
    Result := DifGR(G, GR1);
    //écrémage des zéros terminaux éventuels :
    if Result.Sv <> #0 then
    begin
      TrimD0GCent(Result.sv, nz);
      Result.Expo := Result.Expo + nz;
    end;
  except
    Result := GR0;
    raise;
  end;
end;

function DemiGR(G: tGR): tGR;
begin
  with Result do
  begin
    sv := FDemiGCent(G.sv);
    Expo := G.Expo;
    Signe := G.signe;
  end;
end;

function DoubleGR(G: tGR): tGR;
begin
  try
    with Result do
    begin
      sv := FDoubleGCent(G.sv);
      Expo := G.Expo;
      Signe := G.signe;
    end;
  except
    Result := GR0;
    raise;
  end;
end;

function RandomGR(NbDigits: longword; const Impair: boolean): tGR;
var
  r: longint;
begin
  Result.sv := FRandomGCent(NbDigits, Impair);
  r := Random(100);
  if Odd(r) then
    Result.Expo := -Random(MaxInt)
  else
    Result.Expo := +Random(MaxInt);
  r := Random(100);
  if Odd(r) then
    Result.Signe := '-'
  else
    Result.Signe := '+';
end;

function GRMulN10(G: tGR; N: Int64): tGR;
//        Renvoie un GR Multiplié par 10^N que N soit positif ou négatif
begin
  Result := G;
{$Q+}
  try
    Result.Expo := Result.Expo + N;
  except
    if N > 0 then
      Result := GRPlusInfini
    else
      Result := GRMoinsInfini;
    raise;
  end;
end;

function GRMulN100(G: tGR; N: Int64): tGR;
//        Renvoie un GR multiplié N fois par 100 que N soit positif ou négatif
begin
  Result := G;
{$Q+}
  try
    Result.Expo := Result.Expo + 2 * N;
  except
    if N > 0 then
      Result := GRPlusInfini
    else
      Result := GRMoinsInfini;
    raise;
  end;
end;

function CharArrondi(const car1, car2: Char): Char;
//        CharArrondi renvoie '+' si la valeur de car1 doit être arrondie au nombre
//        entier supérieur le plus proche si car2 = '6'..'9'
//        Si car2 = '5' le résultat est car1 si car1 est pair sinon on arrondit.
begin
  Result := car1;
  case car2 of
    '5': if Odd(ord(car1)) then
        Result := '+';
    '6'..'9': Result := '+';
  end;
end;

function TruncRoundGR(V: tGR; poDecimale: longword): tGR; //
//        Renvoie la valeur tronquée et arrondie sur la décimale d'indice poDecimale
//        poDecimale = position de la décimale après le DecimalSeparator
//        Exemples :  12345.67890 donne TruncRoundGR(V,3) = 1.2345679E4
//                    12345.67790 donne TruncRoundGR(V,3) = 1.2345678E4
//                    12345.67750 donne TruncRoundGR(V,3) = 1.2345678E4
//        ( Réservé pour affichage des résultats de séries de caculs )
var
  lg, poE, poDS, poCh, Exp: Int64;
  carRes: char;
  sb10: string;
  tm: tGR;
begin
  Result := v;
  if (v.Expo = 0) or (v.sv = #0) or (v.Expo >= 0) then
    EXIT; //<- valeur nulle ou entière
  // ici v.Expo<0 valeurs fractionnaires :
  sb10 := GrToStrE(V);
  poE := pos('E', sb10);
  Exp := 0;
  if poE > 0 then
  begin
    Exp := StrToInt64(copy(sb10, poE + 1, MaxInt));
    SetLength(sb10, poE - 1);
  end;
  poDS := pos(DecimalSeparator, sb10);
  if poDS > 0 then
    Delete(sb10, poDS, 1);
  lg := length(sb10);
  poCh := poDS - 1 + poDecimale + Exp; // position du char à arrondir
  if poCh + 1 > lg then
    EXIT; // position car2 hors la string
  if poCh <= 0 then
  begin
    Result := GR0;
    EXIT;
  end;
  // ici poCh>0 :
  carRes := CharArrondi(sb10[poCh], sb10[poCh + 1]);
  if carRes = '+' then
  begin
    SetLength(sb10, poCh);
    tm := StrToGR(sb10);
    Result := AddGR(tm, GR1);
  end
  else
  begin
    sb10[poCh] := carRes;
    SetLength(sb10, poCh);
    Result := StrToGR(sb10);
  end;
  Result.Expo := Result.Expo - poDecimale;
  Result.Signe := V.Signe;
end; // TruncRoundGR

function RoundGR(V: tGR): tGR; // équivalent à round
//        Renvoie la valeur arrondie au nombre entier le plus proche de V,
//        et si V se trouve exactement à mi-chemin entre deux nombres entiers,
//        le résultat est toujours le nombre pair.
//        Exemples : 193.4567890 donne RoundGR = 1.93E2
//                   193.9567890 donne RoundGR = 1.94E2
//                   193.5567890 donne RoundGR = 1.94E2
//                   194.5567890 donne RoundGR = 1.94E2

begin
  Result := TruncRoundGR(V, 0);
end; // RoundGR

function RoundSurAvDernDecimale(V: tGR): tGR;
//        Réalise l'arrondi seulement si V.sv convertie comporte nbCSGR chiffres en base 10
begin
  Result := TruncRoundGR(V, nbCSGR - 2);
end;

function FactorielleGR(G: tGR): tGR;
var
  N, Nfinal, NR: tGR;
  aux: byte;
begin
  Result := GR1;
  try
    if (G.sv = #0) or AbsGREgaux(G, GR1) then
      EXIT; // factorielle(0 ou 1) = 1

    if (G.Expo < 0) or (G.Signe = '-') then
    begin
      sms('FactorielleGR : réservée aux nombres entiers positifs');
      EXIT;
    end;
    Nfinal := G;
    N := GR0;
    aux := 1;
    repeat N := AddGR(N, GR1);
      if aux <> 10 then
        Result := MulGR(N, Result)
      else if aux = 10 then
      begin // N = multiple de 10 : écrémage des 10% de zéros terminaux
        inc(Result.Expo);
        NR := GRMulN10(N, -1); // div par 10
        Result := MulGR(NR, Result);
        aux := 0;
      end;
      if Echapper then
      begin
        Result := GR0;
        EXIT;
      end;
      inc(aux);
    until AbsGREgaux(N, Nfinal);
  except
    Result := GR0;
    raise;
  end;
end; // FactorielleGR
{FactorielleGR(1234567) =621590586471231550926149008331891933156379855913769 E6984170
mis 22 sec

FactorielleGR(12345678) =14572604577113098336599097748433086666376960380231 E82187855
mis 3 min 54 sec ( Pentium III à 1,13 GHz) }

function CombinaisonsCpn(n, p: integer): extended; // Algo de base
//        Combinaisons sans répétitions des n pris p à p
//        Calcul sans utiliser factorielle pour éviter les opérations superflues
//        Calcul idem à celui effectué à la main où l'on raye les facteurs apparaissant
//        à la fois au numérateur et au dénominateur
var
  i, eli: integer;
  num, deno: extended;
begin
  num := 1;
  deno := 1;
  eli := n - (2 * p);
  if eli < 0 then
    eli := 0;
  try
    for i := p + 1 + eli to n do
      num := num * i;
    for i := 1 to n - p - eli do
      deno := deno * i;
    if deno = 0 then
      deno := 1; // car convention 0!=1
    Result := num / deno;
  except
    raise;
  end;
end; // CombinaisonsCpn

function CombinaisonsGR(n, p: tGR): tGR;
//        Combinaisons sans répétitions des n pris p à p
//        Calcul sans utiliser factorielle pour éviter les opérations superflues
var
  i, eli, iMax, num, deno: tGR;
begin
  Result := GR0;
  if (n.signe = '-') or (p.signe = '-') or (n.Expo < 0) or (p.Expo < 0) then
  begin
    sms('Combinaisons : Réservé aux nombres entiers positifs');
    EXIT;
  end;

  try
    if GRNul(p) // si p=0 ou si p=n alors Cpn=1;
    or AbsGREgaux(p, n) then
    begin
      Result := GR1;
      EXIT;
    end;

    num := GR1;
    deno := GR1;
    eli := DoubleGR(p);
    eli := DifGR(n, eli); //eli:=n-(2*p);
    if eli.signe = '-' then
      eli := GR0; //if eli<0 then eli:=0;
    // for i:=p+1+eli to n do num:=num*i :
    i := AddGR(p, eli);
    repeat i := AddGR(i, GR1);
      num := MulGR(num, i);
    until AbsGREgaux(i, n) or Echapper;

    //for i:=1 to n-p-eli do deno:=deno*i) :
    i := GR0;
    iMax := DifGR(n, p);
    iMax := DifGR(iMax, eli); // iMax=n-p-eli;
    repeat i := AddGR(i, GR1);
      deno := MulGR(deno, i);
    until AbsGREgaux(i, iMax) or Echapper; //i=n-p-eli;

    if deno.sv = #0 then
      deno := GR1; // car convention 0!=1
    Result := DivGR(num, deno); //Result:=num/deno;
    Result.signe := '+';
  except
    Result := GR0;
    raise;
  end;
end; // CombinaisonsGR

function ArrangementsGR(const n, p: tGR): tGR;
//        Arrangements des n pris p à p
//        Calcul avec utilisation de CombinaisonsGR et de FactorielleGR
var
  Cnp, factp: tGR;
begin // Exit sur cas particuliers :
  Result := GR0;
  if (n.signe = '-') or (p.signe = '-') or (n.Expo < 0) or (p.Expo < 0) then
  begin
    sms('Arrangements : réservé aux nombres entiers positifs');
    EXIT;
  end;
  try
    if GRNul(p) // si p=0 ou si p=n alors Cpn=1;
    or AbsGREgaux(p, n) then
    begin
      Result := GR1;
      EXIT;
    end;

    if (CompAbsGR(n, p) < 0) then // si n < p calcul impossible
    begin
      sms('Pour Arrangement de n pris p à p : n doit être >= p');
      EXIT;
    end;
    //Calculs :
    Cnp := CombinaisonsGR(n, p);
    if Cnp.signe = '+infini' then
    begin
      Result := Cnp;
      Exit;
    end;
    factp := FactorielleGR(p);
    if CompAbsGR(factp, GR1) > 0 then
    begin
      Result := MulGR(Cnp, factp); //Anp = Cnp*(p!)
      Result.signe := '+';
    end;
  except
    Result := GR0;
    raise;
  end;
end; // ArrangementsGR

function PuissanceGR(G: tGR; Exp: Int64): tGR;
//       Renvoie G^Exp si Exp entier positif ou négatif, qq soit G

  function PuissExpoPositif(X: tGR; Expo: Int64): tGR;
    //       Non récursive : Renvoie X^Exp avec Expo >= 0
  var
    tmp: tGR;
  begin
    Result := GR1;
    if (Expo = 0) then
      Exit
    else if (Expo = 1) then
    begin
      Result := X;
      Exit;
    end;
    Tmp := X;
    try
      repeat if odd(Expo) then
        begin
          Result := MulGR(Result, Tmp);
          dec(Expo);
        end
        else
        begin
          Tmp := MulGR(Tmp, Tmp);
          Expo := Expo div 2;
        end;
        //<- MulGR : avec troncature : important gain de vitesse
      until (Expo = 0) or Echapper;
    except
      Result := GR0;
      raise;
    end;
    if Echapper then
      Result := GR0;
  end;

begin
  Result := GR1;
  if Exp = 0 then
    Exit;
  if Exp = 1 then
  begin
    Result := G;
    Exit;
  end;
  // Calculs :
  try
    Result := PuissExpoPositif(G, Abs(Exp));
    if Exp > 0 then
      EXIT;
    Result := DivGR(GR1, Result);
  except
    ShowMessage('Exception dans PuissanceGR');
    Result := GR0;
    raise;
  end;
end; // PuissanceGR

function ExponentielleGR(X: tGR): tGR;
//        Exponentielle Népérienne
//        qq soit x : Développement limité de e^x = Sigma(x^n/n!) de n=0 à l'infini
//        Pour X inclus dans [-2.1237598959199934141E19 .. 4.6116860184273879E17]
var
  n, nDiv: Int64;
  Fract, resp, delta, deltap: tGR;
  cmp: shortInt;
begin // Exit cas particulier :
  try
    if GRNul(X) then
    begin
      Result := GR1;
      EXIT;
    end; // e^0 = 1
    // Pour une meilleure convergence ramener X < 1 :
    Fract := StrToGR('0.2');
    nDiv := 0;
    cmp := CompAbsGR(X, Fract);
    while (cmp >= 0) and (not Echapper) do
    begin
      inc(nDiv);
      X := DivGR(X, GR2);
      cmp := CompAbsGR(X, Fract);
    end;
    if Echapper then
    begin
      Result := GR0;
      EXIT;
    end;
    n := 0;
    resp := GR1;
    Deltap := resp;
    repeat inc(n);
      //Delta:=Deltap*X/n :
      Delta := MulGR(Deltap, X);
      Delta := DivGR(Delta, Int64ToGR(n));
      //Result:=Resp+Delta :
      Result := AddGR(Resp, Delta);
      if AbsGRInfAEpsilon(Delta) then
        Break;
      resp := Result;
      Deltap := Delta;
    until Echapper;
    if Echapper then
    begin
      Result := GR0;
      Exit;
    end;
    nbToursGR := n;
    // Si X a été réduit en le divisant par 2^nDiv,
    // alors on corrige Result en s'appuyant sur la relation :
    // Exp(x*2) = [Exp(x)]^2 donc on élève Result au carré autant de fois qu'il y a eu de nDiv
    while (nDiv > 0) and (not Echapper) do
    begin
      Result := CarreGR(Result);
      Dec(nDiv);
    end;
    if Echapper then
    begin
      Result := GR0;
      Exit;
    end;
  except
    Result := GR0;
    raise;
  end;
end; // ExponentielleGR

function LogNep10GR: tGR; // Renvoie Log Népérien de 10
//        Log népérien par DL de Gregory
//        Ln[ X = (1 + xg)/(1-xg)]/2 = xg + (xg^3)/3 + (xg^5)/5 + (xg^7)/7 + ...
//        A utiliser uniquement pour reconstituer le cas échéant la constante sLn10
//        de l'unit uPrecalcule vu la lenteur
//        Pour nbCSGR = 400 -> nbTours = 2268 : mis 32734 ms Pentium III à 1,13 GHz
var
  n: integer;
  xk, xg, xP, resp, delta: tGR;
begin
  try
    xg := DivGR(GR9, GR11); // xg = 9/11
    n := 0;
    xP := xg;
    resp := xg;
    xk := CarreGR(xg);
    repeat inc(n);
      xP := MulGR(xP, xk);
      Delta := DivGR(xP, Int64ToGR(2 * n + 1)); //Delta:=xP/(2*n+1);
      Result := AddGR(Resp, Delta);
      if Result.sv = resp.sv then
        Break;
      resp := Result;
    until Echapper;
    // Correctif :
    Result := MulGR(Result, GR2);
    nbToursGR := n;
  except
    Result := GR0;
    raise;
  end;
  if Echapper then
    Result := GR0;
end;

function LogNep2GR: tGR; // Renvoie Log Népérien de 2
//        Log népérien par DL de Gregory
//        Ln[ X = (1 + xg)/(1-xg)]/2 = xg + (xg^3)/3 + (xg^5)/5 + (xg^7)/7 + ...
//        Pour 400 Chiffres -> nbTours = 416 : mis 5969 ms Pentium III à 1,13 GHz
var
  n: integer;
  xk, xg, xP, resp, delta: tGR;
begin
  try
    xg := DivGR(GR1, GR3); // xg = 1/3
    n := 0;
    xP := xg;
    resp := xg;
    xk := CarreGR(xg);
    repeat inc(n);
      xP := MulGR(xP, xk);
      Delta := DivGR(xP, Int64ToGR(2 * n + 1)); //Delta:=xP/(2*n+1)
      Result := AddGR(Resp, Delta);
      if Result.sv = resp.sv then
        Break;
      resp := Result;
    until Echapper;
    // Correctif :
    Result := MulGR(Result, GR2);
    nbToursGR := n;
  except
    Result := GR0;
    raise;
  end;
  if Echapper then
    Result := GR0;
end;

function LogNep5GR: tGR; // Renvoie Log Népérien de 5
//        Log népérien par DL de Gregory
//        Ln[ X = (1 + xg)/(1-xg)]/2 = xg + (xg^3)/3 + (xg^5)/5 + (xg^7)/7 + ...
//        A utiliser uniquement pour reconstituer le cas échéant la constante sLn10
//        de l'unit uPrecalcule vu la lenteur
//        Pour 400 Chiffres -> nbTours = 1123 : mis 16125 ms Pentium III à 1,13 GHz
var
  n: integer;
  xk, xg, xP, resp, delta: tGR;
begin
  try
    xg := DivGR(GR4, GR6); // xg = 4/6
    n := 0;
    xP := xg;
    resp := xg;
    xk := CarreGR(xg);
    repeat inc(n);
      xP := MulGR(xP, xk);
      Delta := DivGR(xP, Int64ToGR(2 * n + 1)); //Delta:=xP/(2*n+1)
      Result := AddGR(Resp, Delta);
      if Result.sv = resp.sv then
        Break;
      resp := Result;
    until Echapper;
    // Correctif :
    Result := MulGR(Result, GR2);
    nbToursGR := n;
  except
    Result := GR0;
    raise;
  end;
  if Echapper then
    Result := GR0;
end;

function LogNepGR(const X: tGR): tGR;
label
  SAUT;
  //        Log népérien par DL de Gregory
  //        Ln[ X = (1 + xg)/(1-xg)]/2 = xg + (xg^3)/3 + (xg^5)/5 + (xg^7)/7 + ...
var
  n: int64;
  XT, tmp1, tmp2, xk, xg, xP, resp, delta, lim1, lim2, p10ln10: tGR;
  nDiv, nMul: int64;
  //        Xmin = 1E-99999999 et Xmax environ égal à 3.946..E536166022
begin // Exit sur cas particuliers :
  Result := GR0;
  if X.sv = #0 then // X = 0
  begin
    Result := GRMoinsInfini;
    EXIT;
  end;
  if X.Signe = '-' then
  begin
    sms('ln(x) seulement pour x positif');
    EXIT;
  end;
  if (X.sv = #1) and (X.Expo = 0) then
    EXIT; // X=1 -> Ln(1) = 0

  // Amélioration de la convergence : ramener X >= 0,29 ou X <= 3 en
  // multipliant/divisant X par 10^U de sorte que |xg| soit proche de 0,5
  // (X = 3 -> xg = 0,5 et X = 0,29 -> xg = 0,55)
  // Bornes choisies en plus de sorte que 0,29*10 < 3 et que 3 div 10 > 0,29
  try
    nDiv := 0;
    nMul := 0;
    XT := X;
    lim1 := ExtendedToGR(0.29);
    lim2 := ExtendedToGR(3);

    if (CompAbsGR(XT, lim1) >= 0) and (CompAbsGR(XT, lim2) <= 0) then
      goto Saut;

    if XT.Expo > 0 then
    begin
      nDiv := XT.Expo;
      XT.Expo := XT.Expo - nDiv;
    end;
    if XT.Expo < 0 then
    begin
      nMul := abs(XT.Expo);
      XT.Expo := XT.Expo + nMul;
    end;

    while CompAbsGR(XT, lim2) > 0 do
    begin
      XT.Expo := XT.Expo - 1;
      inc(nDiv);
    end;
    while CompAbsGR(XT, lim1) < 0 do
    begin
      XT.Expo := XT.Expo + 1;
      inc(nMul);
    end;
    Saut:
    tmp1 := DifGR(XT, GR1);
    tmp2 := AddGR(XT, GR1);
    xg := DivGR(tmp1, tmp2); // xg = (XT - 1)/(XT + 1)

    n := 0;
    xP := xg;
    resp := xg;
    xk := CarreGR(xg);
    repeat inc(n);
      xP := MulGR(xP, xk);
      Delta := DivGR(xP, Int64ToGR(2 * n + 1)); //Delta:=xP/(2*n+1)
      Result := AddGR(Resp, Delta);
      if Result.sv = resp.sv then
        Break;
      resp := Result;
    until Echapper;
    // Correctifs :
    Result := MulGR(Result, GR2);
    if nDiv - nMul > 0 then
    begin
      nDiv := nDiv - nMul;
      p10ln10 := MulGR(GRLn10, Int64ToGR(nDiv));
      Result := AddGR(Result, p10Ln10);
    end
    else if nMul - nDiv > 0 then
    begin
      nMul := nMul - nDiv;
      p10ln10 := MulGR(GRLn10, Int64ToGR(nMul));
      Result := DifGR(p10Ln10, Result);
    end;
    if CompAbsGR(X, GR1) < 0 then
      Result.signe := '-';
    nbToursGR := n;
  except
    Result := GR0;
    raise;
  end;
  if Echapper then
    Result := GR0;
end; // LogNepGR

function LogBase10GR(X: tGR): tGR;
var
  Expo10, tmp: tGR;
begin
  if X.Sv = #0 then // X=0
  begin
    Result := GRMoinsInfini;
    EXIT;
  end;
  if X.Signe = '-' then // X<0
  begin
    sms('TgvLogBase10(x) seulement pour x>0');
    Result := GR0;
    EXIT;
  end;

  try
    Expo10 := Int64ToGR(X.Expo);
    X.Expo := 0;
    tmp := DivGR(LogNepGR(X), GRLn10); // Log10(X) = Ln(X)/Ln(10)
    Result := AddGR(tmp, Expo10);
  except
    Result := GR0;
    raise;
  end;
  if Echapper then
    Result := GR0;
end;

function FracGR(X: tGR): tGR;
//       Renvoie la partie décimale de X      // ex : Frac(123.456)  =  0.456
var
  lg: integer;
  sgc10, fract: string; // ex : Frac(-123.456) = -0.456
begin
  if X.Expo >= 0 then
  begin
    Result := GR0;
    EXIT;
  end; // X = entier
  Result := X;
  sgc10 := FGCentToStr(X.sv);
  lg := length(sgc10);
  if - X.Expo = lg then
    EXIT // X = tout fractionnaire
  else if - X.Expo < lg then
  begin
    Fract := copy(sgc10, lg + X.Expo + 1, MaxInt);
    Result.sv := FStrToGCent(Fract);
    Result.Expo := X.Expo;
    Result.Signe := X.Signe;
    EXIT;
  end; //else Result:=X;
end;

procedure TruncFractGR(X: tGR; var Trun, Fra: tGR);
//        Scinde X en sa partie entière (Trun) et sa partie fractionnaire (Fra)
//        Si X = -123.456 ==> Trun = -123 et Fra = -0.456
var
  lg: integer;
  sgc10, F, T: string;
begin
  Trun := X;
  Fra := GR0;
  if X.Expo >= 0 then
    EXIT; // X = entier
  sgc10 := FGCentToStr(X.sv);
  lg := length(sgc10);
  if - X.Expo >= lg then
  begin
    Trun := GR0;
    Fra := X;
    EXIT
  end // X = tout fractionnaire
  else if - X.Expo < lg then
  begin // Partie fractionnaire :
    F := copy(sgc10, lg + X.Expo + 1, MaxInt);
    Fra.sv := FStrToGCent(F);
    Fra.Expo := X.Expo;
    // Partie entière :
    T := copy(sgc10, 1, lg + X.Expo);
    Trun.sv := FStrToGCent(T);
    Trun.Expo := 0;
  end;
end;

function PowerGR(const Base, Expo: tGR): tGR;
//       Renvoie Base à la puissance Expo si Base > 0 et Expo = qcq
var
  cmp: shortint;
  FracExpo, TruncExpo, tmp: tGR;
  N: Int64;
begin
  try
    cmp := CompAbsGr(Expo, GR0);
    if cmp = 0 {// Expo = 0 -> n^0 = 1} then
    begin
      Result := GR1;
      EXIT;
    end
    else
      {//si (Base = 0) et (Expo > 0) alors} if (GRNul(Base)) and (cmp > 0)
        {// 0^n = 0 si n > 0} then
      begin
        Result := GR0;
        EXIT;
      end;
    //si (Base <>  0) et (Expo = 1) alors
    if (not GRNul(Base)) and AbsGrEgaux(Expo, GR1) {// n^1 = n} then
    begin
      Result := Base;
      EXIT;
    end
    else
    begin
      TruncFractGR(Expo, TruncExpo, FracExpo);
      if GRNul(FracExpo) then // Expo entier
      begin
        N := GRToInt64(TruncExpo);
        Result := PuissanceGR(Base, N);
      end
      else // Expo réel
      begin // y^x = e^(x.Ln(y)) --> Result := Exponentielle(Expo * Ln(Base))
        tmp := LogNepGR(Base);
        tmp := MulGR(Expo, tmp);
        Result := ExponentielleGR(tmp);
      end;
    end;
  except
    Result := GR0;
    raise;
  end;
end; // PowerGR

function DixPuissXGR(const Expo: tGR): tGR;
begin
  try
    Result := PowerGR(GR10, Expo);
  except
    Result := GR0;
    raise;
  end;
end;

function RacNiemeGR(const Base, Expo: tGR): tGR;
//        Renvoie racine Expo-ième de Base avec Expo positif ou négatif même fractionnaire si Base > 0
//        de même que si Base < 0 et que Expo est impair
var
  invExpo: tGR;
begin
  try
    invExpo := DivGR(GR1, Expo);
    if Base.signe = '+' then
    begin
      Result := PowerGR(Base, invExpo);
      EXIT;
    end
    else if GRPair(Expo) = Impair then
    begin
      Result := PowerGR(AbsGR(Base), invExpo);
      Result.signe := Base.signe;
    end
    else
    begin
      sms('RacNiemeGR : Base étant négatif, réservé aux cas où Expo est impair'
        + cls
        + 'Résultat mis à zéro (racine complexe)');
      Result := GR0;
    end;
  except
    Result := GR0;
    raise;
  end;
end;

procedure ActuLgConstantes;
  // Actualise la longueur des constantes Pi etc en fonction du nombre de chiffes significatifs
var
  lg: longword;
  info: string;
begin
  nbDecimalesGr := nbCsGr - 1;
  info := 'Avertissement : sur les ' + intToStr(nbCsGr) + ' chiffres souhaités';
  // Pour Pi :
  lg := length(sPi2000) - 1; //-1 pour le DS
  if nbCsGr < lg then
    GRPi := StrToGR(copy(sPi2000, 1, nbCsGr + 2)) {+2 par précaution}
  else if nbCsGr = lg then
    GRPi := StrToGR(sPi2000)
  else
  begin
    GRPi := StrToGR(sPi2000);
    info := info + cls + cls + ' - Pi précalculé comporte seulement ' +
      intToStr(lg) + ' chiffres significatifs';
  end;
  GRPiSur2 := DivGR(GRPi, GR2);
  GRPiSur3 := DivGR(GRPi, GR3);
  GRPiSur4 := DivGR(GRPi, GR4);
  GR3PiSur4 := MulGR(GR3, GRPiSur4);
  GR2Pi := MulGR(GR2, GRPi);
  // Pour Log népérien de 10 :
  lg := length(sLn10) - 1;
  if nbCsGr < lg then
    GRLn10 := StrToGR(copy(sLn10, 1, nbCsGr + 2))
  else if nbCsGr = lg then
    GRLn10 := StrToGR(sLn10)
  else
  begin
    GRLn10 := StrToGR(sLn10);
    info := info + cls + ' - Ln(10) précalculé comporte seulement ' +
      intToStr(lg) + ' chiffres significatifs';
  end;
  // Pour RacineCarrée(2)/2 :
  lg := length(sRCarreeDe2Sur2) - 1;
  if nbCsGr < lg then
    GRRacCarreeDe2Sur2 := StrToGR(copy(sRCarreeDe2Sur2, 1, nbCsGr + 2))
  else if nbCsGr = lg then
    GRRacCarreeDe2Sur2 := StrToGR(sRCarreeDe2Sur2)
  else
  begin
    GRRacCarreeDe2Sur2 := StrToGR(sRCarreeDe2Sur2);
    info := info + cls + ' - RacineCarrée(2)/2 précalculé comporte seulement ' +
      intToStr(lg) + ' chiffres significatifs';
  end;
  // Pour Epsilon :
  with GREpsilon do
  begin
    signe := '+';
    sv := #1;
    Expo := -nbCSGR;
  end;
  if pos(cls, info) > 0 then
    ShowMessage(info); //LRFlotte(info,60,RGB(213,204,187),clYellow);
end;

function cPi: tGR; // Renvoie Pi = 3.1415926 ... via algo de Plouffe
//       20 minutes pour 2001 chiffres :  HYPER-LENT !!!
var
  i: longint;
  Huiti, igr, t1, t2, t3, t4, tc, SeizePuissi: tGR;
begin
  Result := GR0;
  i := 0;
  try
    repeat
      igr := Int64ToGR(i);
      Huiti := MulGR(GR8, igr);
      t1 := IncGR(Huiti);
      t1 := DivGR(GR4, t1); //= 4/(8*i + 1)
      t2 := AddGR(Huiti, GR4);
      t2 := DivGR(GR2, t2); //= 2/(8*i + 4)
      t3 := AddGR(Huiti, GR5);
      t3 := DivGR(GR1, t3); //= 1/(8*i + 5)
      t4 := AddGR(Huiti, GR6);
      t4 := DivGR(GR1, t4); //= 1/(8*i + 6)
      tc := DifGR(t1, t2);
      tc := DifGR(tc, t3);
      tc := DifGR(tc, t4); //tc = t1-t2-t3-t4
      SeizePuissi := PuissanceGR(GR16, i); // 16^i
      tc := DivGR(tc, SeizePuissi);
      Result := AddGR(Result, tc);
      inc(i);
    until AbsGRInfAEpsilon(tc) or Echapper;
  except
    Result := GR0;
    raise;
  end;
end;

//---- TRIGONOMETRIE -----------------------------------------------------------

function RadToDegGR(Rad: tGR): tGR;
begin
  try
    Result := MulGR(GR180, Rad);
    Result := DivGR(Result, GRPi);
  except
    Result := GR0;
    raise;
  end;
end;

function DegToRadGR(Deg: tGR): tGR;
begin
  try
    Result := MulGR(GRPi, Deg);
    Result := DivGR(Result, GR180);
  except
    Result := GR0;
    raise;
  end;
end;

function ArcTangente2(const Y, X: Extended): Extended; //Maquette Delphi retenue
//        qq soit X,Y : Renvoie ArcTangente(Y/X) en Radiants entre +Pi et -Pi
var
  n: integer;
  Tan, xP, resp, delta, absTan, absTan2: Extended;
  ok, Plage0, Plage1, Plage2, Plage3: boolean;
begin // Développement direct en série seulement pour |Tan = Y/X| < 1');
  // sinon pour |Tan|>1, ArcTangente(Tan) = +/-Pi/2 - ArcTangente(1/Tan)
  // et pour  pour accélérer la convergence dans les plages encadrant X = 1
  // conversion avec
  //    Atan(Tan) = Atan((1+Tan)/(1-Tan)) - PiSur4   si [0.5 <= Tan < 1[  Plage1
  // ou Atan(Tan) = Atan((1+Tan)/(1-Tan)) + 3PiSur4) si ]1   < Tan <= 2]  Plage2
  // donc tout ça à k*Pi/4 près, donc calculs dans 1er Qudrant, puis ajustement

  // EXIT sur cas particuliers :
  Result := 0;
  if (Y = 0) and (X <> 0) then
    EXIT;
  if X = 0 then
  begin
    if Y > 0 then
      Result := Pi / 2
    else
      Result := -Pi / 2;
    EXIT;
  end;
  if Y = 0 then
    sms('ArcTangente2 : Y = 0');
  Tan := Y / X;
  if abs(Tan) = 1 then
  begin
    if (Y > 0) and (X > 0) then
      Result := Pi / 4
    else if (Y > 0) and (X < 0) then
      Result := 3 * Pi / 4
    else if (Y < 0) and (X < 0) then
      Result := -3 * Pi / 4
    else if (Y < 0) and (X > 0) then
      Result := -Pi / 4;
    EXIT;
  end;
  try // Calculs :
    // Plages :
    Plage0 := False;
    Plage1 := False;
    Plage2 := False;
    Plage3 := False;
    AbsTan := abs(Tan);
    if AbsTan < 0.5 then
      Plage0 := True
    else if (AbsTan >= 0.5) and (AbsTan < 1) then
      Plage1 := True
    else if (AbsTan > 1) and (AbsTan <= 2) then
      Plage2 := True
    else if AbsTan > 2 then
      Plage3 := true;

    if Plage1 or Plage2 then
      Tan := (1 + Tan) / (1 - Tan);
    AbsTan := abs(Tan);
    if AbsTan > 1 then
      AbsTan := 1 / AbsTan;

    n := -1;
    ok := false;
    resp := 0;
    xP := 1 / AbsTan; //< xP de sorte que xP:=xP*AbsTan² = AbsTan au 1er tour
    absTan2 := AbsTan * AbsTan;
    repeat inc(n);
      xP := xP * AbsTan2; //xP = numérateur du terme courant Delta
      Delta := xP / (2 * n + 1);
      if odd(n) then
        Result := Resp - Delta
      else
        Result := Resp + Delta;
      if Result = resp then
        ok := true;
      resp := Result;
    until ok or Echapper;
    nbToursGR := n + 1;
    // 1ier Quadrant :
    if Plage1 then
      Result := Pi / 4 - Result
    else if Plage2 then
      Result := Pi / 4 + Result
    else if Plage3 then
      Result := Pi / 2 - Result;
    if (Y < 0) and (X > 0) then
      Result := -Result
    else {// 4ième Quadrant} if (Y > 0) and (X < 0) then
        Result := Pi - Result
      else {// 2ième Quadrant} if (Y < 0) and (X < 0) then
          Result := Pi + Result; // 3ième Quadrant
  except
    raise;
  end;
  if Echapper then
    Result := 0;
end; // ArcTangente2

function ArcTan2DLGR(const Y, X: tGR): tGR;
//        qq soit X,Y : Renvoie ArcTangente(Y/X) en Radiants entre +Pi et -Pi
var
  n: integer;
  Tan, xP, resp, delta, absTan, absTan2, tp1, tm1: tGR;
  Plage1, Plage2, Plage3: boolean;
  cmp1, cmp2, cmp3: shortInt;
begin // Développement direct en série seulement pour |Tan = Y/X| < 1');
  // sinon pour |Tan|>1, ArcTangente(Tan) = +/-Pi/2 - ArcTangente(1/Tan)
  // et pour  pour accélérer la convergence dans les plages encadrant X = 1
  // conversion avec
  //    ArcTangente(Tan) = ArcTangente((1+Tan)/(1-Tan)) - PiSur4   si [0.5 <= Tan < 1[  Plage1
  // ou ArcTangente(Tan) = ArcTangente((1+Tan)/(1-Tan)) + 3PiSur4) si ]1   < Tan <= 2]  Plage2
  // donc tout ça à k*Pi/4 près, donc calculs dans 1er quadrant, puis ajustement

  // EXIT sur cas particuliers :
  Result := GR0;
  if (Y.sv = #0) and (X.sv <> #0) then
    EXIT;
  if X.sv = #0 then
  begin
    Result := GRPisur2;
    if Y.signe = '-' then
      Result.signe := '-';
    EXIT;
  end;

  try
    Tan := DivGR(Y, X);
    absTan := AbsGR(Tan);

    if AbsGREgaux(absTan, GR1) then //if abs(Tan)=1 then
    begin
      if (Y.Signe = '+') and (X.Signe = '+') then
        Result := GRPisur4
      else if (Y.Signe = '+') and (X.Signe = '-') then
        Result := GR3Pisur4
      else if (Y.Signe = '-') and (X.Signe = '-') then
      begin
        Result := GR3Pisur4;
        Result.Signe := '-';
      end
      else if (Y.Signe = '-') and (X.Signe = '+') then
      begin
        Result := GRPisur4;
        Result.Signe := '-';
      end;
      EXIT;
    end;
    // Calculs :
    // Plages :
    AbsTan := AbsGR(Tan);
    cmp1 := CompAbsGR(AbsTan, ExtendedToGR(0.5));
    cmp2 := CompAbsGR(AbsTan, GR1);
    cmp3 := CompAbsGR(AbsTan, GR2);
    //Plage0:=cmp1<0;                // AbsTan < 0.5
    Plage1 := (cmp1 >= 0) and (cmp2 < 0); // 0.5 <= AbsTan < 1
    Plage2 := (cmp2 > 0) and (cmp3 <= 0); //   1 < AbsTan <= 2
    Plage3 := (cmp3 > 0);

    if Plage1 or Plage2 then //Tan:=(1+Tan)/(1-Tan);
    begin
      tp1 := AddGR(GR1, Tan);
      tm1 := DifGR(GR1, Tan);
      Tan := DivGR(tp1, tm1);
    end;
    AbsTan := AbsGR(Tan);
    //if AbsTan>1 then AbsTan:=1/AbsTan :
    if CompAbsGR(AbsTan, GR1) > 0 then
      AbsTan := DivGR(GR1, AbsTan);

    n := -1;
    resp := GR0;
    xP := DivGR(GR1, AbsTan);
      //< xP=1/AbsTan de sorte que xP:=xP*AbsTan² = AbsTan au 1er tour
    AbsTan2 := CarreGR(AbsTan);
    repeat inc(n);
      xP := MulGR(xP, AbsTan2);
        //xP:=xP*AbsTan² xP = numérateur du terme courant Delta
      Delta := DivGR(xP, Int64ToGR(2 * n + 1)); //Delta:=xP/(2*n+1);
      if odd(n) then
        Result := DifGR(Resp, Delta)
      else
        Result := AddGR(Resp, Delta);
      resp := Result;
    until (AbsGRInfAEpsilon(Delta)) or Echapper;
    nbToursGR := n + 1;
    // 1ier Quadrant :
    if Plage1 then
      Result := DifGR(GRPisur4, Result)
    else if Plage2 then
      Result := AddGR(GRPiSur4, Result)
    else if Plage3 then
      Result := DifGR(GRPisur2, Result);
    if (Y.Signe = '-') and (X.Signe = '+') then
      Result := ChangeSigneGR(Result)
    else {// 4ième Quadrant} if (Y.Signe = '+') and (X.Signe = '-') then
        Result := DifGR(GRPi, Result)
      else {// 2ième Quadrant} if (Y.Signe = '-') and (X.Signe = '-') then
          Result := AddGR(GRPi, Result); // 3ième Quadrant
  except
    Result := GR0;
    raise;
  end;
  if Echapper then
    Result := GR0;
end; // ArcTan2DLGR

function ArcTangenteDLGR(Tan: tGR): tGR;
//        Renvoie ArcTangente(Tan) en Radiants entre +Pi/2 et -Pi/2
var
  n: integer;
  xP, resp, delta, absTan, absTan2, tp1, tm1: tGR;
  Plage1, Plage2, Plage3: boolean;
  cmp1, cmp2, cmp3: shortInt;
begin // Développement limité en série direct seulement pour |Tan| < 1');
  // sinon pour |Tan|>1, ArcTangente(Tan) = +/-Pi/2 - ArcTangente(1/Tan)
  // et pour  pour accélérer la convergence dans les plages encadrant X = 1
  // conversion avec :
  //    ArcTangente(Tan) = ArcTangente((1+Tan)/(1-Tan)) - PiSur4   si [0.5 <= Tan < 1[  Plage1
  // ou ArcTangente(Tan) = ArcTangente((1+Tan)/(1-Tan)) + 3PiSur4) si ]1   < Tan <= 2]  Plage2
  // donc tout ça à k*Pi/4 près, donc calculs dans 1er quadrant, puis ajustement

  // EXIT sur cas particuliers :
  Result := GR0;
  if Tan.sv = #0 then
    EXIT;
  if Tan.Signe = '+infini' then
  begin
    Result := GRPisur2;
    EXIT;
  end
  else if Tan.Signe = '-infini' then
  begin
    Result := GRPisur2;
    Result.signe := '-';
    EXIT;
  end;

  try
    if AbsGREgaux(Tan, GR1) then //if abs(Tan)=1 then
    begin
      Result := GRPisur4;
      Result.Signe := Tan.Signe;
      EXIT;
    end;
    // Calculs :
    // Plages :
    cmp1 := CompAbsGR(Tan, ExtendedToGR(0.5));
    cmp2 := CompAbsGR(Tan, GR1);
    cmp3 := CompAbsGR(Tan, GR2);
    //Plage0:=cmp1<0;                  // AbsTan < 0.5
    Plage1 := (cmp1 >= 0) and (cmp2 < 0); // 0.5 <= AbsTan < 1
    Plage2 := (cmp2 > 0) and (cmp3 <= 0); //   1 < AbsTan <= 2
    Plage3 := (cmp3 > 0);

    if Plage1 or Plage2 then //Tan:=(1+Tan)/(1-Tan);
    begin
      tp1 := AddGR(GR1, Tan);
      tm1 := DifGR(GR1, Tan);
      Tan := DivGR(tp1, tm1);
    end;
    AbsTan := AbsGR(Tan);
    //if AbsTan>1 then AbsTan:=1/AbsTan :
    if CompAbsGR(AbsTan, GR1) > 0 then
      AbsTan := DivGR(GR1, AbsTan);

    n := -1;
    resp := GR0;
    xP := DivGR(GR1, AbsTan);
      //< xP=1/AbsTan de sorte que xP:=xP*AbsTan² = AbsTan au 1er tour
    absTan2 := CarreGR(absTan);
    repeat inc(n);
      xP := MulGR(xP, absTan2);
        //xP:=xP*AbsTan*AbsTan  xP = numérateur du terme courant Delta
      Delta := DivGR(xP, Int64ToGR(2 * n + 1)); //Delta:=xP/(2*n+1)
      if odd(n) then
        Result := DifGR(Resp, Delta)
      else
        Result := AddGR(Resp, Delta);
      resp := Result;
    until AbsGRInfAEpsilon(Delta) or Echapper;
    nbToursGR := n + 1;
    // 1ier Quadrant :
    if Plage1 then
      Result := DifGR(GRPisur4, Result)
    else if Plage2 then
      Result := AddGR(GRPiSur4, Result)
    else if Plage3 then
      Result := DifGR(GRPisur2, Result);
    if Tan.Signe = '-' then
      Result := ChangeSigneGR(Result); // 4ième Quadrant
  except
    Result := GR0;
    raise;
  end;
  if Echapper then
    Result := GR0;
end; // ArcTangenteDLGR

function CosinusDLGR(const ADeg: tGR): tGR;
//        qq soit x : développement en série
var
  n: integer;
  xRa, xRa2, xD, Q, resp, den, delta, deltap: tGR;
begin
  xD := ADeg;
  try // Cas |xD| > 360° : on réduit :
    DivModGR(ADeg, GR360, Q, xD);
    // Exit sur cas particuliers :
    // Cas xD = 0 -> 1
    Result := GR1;
    if GRNul(xD) then
      EXIT;
    // Cas xD = ±360°
    if AbsGREgaux(xD, GR360) then
      EXIT;
    // Cas xD = ±180°
    if AbsGREgaux(xD, GR180) then
    begin
      Result.signe := '-';
      EXIT;
    end;
    // Cas xD = ±90° ou ±270-> 0
    if AbsGREgaux(xD, GR90)
      or AbsGREgaux(xD, GR270) then
    begin
      Result := GR0;
      EXIT;
    end;
    // Cas xD = ±60° ou ±300°
    if AbsGREgaux(xD, GR60)
      or AbsGREgaux(xD, GR300) then
    begin
      Result := ExtendedToGR(0.5);
      EXIT;
    end;
    // Cas xD = ±120° ou ±240°
    if AbsGREgaux(xD, GR120)
      or AbsGREgaux(xD, GR240) then
    begin
      Result := ExtendedToGR(-0.5);
      EXIT;
    end;

    xRa := DegToRadGR(xD);
    n := 0;
    resp := GR1;
    deltap := GR1;
    xRa2 := CarreGR(xRa);
    repeat inc(n);
      Den := Int64ToGR(2 * n * (2 * n - 1)); //Den:=2*n*(2*n -1);
      Delta := MulGR(Deltap, xRa2);
      Delta := DivGR(Delta, Den);
      if odd(n) then
        Result := DifGR(Resp, Delta)
      else
        Result := AddGR(Resp, Delta);
      if AbsGREgaux(Result, resp) then
        Break;
      resp := Result;
      Deltap := Delta;
    until Echapper;
    nbToursGR := n;
  except
    Result := GR0;
    raise;
  end;
  if Echapper then
    Result := GR0;
end; // CosinusDLGR

function SinusDLGR(const ADeg: tGR): tGR;
//        qq soit x
var
  n: integer;
  xRa, xRa2, xD, Q, resp, den, delta, deltap: tGR;
begin
  Result := GR0;
  try // Cas |xD| > 360° : on réduit
    DivModGR(ADeg, GR360, Q, xD);
    // Exit sur cas particuliers :
    // Cas xD = 0
    if GRNul(xD) then
      EXIT;
    // Cas xD = ±180° ou ±360°
    if AbsGREgaux(xD, GR180) or AbsGREgaux(xD, GR360) then
      EXIT;
    // Cas xD = ±90°
    if AbsGREgaux(xD, GR90) then
    begin
      if xD.Signe = '+' then
        Result := GR1
      else
        Result := GR_1;
      EXIT;
    end;
    // Cas xD = ±270°
    if AbsGREgaux(xD, GR270) then
    begin
      if xD.Signe = '+' then
        Result := GR_1
      else
        Result := GR1;
      EXIT;
    end;
    // Cas xD = ±30° ou ±150°
    if AbsGREgaux(xD, GR30) or AbsGREgaux(xD, GR150) then
    begin
      Result := ExtendedToGR(0.5);
      if xD.Signe = '-' then
        Result.signe := '-';
      EXIT;
    end;
    // Cas xD = ±210° ou ±330°
    if AbsGREgaux(xD, GR210) or AbsGREgaux(xD, GR330) then
    begin
      Result := ExtendedToGR(0.5);
      if xD.Signe = '+' then
        Result.signe := '-';
      EXIT;
    end;

    xRa := DegToRadGR(xD);
    xRa2 := CarreGR(xRa);
    n := 0;
    resp := xRa;
    deltap := xRa;
    repeat inc(n);
      Den := Int64ToGR(2 * n * (2 * n + 1)); //Den:=2*n*(2*n +1)
      Delta := MulGR(Deltap, xRa2);
      Delta := DivGR(Delta, Den); //Delta:=Deltap*xRa*xRa/Den
      if odd(n) then
        Result := DifGR(Resp, Delta)
      else
        Result := AddGR(Resp, Delta);
      if AbsGREgaux(Result, resp) then
        Break;
      resp := Result;
      Deltap := Delta;
    until Echapper;
    nbToursGR := n;
  except
    Result := GR0;
    raise;
  end;
  if Echapper then
    Result := GR0;
end; //SinusDLGR

//sinus 35 =  0.5735764363510460961080319128261578646204333714509863510810271181694568998525616100597220126402203332120219451983344933487617392014384606974385971421099361708834518934626351769151392926964855012816421768645048228849961493038598198990820249073428958568

procedure SinCosDLGR(const ADeg: tGR; var Sinu, Cosi: tGR);
//        qq soit ADeg : développement en série
var
  n: integer;
  xRa, xRa2, xD, Q: tGR;
  respCo, denCo, deltaCo, deltapCo: tGR; // Pour Cos
  respSi, denSi, deltaSi, deltapSi: tGR; // Pour Sin
begin
  xD := ADeg;
  try // Cas |xD| > 360° : on réduit
    DivModGR(ADeg, GR360, Q, xD);
    Sinu := GR0;
    Cosi := GR0;
    // Exit sur cas particuliers :
    if GRNul(xD)
      or AbsGREgaux(xD, GR360) then //Cas xD = 0 ou xD = ±360°
    begin
      Sinu := GR0;
      Cosi := GR1;
      EXIT;
    end
    else
      if AbsGREgaux(xD, GR180) then // Cas xD = ±180°
      begin
        Sinu := GR0;
        Cosi := GR1;
        Cosi.Signe := '-';
        EXIT;
      end
      else
        if AbsGREgaux(xD, GR90) then //Cas xD = ±90°
        begin
          Sinu := GR1;
          Sinu.Signe := xD.Signe;
          Cosi := GR0;
          EXIT;
        end
        else if AbsGREgaux(xD, GR270) then // Cas xD = ±270
        begin
          Sinu := GR1;
          if xD.Signe = '+' then
            Sinu.Signe := '-';
          Cosi := GR0;
          EXIT;
        end;
    // Calculs :
    xRa := DegToRadGR(xD);
    n := 0;
    xRa2 := CarreGR(xRa);
    respCo := GR1;
    deltapCo := GR1; // Pour Cos
    respSi := xRa;
    deltapSi := xRa; // Pour Sin
    repeat inc(n);
      DenCo := Int64ToGR(2 * n * (2 * n - 1)); // DenCo:=2*n*(2*n -1 ) pour Cos
      DenSi := Int64ToGR(2 * n * (2 * n + 1)); // DenSi:=2*n*(2*n +1 ) pour Sin

      DeltaCo := MulGR(DeltapCo, xRa2);
      DeltaCo := DivGR(DeltaCo, DenCo);

      DeltaSi := MulGR(DeltapSi, xRa2);
      DeltaSi := DivGR(DeltaSi, DenSi);

      if odd(n) then
      begin
        Cosi := DifGR(RespCo, DeltaCo);
        Sinu := DifGR(RespSi, DeltaSi);
      end
      else
      begin
        Cosi := AddGR(RespCo, DeltaCo);
        Sinu := AddGR(RespSi, DeltaSi);
      end;
      respCo := Cosi;
      DeltapCo := DeltaCo;
      respSi := Sinu;
      DeltapSi := DeltaSi;
    until AbsGRInfAEpsilon(DeltaCo) or Echapper;
    // Pour Cos :
    if AbsGREgaux(xD, GR60)
      or AbsGREgaux(xD, GR300) then // Cas xD = ±60° ou ±300°
    begin
      Cosi := ExtendedToGR(0.5);
    end
    else if AbsGREgaux(xD, GR120)
      or AbsGREgaux(xD, GR240) then // Cas xD = ±120° ou ±240°
    begin
      Cosi := ExtendedToGR(-0.5);
    end;
    // Pour Sin :
    if AbsGREgaux(xD, GR30)
      or AbsGREgaux(xD, GR150) then // Cas xD = ±30° ou ±150°
    begin
      Sinu := ExtendedToGR(0.5);
      if xD.Signe = '-' then
        Sinu.signe := '-';
    end
    else if AbsGREgaux(xD, GR210)
      or AbsGREgaux(xD, GR330) then // Cas xD = ±210° ou ±330°
    begin
      Sinu := ExtendedToGR(0.5);
      if xD.Signe = '+' then
        Sinu.signe := '-';
    end;
    nbToursGR := n;
  except
    Sinu := GR0;
    Cosi := GR0;
    raise;
  end;
  if Echapper then
  begin
    Sinu := GR0;
    Cosi := GR0;
  end;
end; // SinCosDLGR

function TangenteDLGR(const xDeg: tGR): tGR;
var
  xD, Q, Sinu, Cosi: tGR;
begin
  xD := xDeg;
  try // Cas |xD| > 360° : on réduit
    DivModGR(xDeg, GR360, Q, xD);
    // Exit sur cas xD = ±90° ou ±270°
    if AbsGREgaux(xD, GR90) then
    begin
      if xD.Signe = '+' then
        Result := GRPlusInfini
      else
        Result := GRMoinsInfini;
      EXIT;
    end;
    if AbsGREgaux(xD, GR270) then
    begin
      if xD.Signe = '-' then
        Result := GRPlusInfini
      else
        Result := GRMoinsInfini;
      EXIT;
    end;
    // Exit sur cas xD = ±45° ou ±225°
    if AbsGREgaux(xD, GR45)
      or AbsGREgaux(xD, GR225) then
    begin
      if xD.Signe = '+' then
        Result := GR1
      else
        Result := GR_1;
      EXIT;
    end;
    // Exit sur cas xD = ±135° ou ±315°
    if AbsGREgaux(xD, GR135)
      or AbsGREgaux(xD, GR315) then
    begin
      if xD.Signe = '+' then
        Result := GR_1
      else
        Result := GR1;
      EXIT;
    end;
    SinCosDLGR(xD, Sinu, Cosi);
    Result := DivGR(Sinu, Cosi);
    nbToursGR := 2 * nbToursGR;
  except
    Result := GR0;
    raise;
  end;
  if Echapper then
    Result := GR0;
end; // TangenteDLGR

procedure SinCosGR(Y, X: tGR; var Sinu, Cosi: tGR);
//        Renvoie Sinus et Cosinus de l'angle dont la Tangente = Y/X
var
  Tan, Den: tGR;
begin
  try
    Tan := DivGR(Y, X);
    Den := CarreGR(Tan);
    Den := AddGR(GR1, Den);
    Den := SqrtGR(Den);
    Cosi := DivGR(GR1, Den);
    Sinu := MulGR(Tan, Cosi);
    Sinu.Signe := Y.Signe;
    Cosi.Signe := X.Signe;
  except
    Sinu := GR0;
    Cosi := GR0;
    raise;
  end;
end; // SinCosGR

procedure SinCosMiAngleGR(Y, X: tGR; var Sinu, Cosi: tGR);
//        Renvoie Sinus(a) et Cosinus(a) à partir de Y/X = Tangente(2a)
//        Tangente-mi-angle = Tana = -(1/tg2a) +/-RacCarrée(1 + (1/tg2a)²)
var
  Tan2a, Tana1, Tana2, Tana, UnSurTan2a, radical: tGR;
begin
  try
    if GRNul(Y) then // Y = 0
    begin
      if X.signe = '+' then //Angle = 0 si X > 0 et MiAngle = 0
      begin
        Sinu := GR0;
        Cosi := GR1;
      end
      else // Angle = Pi si X < 0 et MiAngle = Pi/2
      begin
        Sinu := GR1;
        Cosi := GR0;
      end;
      EXIT;
    end;
    if GRNul(X) then // X = 0
    begin
      Sinu := GRRacCarreeDe2Sur2;
      Cosi := GRRacCarreeDe2Sur2;
      if Y.signe = '+' then
        EXIT //Angle = Pi/2 si Y > 0 et MiAngle = Pi/4
      else
        Sinu.signe := '-'; //Angle = -Pi/2 si Y < 0 et MiAngle = -Pi/4
      EXIT;
    end;
    //Tangente-mi-angle = Tana = -(1/tg2a) +/-RacCarrée(1 + (1/tg2a)²)
    Tan2a := DivGR(Y, X);
    UnSurTan2a := DivGR(GR1, Tan2a);
    radical := CarreGr(UnSurTan2a);
    radical := AddGR(GR1, radical);
    radical := SqrtGR(radical);

    Tana1 := DifGR(Radical, UnSurTan2a);
    Tana2 := AddGR(UnSurTan2a, radical);
    Tana2 := ChangeSigneGR(Tana2);

    if Y.Signe = '+' then
      Tana := Tana1 // 1er et 2ième Quadrant
    else
      Tana := Tana2; // 3ième et 4ième Quadrant
    SinCosGR(Tana, GR1, Sinu, Cosi);
  except
    Sinu := GR0;
    Cosi := GR0;
    raise;
  end
end; // SinCosMiAngleGR(Y,X

function ArcSinusGR(X: tGR): tGR;
//        pour abs(x)<=1
var
  tmp: tGR;
  cmp: shortInt;
begin
  try
    if GRNul(X) then // xR=0
    begin
      Result := GR0;
      EXIT;
    end;

    cmp := CompAbsGR(X, GR1);
    if cmp > 0 then
    begin
      sms('ArcSinus seulement pour |x| <=1');
      Result := GR0;
      EXIT;
    end;
    if cmp = 0 then
    begin
      Result := GRPiSur2;
      Result.signe := X.signe;
      EXIT;
    end;
    //Result := ArcTangente2(X,sqrt(1-X*X)) :
    tmp := CarreGR(X);
    tmp := DifGR(GR1, tmp);
    tmp := SqrtGR(tmp);
    Result := ArcTan2DLGR(X, tmp);
  except
    Result := GR0;
    raise;
  end;
end; // ArcSinusGR

function ArcCosinusGR(X: tGR): tGR;
//        pour abs(x)<=1
var
  tmp: tGR;
  cmp: shortint;
begin
  try
    if GRNul(X) then // X = 0
    begin
      Result := GRPiSur2;
      EXIT;
    end;

    cmp := CompAbsGR(X, GR1);
    if cmp > 0 then // X > 1
    begin
      sms('ArcCosinus seulement pour |x| <=1');
      Result := GR0;
      EXIT;
    end;
    if cmp = 0 then // X = 1
    begin
      if X.signe = '+' then
        Result := GR0
      else
        Result := GRPi;
      EXIT;
    end;
    //Result := ArcTangente2(sqrt(1-X*X),X) :
    tmp := CarreGR(X);
    tmp := DifGR(GR1, tmp);
    tmp := SqrtGR(tmp);
    Result := ArcTan2DLGR(tmp, X);
  except
    Result := GR0;
    raise;
  end;
end; // ArcCosinusGR

//---- FONCTIONS HYPERBOLIQUES -------------------------------------------------

{function  ChxGR(const X : tGR) : tGR;
//        Cosinus hyperbolique qq soit x : avec Développement en série
//        Marche mais 29 fois plus lent qu'avec ExponentielleGR.
var       n : integer; resp,den,delta,deltap,x2 : tGR;
begin     try n:=0; resp:=GR1; deltap:=GR1; x2:=CarreGR(X);
              repeat inc(n);
                     Den:=Int64ToGR(2*n*(2*n -1)); //Den:=2*n*(2*n -1);
                     if GRNul(Den) then Den:=GR1;  //if Den=0 then Den:=1; 0! = 1
                     Delta:=MulGR(Deltap,x2);
                     Delta:=DivGR(Delta,Den);      //Delta:=Deltap*X*X/Den;
                     Result:=AddGR(Resp,Delta);    //Result:=Resp+Delta;
                     if AbsGREgaux(Result,resp) then Break;
                     resp:=Result;
                     Deltap:=Delta;
              until Echapper;
              nbToursGR:=n;
          except
              Result:=GR0;
              raise;
          end;
          if Echapper then Result:=GR0;
end; // ChxGR
}

function ChxGR(const X: tGR): tGR;
//        Cosinus hyperbolique qq soit x (avec ExponentielleGR)
var
  epx, emx: tGR;
begin
  try
    epx := ExponentielleGR(X);
    emx := ExponentielleGR(ChangeSigneGR(X));
    Result := AddGR(epx, emx);
    Result := DivGR(Result, GR2);
    nbToursGR := nbToursGR * 2;
  except
    Result := GR0;
    raise;
  end;
end; // ChxGR

{function  ShxGR(const X : tGR) : tGR;
//        Sinus hyperbolique qq soit x : avec Développement en série
//        Marche mais 29 fois plus lent qu'avec ExponentielleGR.
var       n : integer; resp,den,delta,deltap,x2 : tGR;
begin     try  n :=0; resp:=X; deltap:=X; x2:=CarreGR(X);
               repeat inc(n);
                      Den:=Int64ToGr(2*n*(2*n +1));  //Den:=2*n*(2*n +1);
                      Delta:=MulGR(Deltap,x2);       //Delta:=Deltap*X*X/Den;
                      Delta:=DivGR(Delta,Den);
                      Result:=AddGR(Resp,Delta);     //Result:=Resp+Delta;
                      If AbsGREgaux(Result,resp) then Break;
                      resp:=Result;
                      Deltap:=Delta;
               until Echapper;
               nbToursGR:=n;
           except
               Result:=GR0;
               raise;
           end;
           if Echapper then Result:=GR0;
end; // ShxGR
}

function ShxGR(const X: tGR): tGR;
//        Sinus hyperbolique qq soit x (avec Développement en série)
var
  epx, emx: tGR;
begin
  try
    epx := ExponentielleGR(X);
    emx := ExponentielleGR(ChangeSigneGR(X));
    Result := DifGR(epx, emx);
    Result := DivGR(Result, GR2);
    nbToursGR := nbToursGR * 2;
  except
    Result := GR0;
    raise;
  end;
end; // ShxGR

function ThxGR(const X: tGR): tGR;
//        Tangente hyperbolique qq soit X
var
  epx, emx, num, den: tGR;
begin
  try
    epx := ExponentielleGR(X);
    emx := ExponentielleGR(ChangeSigneGR(X));
    num := DifGR(epx, emx);
    den := AddGR(epx, emx);
    Result := DivGR(num, den);
    nbToursGR := nbToursGR * 2;
  except
    Result := GR0;
    raise;
  end;
end; // ShxGR

//---- HYPERBOLIQUES RECIPROQUES -----------------------------------------------

function ArgChGR(const X: tGR): tGR;
//       ArgCh(X) = Ln[X ± Sqrt(X² - 1)] pour X >= 1
var
  tmp: tGR;
begin
  Result := GR0;
  try
    if CompAbsGR(X, GR1) < 0 then
    begin
      sms('ArgCosHyperbolique seulement pour X >= 1');
      EXIT;
    end;
    tmp := CarreGR(X);
    tmp := DifGR(tmp, GR1);
    tmp := SqrtGR(tmp);
    tmp := AddGR(X, tmp);
    Result := LogNepGR(tmp);
  except
    Result := GR0;
    raise;
  end;
end;

function ArgShGR(const X: tGR): tGR;
//       ArgSh(X) = Ln[X + Sqrt(X² + 1)] pour X réel
var
  tmp: tGR;
begin
  try
    tmp := CarreGR(X);
    tmp := AddGR(tmp, GR1);
    tmp := SqrtGR(tmp);
    tmp := AddGR(X, tmp);
    Result := LogNepGR(tmp);
  except
    Result := GR0;
    raise;
  end;
end;

function ArgThGR(const X: tGR): tGR;
//       ArgTh(X) = Ln[(1 + X)/(1 - X)]/2 pour |X| < 1
var
  tmp1, tmp2: tGR;
begin
  try
    if CompAbsGR(X, GR1) >= 0 then
    begin
      if X.Signe = '+' then
        Result := GRPlusInfini
      else
        Result := GRMoinsInfini;
      EXIT;
    end;
    tmp1 := AddGR(GR1, X);
    tmp2 := DifGR(GR1, X);
    tmp2 := DivGR(tmp1, tmp2);
    Result := LogNepGR(tmp2);
    Result := DivGR(Result, GR2);
  except
    Result := GR0;
    raise;
  end;
end;

function EstPremierInt64(Nb: Int64): boolean;
//       Marche mais non utilisée ici
label
  RECOMM, SUITE, FIN;
var
  Nombre, NombreTest, Diviseur, Reste, Racine, Paire: Extended;
begin
  if (Nb = 2) or (Nb = 3) then
  begin
    Result := True;
    EXIT;
  end;
  Nombre := Nb;
  NombreTest := Nombre;
  Diviseur := 3;
  Paire := Frac(Nombre / 2);
  if Paire = 0 then
    Nombre := Nombre + 1;
  RECOMM:
  Reste := Frac(Nombre / Diviseur);
  if Reste = 0 then
    goto SUITE
  else
    Racine := SQRT(Nombre);
  if Diviseur > Racine then
    goto FIN
  else
    Diviseur := Diviseur + 2;
  goto RECOMM;
  SUITE:
  Nombre := Nombre + 2;
  Diviseur := 3;
  goto RECOMM;
  FIN:
  Result := Nombre = NombreTest;
end;

initialization

  // Constantes :
  with GRPlusInfini do
  begin
    signe := '+infini';
    Sv := #1;
    Expo := 0;
  end;
  with GRMoinsInfini do
  begin
    signe := '-infini';
    Sv := #1;
    Expo := 0;
  end;

  GR0 := Int64ToGR(0);
  GR1 := Int64ToGR(1);
  GR_1 := Int64ToGR(-1);
  GR2 := Int64ToGR(2);
  GR3 := Int64ToGR(3);
  GR4 := Int64ToGR(4);
  GR5 := Int64ToGR(5);
  GR6 := Int64ToGR(6);
  GR8 := Int64ToGR(8);
  GR9 := Int64ToGR(9);
  GR10 := Int64ToGR(10);
  GR11 := Int64ToGR(11);

  GR16 := Int64ToGR(16);
  GR30 := Int64ToGR(30);
  GR45 := Int64ToGR(45);
  GR60 := Int64ToGR(60);
  GR90 := Int64ToGR(90);
  GR120 := Int64ToGR(120);
  GR135 := Int64ToGR(135);
  GR150 := Int64ToGR(150);
  GR180 := Int64ToGR(180);
  GR200 := Int64ToGR(200);
  GR210 := Int64ToGR(210);
  GR225 := Int64ToGR(225);
  GR240 := Int64ToGR(240);
  GR270 := Int64ToGR(270);
  GR300 := Int64ToGR(300);
  GR315 := Int64ToGR(315);
  GR330 := Int64ToGR(330);
  GR360 := Int64ToGR(360);
  nbCsGr := 51;
    //<-- Nombre de chiffres significatifs : modifier le 51 en fonction des besoins
  DecimalSeparator := '.';
  ActuLgConstantes;

end.

