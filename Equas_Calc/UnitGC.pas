unit UnitGC;

interface //*********************************************************
//   Pour calculs avec Grands nombres Complexes           *
//   avec part réelle et imaginaire du type tGR           *
//              Code : EXPERIMENTAL                       *
//*********************************************************

uses Windows, UnitGR, classes, Math, Dialogs, Sysutils, uFun2, clipbrd;

type
  tGC = record
    a: tGR; // part réelle
    b: tGR; // part imaginaire
  end;

var
  GC0, GC1, GC2, GC_1, GC_2: tGC; // var contenant des constantes (0,1,2,-1,-2)

procedure NettSaisieGC(var s: string); // Routine de nettoyage des chaînes
//        saisies en interface

function StrToGC(str: string): tGC; // format entrée a+i*b
function GCToStrE(Z: tGC): string; // format de sortie : Idem
function GCToStrEA(Z: tGC): string;
  // Idem mais avec arrondi sur avant dernière décimale
function GCToStrECut(Z: tGC; LCut: longInt): string;
  // format sortie a+i*b : 2.35123456789013E-31 +i*..
// mais avec troncature à LCut chiffres significatifs

function GCToStrNS15(v: tGC): string; // Idem mais avec LCut = 15
procedure SeparerPartiesGC(ChnComplexe: string; var sa, sb: string); // Renvoie
// via sa, sb la partie réelle et la partie imaginaire

function RoCarreeGR(var Z: tGC): tGR; // Carré du module
function RoGR(Z: tGC): tGR; // Module
function ThetaRadGR(Z: tGC): tGR; // Argument en Radians
function ThetaDegGR(Z: tGC): tGR; // Argument en Degrés

function MulGC(Z1, Z2: tGC): tGC;
function CarreGC(Z: tGC): tGC;
function DivGC(zNum, zDeno: tGC): tGC;
function AddGC(Z1, Z2: tGC): tGC;
function DifGC(Z1, Z2: tGC): tGC;
function PowerIntGC(Z: tGC; Expo: longword): tGC; // pour Expo >=0 en entrée
function PowerExtGC(Z: tGC; Expo: Extended): tGC; // pour Expo réel

type
  tNRacines = tStringList;

function RacineCarree4GC(Z: tGC): tNRacines;
function SLRacinesNiemesGC(Z: tGC; N: Extended; UneSeule: boolean): tStringList;
//<- Renvoie la liste des Racines Nièmes pour Z et N qcq même fractionnaires posititifs ou négatifs
//   lorsque UneSeule = False
//   La liste est réduite à une seule racine si UneSeule = True ou si N est fractionnaire

function Equa2emeDegreGC(a, b, c: tGC): tNRacines;
  // Renvoie les racines d'une équation du 2ème degré

// Routines de tests :

function CompAbsIntGC(const Z: tGC; Int: Int64): shortint;
//<-      Renvoie 0 si Z est entier et Abs(Z) = Abs(Int) sinon renvoie -1

function EgalAIntGC(const Z: tGC; Int: Int64): boolean;
//<-      Renvoie True si Z = Int

function EgalZeroGC(const Z: tGC): boolean;
//<-      Renvoie True si Z = 0

function AbsInfOuEgalALimiteGC(Z: tGC; Limite: tGR): boolean;
//<-      Renvoie True si les valeurs absolues de la partie réelle et de la partie
//        imaginaire de Z sont inférieures ou égales à celle de Limite

function AbsInfAEpsilonGC(const Z: tGC): boolean;
//<-      Renvoie True si les valeurs absolues des deux composantes de Z sont
//        inférieures à celle de GREpsilon qui dépend de nbCsGr (NC)

function CompAbsGC(Z1, Z2: tGC): shortint;
//<-      Compare les carrés des modules de Z1 et de Z2
//        - si égaux alors Result = 0
//        - si celui de Z1 inférieur alors Result <0, si supérieur alors Result >0

procedure QuickSortGC(var AR: array of tGC);
// tri ordre croissant pour le tracé des courbes

implementation

uses uEquas8;

procedure NettSaisieGC(var s: string);
const
  esp = ['0'..'9', '+', '-', '.', 'i', '*', 'e', 'E'];
  //        Si la saisie s = EEE---+00005,,,...2+EEe---+22+--++i***ii***ii000.,,,..045EEEeeeE+--8+++
  //        nett1 renvoie 5.2E+22+i*0.045E-8
  //        Si s = '' alors s renvoyée = 0
var
  i: integer;
  sa, sb: string;

  function Finitions(var s: string): string;
  var
    sign, iet: shortString;
    i, lg: integer;
  begin
    Result := '';
    if s = '' then
      EXIT;
    // Elimination de caractères indésirables en fin de s
    while (s <> '') and (s[length(s)] in (['+', '-', '.', ',', '*', 'e', 'E']))
      do
      Delete(s, length(s), 1);
    if length(s) = 0 then
    begin
      Result := '0';
      EXIT;
    end;
    sign := '+'; // Par défaut
    if (s[1] = '-') or (s[1] = '+') then
    begin
      sign := s[1];
      Delete(s, 1, 1);
    end;

    iet := '';
    i := pos('i*', s);
    if i > 0 then
    begin
      iet := 'i*';
      Delete(s, i, 2);
    end;
    // suppresion 0 superflus de gauche
    lg := Length(s);
    i := 1;
    while (i <= lg) and (s[i] = '0') do
      Inc(i);
    s := Copy(s, i, maxInt);
    if length(s) > 0 then
    begin
      if s[1] = '.' then
        s := '0' + s; // rajout d'un 0 si < 1
      Result := sign + iet + s;
    end;
  end;

begin
  if s = '' then
  begin
    s := '0';
    EXIT;
  end;
  // Elimination caractères indésirables :
  i := 1;
  while (i <= length(s)) do
    if not (s[i] in esp) then
      Delete(s, i, 1)
    else
      inc(i);
  // Conversions e -> E
  i := pos('e', s);
  while i > 0 do
  begin
    s[i] := 'E';
    i := pos('e', s);
  end;
  // Conversions I -> i
  i := pos('I', s);
  while i > 0 do
  begin
    s[i] := 'i';
    i := pos('I', s);
  end;
  // Eliminations de e ou E en début
  while (length(s) > 0) and (s[1] = 'E') do
    Delete(s, 1, 1);
  while (length(s) > 0) and (s[1] = 'e') do
    Delete(s, 1, 1);
  // Répétitions de + ou -
  i := 1;
  while i <= length(s) - 1 do
  begin
    if ((s[i] = '+') and (s[i + 1] = '+'))
      or ((s[i] = '-') and (s[i + 1] = '-')) then
      Delete(s, i + 1, 1)
    else
      inc(i);
  end;
  //Répétitions du DecimalSeparator ou Seperator incorrect
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
  // Répétitions de E
  i := pos('EE', s);
  while i > 0 do
  begin
    Delete(s, i, 1);
    i := pos('EE', s);
  end;
  // Répétitions de i
  i := pos('ii', s);
  while i > 0 do
  begin
    Delete(s, i, 1);
    i := pos('ii', s);
  end;
  // Répétitions de *
  i := pos('**', s);
  while i > 0 do
  begin
    Delete(s, i, 1);
    i := pos('**', s);
  end;
  // Elimination de * devant i
  i := pos('*i', s);
  while i > 0 do
  begin
    Delete(s, i, 1);
    i := pos('*i', s);
  end;
  // Répétitions de i*i*  :
  i := pos('i*i*', s);
  while i > 0 do
  begin
    Delete(s, i, 2);
    i := pos('i*i*', s);
  end;
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
  // Répétitions de i (rebelote si les modifs en on produit une)
  i := pos('ii', s);
  while i > 0 do
  begin
    Delete(s, i, 1);
    i := pos('ii', s);
  end;
  // Répétitions de * rebelote si les modifs en on produit une)
  i := pos('**', s);
  while i > 0 do
  begin
    Delete(s, i, 1);
    i := pos('**', s);
  end;

  // Absence de * après i sauf si i sans opérande
  i := pos('i', s);
  if (i > 0) and (i <> length(s)) and (pos('*', s) = 0) then
    insert('*', s, i + 1);

  SeparerPartiesGC(s, sa, sb);
  sa := Finitions(sa);
  sb := Finitions(sb);
  if (sa <> '') and (sa[1] = '+') then
    Delete(sa, 1, 1);
  if (sa = '') and (sb <> '') and (sb[1] = '+') then
    Delete(sb, 1, 1);
  s := sa + sb;
  if s = '' then
    s := '0';
end; // NettSaisieGC

function StrToGC(str: string): tGC; // format entrée a+i*b
label
  Saut;
var
  st, sa, sb: string;
  poi: integer;
begin
  sa := '';
  sb := '';
  st := TrimS(str);
  if st = '' then
    goto Saut;
  poi := pos('i', st);
  if poi = 0 then
  begin
    sa := st;
    goto Saut;
  end; // réel pur
  // ici poi > 0
  sa := copy(st, 1, poi - 2);
  sb := copy(st, poi - 1, maxInt);
  if (sb <> 'i') and (sb <> '+i') and (sb <> '-i')
    and (pos('*', sb) = 0) then
  begin
    sms('Donnée incorrecte : manque ''*'' dans part imaginaire' + cls + str);
    EXIT;
  end;

  if (sb = '+i') or (sb = 'i') then
  begin
    sb := '1';
    goto Saut;
  end;
  if (sb = '-i') then
  begin
    sb := '-1';
    goto Saut;
  end;

  // Suppression du i et du *
  poi := pos('i*', sb);
  Delete(sb, poi, 2);
  Saut:
  if sa = '' then
    sa := '0';
  if sb = '' then
    sb := '0';
  try
    Result.a := StrToGR(sa);
    Result.b := StrToGR(sb);
  except
    raise;
  end;
end; // StrToGC

function GCToStrE(Z: tGC): string; // format sortie a+i*b
var
  s, sa, sb: string;
begin
  sa := GRToStrE(Z.a);
  sb := GRToStrE(Z.b);
  if sa = '0' then
    sa := '';
  if (sb = '0') or (sb = '-0') then
    sb := '';
  if z.b.Signe = '+' then
  begin
    if sb = '1' then
      sb := ' +i'
    else if sb <> '' then
      sb := ' +i*' + sb;
  end
  else if z.b.Signe = '-' then
  begin
    Delete(sb, 1, 1);
    if sb = '1' then
      sb := ' -i'
    else if sb <> '' then
      sb := ' -i*' + sb;
  end;
  s := sa + sb;
  if s = '' then
    s := '0';
  Result := s;
end; // GCToStrE

function GCToStrEA(Z: tGC): string; // format sortie a+i*b mais avec Arrondi sur
//       avant dernière décimale
var
  tmp: tGC;
begin
  tmp.a := RoundSurAvDernDecimale(Z.a);
  tmp.b := RoundSurAvDernDecimale(Z.b);
  Result := GCToStrE(tmp);
end;

function GCToStrECut(Z: tGC; LCut: longInt): string;
  // format sortie 2.3512..13E-31 +i*..
//        Renvoie string écourtée à LCut + exposant
var
  sa, sb: string;
begin
  sa := GrToStrECut(Z.a, LCut);
  sb := GrToStrECut(Z.b, LCut);
  if sb = '0' then
    sb := ''
  else if sb = '1' then
    sb := ' + i'
  else if sb = '-1' then
    sb := ' - i'
  else if sb[1] = '-' then
  begin
    Delete(sb, 1, 1);
    sb := ' - i*' + sb;
  end
  else
    sb := ' + i*' + sb;
  if sa = '0' then
    sa := '';
  Result := sa + sb;
  if Result = '' then
    Result := '0';
end;

function GCToStrNS15(v: tGC): string; // Idem mais avec LCut = 15
begin
  Result := GCToStrECut(v, 15);
end;

procedure SeparerPartiesGC(ChnComplexe: string; var sa, sb: string);
//        Renvoie partie réelle et partie imaginaire via var sa et sb
var
  i, poi: integer;
begin
  sa := '';
  sb := '';
  ChnComplexe := TrimS(ChnComplexe);
  if ChnComplexe = '' then
    EXIT;
  // Cas erreur par Inversions *i -> Ré-inversion
  i := 1;
  while i <= length(ChnComplexe) - 1 do
  begin
    if (ChnComplexe[i] = '*') and (ChnComplexe[i + 1] = 'i') then
    begin
      ChnComplexe[i] := 'i';
      ChnComplexe[i + 1] := '*';
    end
    else
      inc(i);
  end;
  poi := pos('i', ChnComplexe);
  if poi > 0 then
  begin
    sa := copy(ChnComplexe, 1, poi - 2);
    sb := copy(ChnComplexe, poi - 1, maxInt);
  end
  else
    sa := ChnComplexe;
  while (length(sa) > 0) and ((sa[length(sa)] = '+') or (sa[length(sa)] = '-'))
    do
    Delete(sa, length(sa), 1);
  while (length(sb) > 0) and ((sb[length(sb)] = '+') or (sb[length(sb)] = '-'))
    do
    Delete(sb, length(sb), 1);
end;

function RoCarreeGR(var Z: tGC): tGR; // Carré du module
begin //ro^2:=z.a*z.a + z.b*z.b;
  try
    Result := AddGR(CarreGR(z.a), CarreGR(z.b));
  except
    Result := GR0;
    raise;
  end;
end;

function RoGR(Z: tGC): tGR; // Module
var
  tmp: tGR;
begin
  try
    tmp := RoCarreeGR(Z);
    Result := SqrtGR(tmp);
  except
    Result := GR0;
    raise;
  end;
end;

function ThetaRadGR(Z: tGC): tGR; // Argument en Radians
begin //tangente de theta = b/a
  Result := GR0;
  try
    if GRNul(Z.b) then // b=0
    begin
      if Z.a.Signe = '+' then
        Result := GR0
      else
        Result := GRPi;
      EXIT;
    end;
    //ici b différent de 0
    if GRNul(Z.a) then // a = 0
    begin
      Result := GRPiSur2;
      if Z.b.Signe = '-' then
        Result.Signe := '-';
      EXIT;
    end;
    //ici a et b différent de 0
    Result := ArcTan2DLGR(Z.b, Z.a);
  except
    Result := GR0;
    raise;
  end;
end; // ThetaRadGR

function ThetaDegGR(Z: tGC): tGR; // Argument en Degrés
begin //tangente de theta = b/a
  Result := GR0;
  try
    if GRNul(Z.b) then // b=0
    begin
      if Z.a.Signe = '+' then
        Result := GR0
      else
        Result := GR180;
      EXIT;
    end;
    //ici b différent de 0
    if GRNul(Z.a) then // a = 0
    begin
      Result := GR90;
      if Z.b.Signe = '-' then
        Result.Signe := '-';
      EXIT;
    end;
    //ici a et b différent de 0
    Result := ArcTan2DLGR(Z.b, Z.a);
    Result := RadToDegGR(Result);
  except
    Result := GR0;
    raise;
  end;
end; // ThetaDegGR

function MulGC(Z1, Z2: tGC): tGC; // Multiplication
var
  tmpr, tmps: tGC;
begin //P.a = z1.a*z2.a - z1.b*z2.b
  try
    tmpr.a := MulGR(z1.a, z2.a);
    tmps.a := MulGR(z1.b, z2.b);
    Result.a := DifGR(tmpr.a, tmps.a);
    //P.b = z1.a*z2.b + z1.b*z2.a
    tmpr.b := MulGR(z1.a, z2.b);
    tmps.b := MulGR(z1.b, z2.a);
    Result.b := AddGR(tmpr.b, tmps.b);
  except
    Result := GC0;
    raise;
  end;
end; // MulGC(Z1,Z2 : tGC) : tGC;

function CarreGC(Z: tGC): tGC; // Carré
//       Z² = a² - b² + i*2*a*b
var
  tmp1, tmp2: tGC;
begin
  try
    tmp1.a := CarreGR(z.a);
    tmp2.a := CarreGR(z.b);
    Result.a := DifGR(tmp1.a, tmp2.a);
    tmp1.b := MulGR(GR2, z.a);
    Result.b := MulGR(tmp1.b, z.b);
  except
    Result := GC0;
    raise;
  end;
end; // CarreGC(Z)

function DivGC(zNum, zDeno: tGC): tGC; // Division
var
  deno, tmp, tmp1, tmp2, tmp3, tmp4, tmp5: tGR;
  Quotient: tGC;
begin
  try //deno:=zDeno.a*zDeno.a + zDeno.b*zDeno.b;
    tmp := CarreGR(zDeno.a);
    tmp1 := CarreGR(zDeno.b);
    deno := AddGR(tmp, tmp1);
    if not GRNul(deno) then
    begin //tmp2.a:=(zNum.a*zDeno.a + zNum.b*zDeno.b)/deno;
      tmp := MulGR(zNum.a, zDeno.a);
      tmp1 := MulGR(zNum.b, zDeno.b);
      tmp2 := AddGR(tmp, tmp1);
      Quotient.a := DivGR(tmp2, deno);
      tmp3 := MulGR(zNum.a, zDeno.b);
      tmp4 := MulGR(zNum.b, zDeno.a);
      tmp5 := DifGR(tmp4, tmp3);
      Quotient.b := DivGR(tmp5, deno);
    end
    else
    begin // Cas division par 0
      Quotient.a := GRPlusInfini;
      Quotient.b := GR0; // Leurre
    end;
    Result := Quotient;
  except
    Result := GC0;
    raise;
  end;
end; // DivGC(zNum,zDeno

function AddGC(Z1, Z2: tGC): tGC; // Addition Z1 + Z2
begin
  try //S.a = z1.a+z2.a; S.b = z1.b+z2.b;
    Result.a := AddGR(z1.a, z2.a);
    Result.b := AddGR(z1.b, z2.b);
  except
    Result := GC0;
    raise;
  end;
end;

function DifGC(Z1, Z2: tGC): tGC; // Différence Z1 - Z2
begin
  try //Res.a:=z1.a - z2.a; Res.b:=z1.b - z2.b;
    Result.a := DifGR(z1.a, z2.a);
    Result.b := DifGR(z1.b, z2.b);
  except
    Result := GC0;
    raise;
  end;
end;

function PowerIntGC(Z: tGC; Expo: longword): tGC;
//       Non récursive : Renvoie Z^Exp avec Expo >= 0
var
  tmp: tGC;
begin
  Result.a := GR1;
  Result.b := GR0;
  if (Expo = 0) then
    Exit
  else if (Expo = 1) then
  begin
    Result := Z;
    Exit;
  end;
  Tmp := Z;
  try
    repeat if odd(Expo) then
      begin
        Result := MulGC(Result, Tmp);
        dec(Expo);
      end
      else
      begin
        Tmp := CarreGC(Tmp);
        Expo := Expo div 2;
      end;
    until (Expo = 0) or Echapper;
    if Echapper then
    begin
      Result := GC0;
      EXIT;
    end;
  except
    Result := GC0;
    raise;
  end;
end;

function PowerExtGC(Z: tGC; Expo: Extended): tGC;
  // pour Expo réel positif ou négatif
//       Avec formule de Moivre
var
  ro, tetD, co, si: tGR;
begin
  try
    ro := RoGR(Z);
    tetD := ThetaDegGR(Z);
    ro := PowerGR(ro, ExtendedToGR(Expo));
    tetD := MulGR(tetD, ExtendedToGR(Expo));
    SinCosDLGR(tetD, Si, Co);
    Result.a := MulGR(ro, co);
    Result.b := MulGR(ro, si);
  except
    Result := GC0;
    raise;
  end;
end;

function SLRacinesNiemesGC(Z: tGC; N: Extended; UneSeule: boolean): tStringList;
//        Renvoie la liste des Racines Nièmes pour Z et N qcq même fractionnaires posititifs ou négatifs
//        lorsque UneSeule = False
//        La liste est réduite à une seule racine si UneSeule = True ou si N est fractionnaire
//        Avec formule de Moivre
//        Exemples :
//         - Si N = -3.4 et Z = 2.2 + i*4.4 alors une racine égale à 0.5929983 -i*0.2002268
//         - Si N = +3.4 et Z = 2.2 + i*4.4 alors une racine égale à 1.5137633 +i*0.5111246
//         - Si N = 4 et Z = -7 +i*24 alors 4 racines :
//           r1 =  1.9999... +i*0.9999... =  2 + i
//           r2 = -0.9999... +i*1.9999... = -1 + i*2
//           r3 = -1.9999... -i*0.9999... = -2 - i
//           r4 =  0.9999... -i*1.9999... =  1 - i*2
var
  ro, tet, rad, co, si: tGR;
  rac: tGC;
  k: Longint;
  nt: int64;
begin
  Result := tStringList.create;
  try
    if EgalAIntGC(Z, 0) then
    begin
      Result.Add('0');
      EXIT;
    end;
    // calculs
    nt := trunc(N);
    if nt < 0 then
      nt := abs(nt);
    ro := RoGR(Z);
    tet := ThetaRadGR(Z);
    ro := PowerGR(ro, ExtendedToGR(1 / N));
    ro := AbsGR(ro);
    if (abs(nt) <> abs(N)) // N réel fractionnaire donc au moins une racine
    or UneSeule then
      nt := 1; // si UneSeule inutile de calculer les autres
    for k := 0 to nt - 1 do
    begin //co:=cos((tet+2*k*Pi)/n) et si:=sin((tet+2*k*Pi)/n)
      rad := MulGR(GR2Pi, Int64ToGR(k));
      rad := AddGR(rad, tet);
      rad := DivGR(rad, ExtendedToGR(N));
      SinCosDLGR(RadToDegGR(rad), si, co);
      rac.a := MulGR(ro, co); //rac.a:=ro*co;
      rac.b := MulGR(ro, si); //rac.b:=ro*si;
      Result.Add(GCToStrE(rac));
    end;
  except
    Result.clear;
    raise;
  end;
end; // SLRacinesNiemesGC

function RacineCarree4GC(Z: tGC): tNRacines;
//        Calcul direct
var
  ra, rb, module: tGR;
  s, signe: string;
begin
  Result := tStringList.create;
  try // si Z = 0 :
    if (Z.a.sv = #0) and (Z.b.sv = #0) then
    begin
      Result.add('0');
      Result.add('0');
      EXIT;
    end
    else
      {// si Z = + ou -1} if (Z.a.sv = #1) and (Z.a.Expo = 0) and (Z.b.sv = #0)
        then
      begin
        if Z.a.Signe = '+' then
        begin
          Result.add('1');
          Result.add('-1');
          EXIT;
        end
        else
        begin
          Result.add('i');
          Result.add('-i');
          EXIT;
        end;
      end;
    if GRNul(Z.b) then // Z.b = 0 : cas réel pur
    begin
      ra := SqrtGR(Z.a);
      s := GRToStrE(ra);
      if Z.a.Signe = '-' then
        s := 'i*' + s;
      Result.add(s);
      Result.add('-' + s);
      EXIT;
    end;
    if GRNul(Z.a) then // Z.a = 0 : cas imaginaire pur
    begin
      ra := DivGR(Z.b, GR2);
      ra := SqrtGR(ra);
      s := GRToStrE(ra);
      if Z.b.Signe = '+' then
      begin
        Result.add(s + '+i*' + s);
        Result.add('-' + s + '-i*' + s);
      end
      else
      begin
        Result.add(s + '-i*' + s);
        Result.add('-' + s + '+i*' + s);
      end;

      if Z.b.Signe = '-' then
        s := 'i*' + s;
      Result.add(s);
      Result.add('-' + s);
      EXIT;
    end;
    // Cas Z.a et Z.b <> 0 :
    // ra = RacineCarrée[(module + Z.a)/2] :
    module := RoGR(Z);
    ra := AddGR(module, Z.a);
    ra := DivGR(ra, GR2);
    ra := SqrtGR(ra);
    // rb = RacineCarrée[(module - Z.a)/2] :
    rb := DifGR(module, Z.a);
    rb := DivGR(rb, GR2);
    rb := SqrtGR(rb);
    signe := Z.b.Signe;
    if signe = '+' then
    begin
      Result.add(GRToStrE(ra) + '+i*' + GRToStrE(rb));
      Result.add('-' + GRToStrE(ra) + '-i*' + GRToStrE(rb));
    end
    else
    begin
      Result.add(GRToStrE(ra) + '-i*' + GRToStrE(rb));
      Result.add('-' + GRToStrE(ra) + '+i*' + GRToStrE(rb));
    end;
  except
    Result.clear;
    raise;
  end;
end; //RacineCarree4GC

function Equa2emeDegreGC(a, b, c: tGC): tNRacines;
// a.x² + b.x + c = 0
var
  Delta, zt, co, num, den, r1, r2: tGC;
  rDelta: tNRacines;
begin
  Result := tStringList.create;
  try // b² - 4*a*c :
    Delta := CarreGC(b); // b²
    zt := MulGC(a, c); // a*c
    co := StrToGC('4');
    zt := MulGC(co, zt); // 4*a*c
    Delta := DifGC(Delta, zt);

    if EgalZeroGC(a) and (not EgalZeroGC(b)) then // équa du 1er degré
    begin // racine - c/b;
      zt := DivGC(c, b);
      zt := MulGC(zt, GC_1);
      Result.add(GCToStrE(zt));
      EXIT;
    end;

    if AbsInfAEpsilonGC(Delta) then
      // Delta = 0 ou < Epsilon : racine double -b/(2*a)
    begin
      r1 := MulGC(b, GC_1);
      r1 := DivGC(r1, GC2);
      r1 := DivGC(r1, a);
      Result.add(GCToStrE(r1));
    end
    else // Delta<>0 : 2 racines (-b +- sqrt(Delta))/(2*a)
    begin
      rDelta := RacineCarree4GC(Delta); // sqrt(Delta)
      zt := StrToGC(rDelta[0]); // sqrt(Delta)
      den := MulGC(GC2, a); // (2*a)

      num := DifGC(zt, b); // -b + sqrt(Delta)
      r1 := DivGC(num, den); // 1ère racine
      Result.add(GCToStrE(r1)); // 1ère racine

      zt := MulGC(zt, GC_1); // -sqrt(Delta)
      num := DifGC(zt, b); // -b - sqrt(Delta)
      r2 := DivGC(num, den); // 2ème racine
      Result.add(GCToStrE(r2));
    end;
  except
    Result.clear;
    raise;
  end;
end; // Equa2emeDegreGC

function CompAbsIntGC(const Z: tGC; Int: int64): shortint;
//        Renvoie 0 si Z est entier et Abs(Z) = Abs(Int) sinon renvoie -1
begin
  try
    if AbsGREgaux(Z.a, Int64ToGR(Int)) and GRNul(Z.b) then
      Result := 0
    else
      Result := -1;
  except
    raise;
  end;
end;

function EgalAIntGC(const Z: tGC; Int: Int64): boolean;
//        Renvoie True si Z = Int
begin
  try
    Result := False;
    if (Z.b.sv <> #0) then
      EXIT;
    Result := GRToInt64(Z.a) = Int;
  except
    raise;
  end;
end;

function EgalZeroGC(const Z: tGC): boolean;
//        Renvoie True si Z = 0
begin
  if ((Z.a.sv = #0) and (Z.b.sv = #0)) then
    Result := true
  else
    Result := false;
end;

function AbsInfOuEgalALimiteGC(Z: tGC; Limite: tGR): boolean;
//        Renvoie True si les valeurs absolues des deux composantes de Z sont
//        inférieures ou égales à celle de Limite
var
  cmpa, cmpb: shortint;
begin
  try
    cmpa := CompAbsGR(Z.a, Limite);
    cmpb := CompAbsGR(Z.b, Limite);
    result := False;
    if ((cmpa < 0) or (cmpa = 0))
      and ((cmpb < 0) or (cmpb = 0)) then
      result := True;
  except
    raise;
  end;
end;

function AbsInfAEpsilonGC(const Z: tGC): boolean;
//<-      Renvoie True si les valeurs absolues des deux composantes de Z sont
//        inférieures à celle de GREpsilon qui dépend de nbCsGr (NC)
begin
  try
    Result := AbsGRInfAEpsilon(Z.a) and AbsGRInfAEpsilon(Z.b)
  except
    raise;
  end;
end;

function CompAbsGC(Z1, Z2: tGC): shortint;
//        Compare les carrés des modules de Z1 et de Z2
//        - si égaux alors Result = 0
//        - si celui de Z1 inférieur alors Result <0, si supérieur alors Result >0
var
  ro1k, ro2k: tGR;
begin
  try
    ro1k := RoCarreeGR(Z1);
    ro2k := RoCarreeGR(Z2);
    Result := CompAbsGR(ro1k, ro2k)
  except
    raise;
  end;
end;

procedure QuickSortGC(var AR: array of tGC);
  // tri ordre croissant pour le tracé des courbes

  procedure QuickSortR(var AR: array of tGC; lDeb, lFin: Integer);

    procedure PermuterLignes(li1, li2: Integer);
    var
      s: tGC;
    begin
      s := AR[li1];
      AR[li1] := AR[li2];
      AR[li2] := s;
    end;

    function Z1infZ2(z1, z2: tGC): boolean;
    var
      cmpa, cmpb: shortint;
    begin
      Result := false;
      //si (z1.a<z2.a) alors Result:=true :
      cmpa := CompAlgGR(z1.a, z2.a);
      if cmpa < 0 then
      begin
        Result := true;
        EXIT;
      end;

      //si (z1.a<=z2.a) et (z1.b<z2.b) alors Result:=true :
      cmpb := CompAlgGR(z1.b, z2.b);
      if ((cmpa < 0) or (cmpa = 0)) and (cmpb < 0) then
      begin
        Result := true;
        EXIT;
      end;

      //si (z1.b<=z2.b) et (z1.a<z2.a) alors Result:=true sinon Result:=false :
      if ((cmpb < 0) or (cmpb = 0)) and (cmpa < 0) then
        Result := true;
    end;

  var
    Lo, Hi, Mi: Integer;
  begin
    Lo := lDeb;
    Hi := lFin;
    Mi := (lDeb + lFin) div 2;
    repeat while Z1infZ2(AR[Lo], AR[Mi]) do
        Inc(Lo);
      while Z1infZ2(AR[Mi], AR[Hi]) do
        Dec(Hi);
      if Lo <= Hi then
      begin
        PermuterLignes(Lo, Hi);
        if Mi = Lo then
          Mi := Hi
        else if Mi = Hi then
          Mi := Lo;
        Inc(Lo);
        Dec(Hi);
      end;
    until (Lo > Hi) or Echapper;
    if Hi > lDeb then
      QuickSortR(AR, lDeb, Hi);
    if Lo < lFin then
      QuickSortR(AR, Lo, lFin);
  end;
begin
  QuickSortR(AR, 1, Equa.Degre);
end; // QuickSortGC2

initialization

  GC0 := StrToGC('0');
  GC1 := StrToGC('1');
  GC2 := StrToGC('2');
  GC_1 := StrToGC('-1');
  GC_2 := StrToGC('-2');

end. //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

