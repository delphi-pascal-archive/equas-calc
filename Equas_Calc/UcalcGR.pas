unit UcalcGR;

////////////////////////////////////////////////////////////////////////////////
//                    Cette unité gère la calculette
//                         Code EXPERIMENTAL
////////////////////////////////////////////////////////////////////////////////

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, uFun2, uFlotte2, ExtCtrls, Math, Buttons, clipBrd, ShellApi,
  ComCtrls, Menus, UnitGC, UnitGR, uConstPrecalculees;

type
  TfrmCalcGR = class(TForm)
    Panel1: TPanel;
    plMis: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    ednbCSGR: TEdit;
    Panel3: TPanel;
    Factorielle: TSpeedButton;
    Arrangement: TSpeedButton;
    Combinaison: TSpeedButton;
    ConvertThetaRXY: TSpeedButton;
    RacineNieme: TSpeedButton;
    Division: TSpeedButton;
    Soustraction: TSpeedButton;
    Addition: TSpeedButton;
    Multiplication: TSpeedButton;
    Exponentielle: TSpeedButton;
    LogNeperien: TSpeedButton;
    LogBase10: TSpeedButton;
    Panel4: TPanel;
    Sinus: TSpeedButton;
    Tangente: TSpeedButton;
    ArcCosinus: TSpeedButton;
    ArcSinus: TSpeedButton;
    ArcTangente: TSpeedButton;
    CosHyperbolique: TSpeedButton;
    SinHyperbolique: TSpeedButton;
    TanHyperbolique: TSpeedButton;
    ArcTangente2: TSpeedButton;
    Pi: TSpeedButton;
    RacineCarree: TSpeedButton;
    Inverse: TSpeedButton;
    Puissance: TSpeedButton;
    Panel5: TPanel;
    bCL: TSpeedButton;
    bSTO: TSpeedButton;
    Affiche: TRichEdit;
    rbDeg: TRadioButton;
    rbRad: TRadioButton;
    DixPuissanceX: TSpeedButton;
    bEntrer: TSpeedButton;
    labNbCar: TLabel;
    Cosinus: TSpeedButton;
    bMemoireDerouler: TSpeedButton;
    labMem: TLabel;
    ConversionRadDeg: TSpeedButton;
    Sept: TSpeedButton;
    Huit: TSpeedButton;
    Neuf: TSpeedButton;
    Quatre: TSpeedButton;
    Cinq: TSpeedButton;
    Six: TSpeedButton;
    Trois: TSpeedButton;
    Deux: TSpeedButton;
    Un: TSpeedButton;
    Zero: TSpeedButton;
    Point: TSpeedButton;
    bChangerSigne: TSpeedButton;
    ArgCh: TSpeedButton;
    ArgSh: TSpeedButton;
    ArgTh: TSpeedButton;
    bCopier: TSpeedButton;
    bColler: TSpeedButton;
    bCouperCopierColler: TSpeedButton;
    bSwapXY: TSpeedButton;
    bRCL: TSpeedButton;
    bImaginaire: TSpeedButton;
    bIMulPar: TSpeedButton;
    bPlus: TSpeedButton;
    bMoins: TSpeedButton;
    bE: TSpeedButton;
    bVisu: TSpeedButton;
    bAide: TSpeedButton;
    bInfoAccueil: TSpeedButton;

    procedure unClick(Sender: TObject);
    procedure bChangerSigneClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure ednbCSGRChange(Sender: TObject);
    procedure PiMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bEntrerClick(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure AfficheChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bMemoireDeroulerMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure ednbCSGRKeyPress(Sender: TObject; var Key: Char);
    procedure bCouperCopierCollerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AfficheMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bSwapXYClick(Sender: TObject);
    procedure bCLMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bSTOClick(Sender: TObject);
    procedure bRCLClick(Sender: TObject);
    procedure AfficheKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bVisuClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bAideClick(Sender: TObject);
    procedure bInfoAccueilClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmCalcGR: TfrmCalcGR;

implementation

{$R *.DFM}

uses NewGCent; // Provisoire

const
  MsgDureeCourte = 10; // 10 secondes d'affichage pour infos courtes
  MsgDureeLongue = 30;
    // 30 secondes d'affichage pour messages d'erreur par exemple

var
  RegistreX, RegistreY, RegistreZ, RegistreT, RegistreS, Constante: tGC;
  Efface, Enter: boolean;

var
  MsgAccueil: string;

procedure MettreEnGrasEtCoul(Red: TRichEdit; S: string; Coul: tColor);
var
  st, sl: integer;
begin
  with Red do
  begin
    st := pos(S, text);
    sl := length(S);
    if st > 0 then
    begin
      SelStart := st - 1;
      SelLength := sl;
      SelAttributes.style := [fsBold];
      SelAttributes.color := Coul;
      SelStart := 0;
      SelLength := 0;
    end;
  end;
end;

procedure Enluminures; // Affiche les 'E' les 'i' les '.' et les '*' en Marron
var
  i, len: integer;
begin
  with frmCalcGR.Affiche do
  begin
    if pos('...', Text) = 0 then
    begin
      len := length(Text);
      for i := 1 to len do
      begin
        SelStart := i - 1;
        SelLength := 1;
        if (Text[i] = 'E') or (Text[i] = 'i') or (Text[i] = '*')
          or (Text[i] = '.') then
        begin
          SelAttributes.Color := clMaroon;
          SelAttributes.style := [fsBold];
        end
        else
        begin
          SelAttributes.Color := clBlack;
          SelAttributes.style := [];
        end;
      end;
      SelStart := 0;
    end;
  end;
end;

procedure TfrmCalcGR.FormCreate(Sender: TObject);
begin
  Efface := True;
  Enter := False;
  RegistreX := GC0;
  RegistreY := GC0;
  RegistreZ := GC0;
  RegistreT := GC0;
  Constante := GC0;
  bCouperCopierColler.Hint := 'Couper vers presse-papier' + cls
    + '(si rien n''est sélectionné' + cls
    + ' alors on coupe le tout)';
  bCopier.Hint := 'Copier vers presse-papier' + cls
    + '(si rien n''est sélectionné' + cls
    + ' alors on copie le tout)';
  bColler.Hint := 'Coller depuis presse-papier';
  bColler.Enabled := Clipboard.AsText <> '';
  //---------------
  bCL.Hint := 'Effacer' + cls
    + '- Affichage : click-souris-Gauche' + cls
    + '- Mémoires  : click-souris-Droite';
  bMemoireDerouler.Hint := 'Dérouler mémoires : ' + cls
    + '- vers le bas  : click-souris-Gauche' + cls
    + '- vers le haut : click-souris-Droite';
  ConvertThetaRXY.Hint := 'Conversion coordonnées rectangulaires <-> polaires' +
    cls
    + '- Rectangulaires -> Polaires : click-souris-Gauche' + cls
    + '- Polaires -> Rectangulaires : click-souris-Droite' + cls
    + '- Argument et module de X   : click-souris + Touche Alt';
  MsgAccueil := Affiche.Text;
  Enluminures;
  MettreEnGrasEtCoul(Affiche, 'x', clBlue);
  MettreEnGrasEtCoul(Affiche, 'y', clBlue);
  MettreEnGrasEtCoul(Affiche, 'notation polonaise inverse', clBlue);
  MettreEnGrasEtCoul(Affiche, 'i*', clBlue);
  if FileExists(RepAppli + 'Aide_Equas_Calc8.chm') then
    bAide.enabled := True
  else
  begin
    bAide.Hint := 'Fichier d''Aide non trouvé';
    bAide.enabled := False;
  end;
end;

procedure TfrmCalcGR.FormResize(Sender: TObject);
var
  ch: integer;
begin
  ch := clientHeight;
  with Affiche do
  begin
    height := ch - panel1.height - 2;
  end;
end;

procedure TfrmCalcGR.ednbCSGRKeyPress(Sender: TObject; var Key: Char);
begin
  FiltreNumeriqueEntier(Sender, Key);
end;

procedure TfrmCalcGR.ednbCSGRChange(Sender: TObject);
begin
  ednbCSGR.Font.Color := clRed;
  if ednbCSGR.text = '' then
  begin
    AFlotte('Entrer une valeur d''au moins 20', MsgDureeLongue, clYellow);
    ednbCSGR.SetFocus;
    EXIT;
  end;
  nbCSGR := StrToInt(ednbCSGR.text);
  if nbCsGr < 20 then
  begin
    AFlotte('Entrer une valeur d''au moins 20', MsgDureeLongue, clYellow);
    ednbCSGR.SetFocus;
    EXIT;
  end;
  if nbCsGr < 20 then
  begin
    nbCsGr := 20;
    ednbCSGR.text := '20';
  end;
  ednbCSGR.Font.Color := clGreen;
  cacheFlotte1;
  ActuLgConstantes;
end;

procedure RemonterPile;
begin
  RegistreT := RegistreZ;
  RegistreZ := RegistreY;
  RegistreY := RegistreX;
end;

procedure DescendrePile;
begin
  RegistreY := RegistreZ;
  RegistreZ := RegistreT;
end;

const
  CharAdmis = ['0'..'9', '-', '+', '.', 'i', 'e', 'E', '*'];

procedure TfrmCalcGR.bEntrerClick(Sender: TObject);
var
  s: string;
begin
  s := TrimCharToutSauf(Affiche.Text, CharAdmis);
  if pos('infini', Affiche.text) > 0 then
    EXIT;
  if pos('Tentative', Affiche.text) > 0 then
    EXIT;
  RegistreX := StrToGC(s);
  RemonterPile;
  Efface := True;
  Enter := True;
end;

procedure TfrmCalcGR.unClick(Sender: TObject);
  // Pavé numérique de boutons sur fiche
var
  Digit: char;
  v: string;
begin
  Digit := #13;
  plMis.caption := '';
  if Sender is TSpeedButton then
    Digit := (Sender as TSpeedButton).caption[1];
  if Enter = False then
  begin
    if Efface = False then
      Affiche.Text := Affiche.Text + Digit;
    if Efface = True then
    begin
      RemonterPile;
      Affiche.Text := Digit;
    end;
  end
  else
    Affiche.Text := Digit;
  Affiche.SelStart := length(Affiche.text);
  Enter := False;
  Efface := False;
  if not (Digit in ['E', '-', '+', '*', '.']) then
  begin
    v := Affiche.Text;
    v := SupprCharS(v, '.'); //<- pour éviter plantage si on saisit 0.0000
    if v <> '' then
      RegistreX := StrToGC(Affiche.Text);
  end;
end;

procedure TfrmCalcGR.FormKeyPress(Sender: TObject; var Key: Char);
begin // Pouvoir utiliser le clavier aussi bien que les boutons
  if pos('...', Affiche.text) > 0 then
    Affiche.Text := ''; // Suppression du texte d'accueil
  if key = 'e' then
    key := 'E';
  if not (key in ['0'..'9', 'E', 'i', '+', '-', '*', DecimalSeparator,
    Chr(VK_BACK)]) then
  begin
    key := #0;
    EXIT;
  end; // suite effectuée dans AfficheKeyUp
end;

procedure TfrmCalcGR.AfficheKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v: string;
begin
  plMis.caption := '';
  if (Enter = False) and Efface then
    RemonterPile;
  Enter := False;
  Efface := False;
  if (Key in [VK_NUMPAD0..VK_NUMPAD9, VK_SEPARATOR, VK_BACK, Ord('i'), Ord('I')])
    then
  begin
    v := Affiche.Text;
    v := SupprCharS(v, '.');
    if v <> '' then
      RegistreX := StrToGC(Affiche.Text);
  end;
  // else on attend la fin de la saisie pour sauver dans le registre
  // puisque la sisie s'achève soit avec un chiffre soit avec un 'i'
end;

procedure TfrmCalcGR.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//        Pour faire ré-apparaître une fiche évanescente avec Ctrl + M
begin
  if (ssCtrl in shift) and (Key = 77) then {touche M}
    frmFlotte2.show;
end;

procedure TfrmCalcGR.bChangerSigneClick(Sender: TObject);
begin
  if Affiche.text = '' then
    EXIT;
  RegistreX := StrToGC(Affiche.text);
  if RegistreX.a.sv <> #0 then
    RegistreX.a := ChangeSigneGR(RegistreX.a);
  if RegistreX.b.sv <> #0 then
    RegistreX.b := ChangeSigneGR(RegistreX.b);
  Affiche.text := GCToStrE(RegistreX);
  Affiche.SetFocus;
end;

procedure TfrmCalcGR.bCLMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if button = mbLeft then // Effacer X
  begin
    RegistreX := GC0;
    Affiche.text := '0';
    Efface := True;
  end
  else // Effacer mémoires
  begin
    RegistreT := GC0;
    RegistreZ := GC0;
    RegistreY := GC0;
    RegistreX := GC0;
    Efface := True;
  end;
  Affiche.SetFocus;
end;

procedure TfrmCalcGR.Panel1DblClick(Sender: TObject);
//        RAZ Mémoire + Affichage + Presse-papier
begin
  Affiche.text := '';
  RegistreT := GC0;
  RegistreZ := GC0;
  RegistreY := GC0;
  RegistreX := GC0;
  Efface := True;
  EmptyClipboard;
  bColler.Enabled := false;
  Affiche.SetFocus;
  plMis.caption := '';
  cacheFlotte1;
end;

procedure TfrmCalcGR.bMemoireDeroulerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if button = mbLeft then // Roll down
  begin
    RegistreS := RegistreX;
    RegistreX := RegistreY;
    RegistreY := RegistreZ;
    RegistreZ := RegistreT;
    RegistreT := RegistreS;
  end;
  if button = mbRight then // Roll up
  begin
    RegistreS := RegistreT;
    RegistreT := RegistreZ;
    RegistreZ := RegistreY;
    RegistreY := RegistreX;
    RegistreX := RegistreS;
  end;
  Efface := True;
  Affiche.text := GCToStrE(RegistreX);
end;

procedure Trace(s: string);
begin
  frmCalcGR.Affiche.lines.Add(s);
  frmCalcGR.Affiche.upDate;
end;

procedure TfrmCalcGR.PiMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
label
  Saut;
var
  oper, sPi, info, sX: string;
  rac: tNRacines;
  eIndiceExpo: Extended;
  Base, Expo, GRX2, GRY2, Si, Co: tGR;
  XComplexe, YComplexe: boolean;
  RX, RY: tGC;
  Chrono: oChrono;
begin
  Sablier;
  nbToursGR := 0;
  oper := (Sender as tSpeedButton).name;
  if (ssCtrl in shift) then // Infos :
  begin
    if (oper = 'Addition')
      or (oper = 'Soustraction')
      or (oper = 'Multiplication')
      or (oper = 'Division')
      or (oper = 'Inverse') then
    begin
      info := oper + cls
        + '- pour entiers, réels, ou complexes' + cls
        + '- format a + i*b si nombre complexe' + cls
        + '- les nombres peuvent être entrés au format' + cls
        + '  scientifique ex: 22E-10 + i*3E2';
    end
    else if (oper = 'Puissance') then
    begin
      info := 'Puissance' + cls
        + '- Elève Y à la puissance X' + cls
        + '- Y : entier, réel, ou complexe' + cls
        + '- Y : format a + i*b si nombre complexe' + cls
        + '- Exposant X : entier ou réel' + cls
        + '  si nombre complexe';
    end
    else if oper = 'Exponentielle' then
    begin
      info := 'Exponentielle' + cls
        + '- Elève ''e'' = 2.7182818... à la puissance X' + cls
        + '- avec X réel positif ou négatif';
    end
    else if oper = 'DixPuissanceX' then
    begin
      info := 'DixPuissance X' + cls
        + '- Elève 10 à la puissance X' + cls
        + '- avec X réel positif ou négatif';
    end
    else if oper = 'Factorielle' then
    begin
      info := 'Factorielle X' + cls
        + '- Renvoie le produit des nombres de 1 à X' + cls
        + '  (nombre de permutations de X éléments distincts)' + cls
        + '- Limité aux nombres entiers';
    end
    else if oper = 'Combinaison' then
    begin
      info := 'Combinaisons ' + cls
        + '- Renvoie le nombre de combinaisons sans répétition' + cls
        + '  de X éléments distincts pris Y à Y' + cls
        + '- Limité aux nombres entiers et X >= Y';
    end
    else if oper = 'Arrangement' then
    begin
      info := 'Arrangements ' + cls
        + '- Renvoie le nombre d''arrangements sans répétition' + cls
        + '  de X éléments distincts pris Y à Y' + cls
        + '- Limité aux nombres entiers et X >= Y';
    end
    else if oper = 'RacineCarree' then
    begin
      info := 'Racine Carree ' + cls
        + '- Renvoie la racine carrée de X' + cls
        + '- X : entier, réel, ou complexe';
    end
    else if oper = 'RacineNieme' then
    begin
      info := 'Racine X-ième ' + cls
        + '- Renvoie la racine X-ième de Y' + cls
        + '- Y : entier, réel, ou complexe' + cls
        + '- X : entier ou réel positif ou négatif';
    end
    else if oper = 'Pi' then
    begin
      info := 'Pi' + cls
        + '- Renvoie Pi = 3.141592653... avec NC chiffres' + cls
        + '  sigificatifs si NC <= 2000';
    end
    else if oper = 'ConversionRadDeg' then
    begin
      info := 'Rad <--> Deg' + cls
        + 'Convertit la valeur affichée en radians ou' + cls
        + 'en degrés dans le sens inverse';
    end
    else if oper = 'LogNeperien' then
    begin
      info := 'LN(x)' + cls + 'Renvoie le Log Népérien de X' + cls
        + '- X : entier ou réel > 0';
    end
    else if oper = 'LogBase10' then
    begin
      info := 'log(x)' + cls + 'Renvoie le Log Base 10 de X' + cls
        + '- X : entier ou réel > 0';
    end
    else if oper = 'DixPuissanceX' then
    begin
      info := 'DixPuissanceX' + cls + 'Renvoie 10 à la puissance X' + cls
        + '- X : entier ou réel positif ou négatif';
    end
    else if oper = 'EffacerAffichage1' then
      info := 'ea' + cls + 'Efface uniquement la lucarne d''affichage de X'
    else if oper = 'MemoireEffacer1' then
      info := 'me' + cls + 'Efface uniquement le contenu de la mémoire (Y)'
    else if oper = 'Cosinus' then
    begin
      info := 'Cosinus' + cls + 'Renvoie le Cosinus(X)' + cls
        + '- X : entier ou réel)';
    end
    else if oper = 'Sinus' then
    begin
      info := 'Sinus' + cls + 'Renvoie le Sinus(X)' + cls
        + '- X : entier ou réel)';
    end
    else if oper = 'Tangente' then
    begin
      info := 'Tangente' + cls + 'Renvoie tangente(X)' + cls
        + '- X : entier ou réel)';
    end
    else if oper = 'ArcCosinus' then
    begin
      info := 'ArcCosinus' + cls + 'Renvoie ArcCosinus(X)' + cls
        + 'entre +Pi/2 et -Pi/2' + cls
        + '- |X|<=1)';
    end
    else if oper = 'ArcSinus' then
    begin
      info := 'ArcSinus' + cls + 'Renvoie ArcSinus(X)' + cls
        + 'entre +Pi/2 et -Pi/2' + cls
        + '- |X|<=1)';
    end
    else if oper = 'ArcTangente' then
    begin
      info := 'ArcTangente' + cls + 'Renvoie ArcTangente(X)' + cls
        + 'entre +Pi/2 et -Pi/2' + cls
        + '- X : entier ou réel';
    end
    else if oper = 'ArcTangente2' then
    begin
      info := 'ATan(Y/X)' + cls + 'Renvoie ArcTangente(Y/X)' + cls
        + 'entre +Pi et -Pi' + cls
        + '- Y et X : entiers ou réels';
    end
    else if oper = 'CosHyperbolique' then
    begin
      info := 'CosH' + cls + 'Renvoie le Cosinus-Hyperbolique(X)' + cls
        + '- X : entier ou réel';
    end
    else if oper = 'SinHyperbolique' then
    begin
      info := 'SinH' + cls + 'Renvoie le Sinus-Hyperbolique(X)' + cls
        + '- X : entier ou réel';
    end
    else if oper = 'TanHyperbolique' then
    begin
      info := 'TanH' + cls + 'Renvoie la Tangente-Hyperbolique(X)' + cls
        + '- X : entier ou réel';
    end
    else if oper = 'ArgCh' then
    begin
      info := 'ArgCh' + cls + 'Renvoie l''Argument Cosinus-Hyperbolique(X)' + cls
        + '- X > 1';
    end
    else if oper = 'ArgSh' then
    begin
      info := 'ArgSh' + cls + 'Renvoie l''Argument Sinus-Hyperbolique(X)' + cls
        + '- X : entier ou réel';
    end
    else if oper = 'ArgTh' then
    begin
      info := 'ArgTh' + cls + 'Renvoie l''Argument Tangente-Hyperbolique(X)' +
        cls
        + '- |X| < 1';
    end
    else if oper = 'ConvertThetaRXY' then
    begin
      info := 'Conversion de coordonnées rectangulaires <-> polaires' + cls
        + '- Renvoie X,Y si les données entrées sont Theta et r et reciproquement' +
          cls
        + '- Si X est un nombre complexe : Renvoie l''Argument et le module de X' +
          cls
        + '  lorsque la touche Alt est appuyée lors du click sur le bouton';
    end
    else
      sms(oper + ' Infos A achever');
    Sablier;
    LRFlotte(info, 30, $00BBCCD4, clWhite);
    EXIT;
  end;
  // Execution
  plMis.caption := oper + ' ...';
  plMis.Update;
  Chrono.top;
  // Récup données :
  sX := Affiche.Text;
  if pos('...', sX) > 0 then
    Affiche.Text := '0'; // Suppression du texte d'accueil
  if pos('infini', sX) > 0 then
    Affiche.Text := '0';
  NettSaisieGC(sX); // Nettoyage saisie
  if sX = '' then
    Affiche.Text := '0'
  else
    Affiche.Text := sX;
  Affiche.Update;

  XComplexe := (RegistreX.b.sv <> #0);
  YComplexe := (RegistreY.b.sv <> #0);
  try
    //A) Nombres pouvant être complexes :
    if oper = 'Addition' then
    begin
      AFlotte('AddGC', MsgDureeCourte, clWhite);
      RegistreX := AddGC(RegistreY, RegistreX);
      DescendrePile;
      Affiche.text := GCToStrE(RegistreX);
      goto Saut;
    end
    else if oper = 'Soustraction' then
    begin
      AFlotte('DifGC', MsgDureeCourte, clWhite);
      RegistreX := DifGC(RegistreY, RegistreX);
      DescendrePile;
      Affiche.text := GCToStrE(RegistreX);
      goto Saut;
    end
    else if oper = 'Multiplication' then
    begin
      AFlotte('MulGC', MsgDureeCourte, clWhite);
      RegistreX := MulGC(RegistreY, RegistreX);
      DescendrePile;
      Affiche.text := GCToStrE(RegistreX);
      goto Saut;
    end
    else if oper = 'Division' then
    begin
      if EgalZeroGC(RegistreX) then
      begin
        Affiche.text := 'Tentative de division par zéro';
        goto Saut;
      end;
      AFlotte('DivGC', MsgDureeCourte, clWhite);
      RegistreX := DivGC(RegistreY, RegistreX);
      DescendrePile;
      Affiche.text := GCToStrE(RegistreX);
      goto Saut;
    end
    else if oper = 'Inverse' then
    begin
      if EgalZeroGC(RegistreX) then
      begin
        Affiche.text := 'Tentative de division par zéro';
        goto Saut;
      end;
      AFlotte('Inverse', MsgDureeCourte, clWhite);
      RegistreX := DivGC(GC1, RegistreX);
      Affiche.text := GCToStrE(RegistreX);
      goto Saut;
    end
    else if oper = 'RacineCarree' then
    begin
      if (not XComplexe) and (RegistreX.a.Signe = '+') then
        // X Non complexe et positif
      begin
        AFlotte('SqrtGR 2ième racine = - Racine affichée', MsgDureeCourte,
          clWhite);
        RegistreX.a := SqrtGR(RegistreX.a);
        RegistreX.b := GR0;
        Affiche.text := GCToStrE(RegistreX);
        goto Saut;
      end
      else // X Complexe : on renvoie seulement la 1ière racine :
      begin
        AFlotte('RacineCarree4GC : 2ième racine = - Racine affichée',
          MsgDureeCourte, clWhite);
        rac := RacineCarree4GC(RegistreX);
        RegistreX := StrToGC(rac[0]);
        Affiche.text := GCToStrE(RegistreX);
        rac.free;
        goto Saut;
      end;
    end
    else if oper = 'Puissance' then
    begin
      if (not XComplexe) and (not YComplexe) then // Y et X réels
      begin
        AFlotte('PowerGR', MsgDureeCourte, clWhite);
        Base := RegistreY.a;
        Expo := RegistreX.a;
        RegistreX.a := PowerGR(Base, Expo);
        RegistreX.b := GR0;
        Affiche.text := GCToStrE(RegistreX);
        goto Saut;
      end
      else
      begin
        if XComplexe then
        begin
          AFlotte('Puissance avec Exposant X complexe : Non prévu',
            MsgDureeLongue, clYellow);
          Sablier;
          EXIT;
        end;
        AFlotte('PowerExtGC avec formule de Moivre', MsgDureeCourte, clWhite);
        try
          eIndiceExpo := StrToFloat(Affiche.text)
        except
          on EConvertError do
          begin
            AFlotte('Exposant X hors limites pour Puissance',
              MsgDureeLongue, clYellow);
            Sablier;
            EXIT;
          end;
        end;
        RegistreX := PowerExtGC(RegistreY, eIndiceExpo);
        Affiche.text := GCToStrE(RegistreX);
        goto Saut;
      end;
    end
    else if oper = 'RacineNieme' then //On n'affiche que la première Racine
    begin
      Base := RegistreY.a;
      Expo := RegistreX.a;
      if ((not YComplexe) and (not XComplexe)) // Cas racines réelles
      and (((Base.Signe = '-') and (GRPair(Expo) = Impair))
        or (Base.Signe = '+')) then
      begin
        AFlotte('RacNiemeGR', MsgDureeCourte, clWhite);
        Base := RegistreY.a;
        Expo := RegistreX.a;
        RegistreX.a := RacNiemeGR(Base, Expo);
        RegistreX.b := GR0;
        Affiche.text := GCToStrE(RegistreX);
        goto Saut;
      end
      else // Racines complexes
      begin
        if XComplexe then // Indice complexe
        begin
          AFlotte('Pas de Racine Xième si X complexe', MsgDureeLongue,
            clYellow);
          Sablier;
          EXIT;
        end;
        try
          eIndiceExpo := StrToFloat(Affiche.text)
        except
          on EConvertError do
          begin
            AFlotte('Indice X hors limites pour Racine',
              MsgDureeLongue, clYellow);
            Sablier;
            EXIT;
          end;
        end;
        AFlotte('SLRacinesNiemesGC : avec formule de Moivre',
          MsgDureeCourte, clWhite);
        // 1ière racine :
        rac := SLRacinesNiemesGC(RegistreY, eIndiceExpo, True);
        RegistreX := StrToGC(rac[0]);
        Affiche.text := GCToStrE(RegistreX);
        rac.free;
        goto Saut;
      end;
    end
    else if oper = 'ConvertThetaRXY' then
    begin
      RX := RegistreX;
      RY := RegistreY;

      if rbDeg.checked then
        info := 'Deg'
      else
        info := 'Rad';

      if ssAlt in shift then // Argument et module de X pour tout X :
      begin
        RegistreX.a := RoGR(RX);
        RegistreX.b := GR0;
        if rbDeg.checked then
          RegistreY.a := ThetaDegGR(RX)
        else
          RegistreY.a := ThetaRadGR(RX);
        RegistreY.b := GR0;
        LRFlotte('Conversion Complexe -> r,Theta :' + cls
          + '- Module r : affiché en X' + cls
          + '- Argument Theta : renvoyé en Y (en ' + info + ')',
          MsgDureeCourte, clBeige, clWhite);
        Affiche.text := GCToStrE(RegistreX);
        goto Saut;
      end
      else // Conversions de coordonnées
      begin
        if XComplexe or YComplexe then
        begin
          LRFlotte('Conversions coordonnées X,Y <-> r,Theta :' + cls + cls
            + 'Réservé pour X,Y,r,Theta Non-Complexes',
            MsgDureeLongue, clBeige, clYellow);
          Sablier;
          EXIT;
        end;
        if Button = mbLeft then // Conversion X,Y -> r,Theta
        begin
          GRX2 := CarreGR(RX.a);
          GRY2 := CarreGR(RY.a);
          RegistreX.a := AddGR(GRX2, GRY2);
          RegistreX.a := SqrtGR(RegistreX.a); //= r
          RegistreY.a := ArcTan2DLGR(RY.a, RX.a); //=Theta Radians
          if rbDeg.checked then
          begin
            RegistreY.a := RadToDegGR(RegistreY.a);
            info := 'Deg';
          end
          else
            info := 'Rad';
          Affiche.text := GCToStrE(RegistreX);
          LRFlotte('Conversion X,Y -> r,Theta :' + cls
            + '- Coordonnée radiale : affichée en X' + cls
            + '- Coordonnée angulaire : renvoyée en Y (en ' + info + ')',
            MsgDureeCourte, clBeige, clWhite);
          goto Saut;
        end
        else if Button = mbRight then // Conversion r,Theta -> X,Y
        begin
          if rbRad.checked then
            RegistreY.a := RadToDegGR(RegistreY.a);
          SinCosDLGR(RegistreY.a, Si, Co);
          RegistreX.a := MulGR(RX.a, Co); //x = r.cos
          RegistreY.a := MulGR(RX.a, Si); //y = r.sin
          Affiche.text := GCToStrE(RegistreX);
          LRFlotte('Conversion r,Theta -> X,Y :' + cls
            + '- Coordonnée X : affichée en X' + cls
            + '- Coordonnée Y : renvoyée en Y',
            MsgDureeCourte, clBeige, clWhite);
          goto Saut;
        end;
      end;
    end
    else
      {//B)  Suite non prévue pour nombres complexes :} if oper = 'Exponentielle'
        then
      begin
        if XComplexe then
        begin
          AFlotte('Pas prévu d''Exponentielle pour une donnée complexe',
            MsgDureeLongue, clYellow);
          Sablier;
          EXIT;
        end;
        AFlotte('ExponentielleGR', MsgDureeCourte, clWhite);
        RegistreX.a := ExponentielleGR(RegistreX.a);
        RegistreX.b := GR0;
        Affiche.text := GCToStrE(RegistreX); //< Affichage sans arrondi
        goto Saut;
      end
      else if oper = 'LogNeperien' then
      begin
        if XComplexe then
        begin
          AFlotte('Pas prévu de Log Nep pour une donnée complexe',
            MsgDureeLongue, clYellow);
          Sablier;
          EXIT;
        end;
        AFlotte('LogNepGR', MsgDureeCourte, clWhite);
        if trim(Affiche.Text) = '10' then
          RegistreX.a := GRLn10
        else
          RegistreX.a := LogNepGR(RegistreX.a);
        RegistreX.b := GR0;
        Affiche.text := GCToStrE(RegistreX); //< Affichage sans arrondi
        goto Saut;
      end
      else if oper = 'LogBase10' then
      begin
        if XComplexe then
        begin
          AFlotte('Pas de Log Base 10 pour une valeur complexe',
            MsgDureeLongue, clYellow);
          Sablier;
          EXIT;
        end;
        AFlotte('LogBase10GR', 10, clWhite);
        RegistreX.a := LogBase10GR(RegistreX.a);
        RegistreX.b := GR0;
        Affiche.text := GCToStrE(RegistreX); //< Affichage sans arrondi
        goto Saut;
      end
      else if oper = 'DixPuissanceX' then
      begin
        if XComplexe then
        begin
          AFlotte('Pas de 10 puissance X pour X complexe',
            MsgDureeLongue, clYellow);
          Sablier;
          EXIT;
        end;
        AFlotte('DixPuissXGR', 10, clWhite);
        RegistreX.a := DixPuissXGR(RegistreX.a);
        RegistreX.b := GR0;
        Affiche.text := GCToStrE(RegistreX);
        goto Saut;
      end
      else
        {//B) Pour nombres non complexes :} if oper = 'Factorielle' then
        begin
          if XComplexe or (RegistreX.a.Expo < 0) then
          begin
            AFlotte('Factorielle : réservé aux nombres entiers',
              MsgDureeLongue, clYellow);
            Sablier;
            EXIT;
          end;
          AFlotte('FactorielleGR : (Touche Echap si trop lent)',
            MsgDureeCourte, clWhite);
          RegistreX.a := FactorielleGR(RegistreX.a);
          RegistreX.b := GR0;
          Affiche.text := GCToStrE(RegistreX);
          goto Saut;
        end
        else if oper = 'Combinaison' then
        begin
          if XComplexe or YComplexe or (RegistreX.a.Expo < 0) or
            (RegistreY.a.Expo < 0) then
          begin
            AFlotte('Combinaison : réservé aux nombres entiers',
              MsgDureeLongue, clYellow);
            Sablier;
            EXIT;
          end;
          if (CompAbsGR(RegistreX.a, RegistreY.a) < 0) then
          begin
            AFlotte('Pour Combinaison de X pris Y à Y : X doit être >= Y',
              MsgDureeLongue, clYellow);
            Sablier;
            EXIT;
          end;
          AFlotte('CombinaisonsGR', MsgDureeCourte, clWhite);
          RegistreX.a := CombinaisonsGR(RegistreX.a, RegistreY.a);
          RegistreX.b := GR0;
          Affiche.text := GCToStrE(RegistreX);
          goto Saut;
        end
        else if oper = 'Arrangement' then
        begin
          if XComplexe or YComplexe or (RegistreX.a.Expo < 0) or
            (RegistreY.a.Expo < 0) then
          begin
            AFlotte('Arrangement : réservé aux nombres entiers',
              MsgDureeLongue, clYellow);
            Sablier;
            EXIT;
          end;
          if (CompAbsGR(RegistreX.a, RegistreY.a) < 0) then
          begin
            AFlotte('Pour Arrangement de X pris Y à Y : X doit être >= Y',
              MsgDureeLongue, clYellow);
            Sablier;
            EXIT;
          end;
          AFlotte('ArrangementsGR', MsgDureeCourte, clWhite);
          RegistreX.a := ArrangementsGR(RegistreX.a, RegistreY.a);
          RegistreX.b := GR0;
          Affiche.text := GCToStrE(RegistreX);
          goto Saut;
        end
        else
          {// C : Trigonométrie}
          if oper = 'Pi' then
          begin
            rbRad.checked := true;
            sPi := copy(sPi2000, 1, nbCsGr + 3);
            AFlotte('Pi', MsgDureeCourte, clWhite);
            RegistreX := StrToGC(sPi);
            Affiche.text := sPi;
            goto Saut;
          end
          else if oper = 'ConversionRadDeg' then
          begin
            if XComplexe then
            begin
              AFlotte('Pas de conversion Rad <-> Deg pour une donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            if rbRad.Checked then // x Affiché en radians
            begin
              RegistreX.a := RadToDegGR(RegistreX.a);
              rbDeg.Checked := true;
              AFlotte('Conversion Rad -> Deg', MsgDureeCourte, clWhite);
            end
            else
            begin
              RegistreX.a := DegToRadGR(RegistreX.a);
              rbRad.Checked := true;
              AFlotte('Conversion Deg -> Rad', MsgDureeCourte, clWhite);
            end;
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'Sinus' then
          begin
            if XComplexe then
            begin
              AFlotte('Pas de Sinus pour une donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            if rbRad.Checked {// x Entré en radians} then
              RegistreX.a := RadToDegGR(RegistreX.a);
            RegistreX.b := GR0;
            AFlotte('SinusDLGR', MsgDureeCourte, clWhite);
            RegistreX.a := SinusDLGR(RegistreX.a);
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'Cosinus' then
          begin
            if XComplexe then
            begin
              AFlotte('Pas de Cosinus pour une donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            if rbRad.Checked {// x Entré en radians} then
              RegistreX.a := RadToDegGR(RegistreX.a);
            RegistreX.b := GR0;
            AFlotte('CosinusDLGR', MsgDureeCourte, clWhite);
            RegistreX.a := CosinusDLGR(RegistreX.a);
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'Tangente' then
          begin
            if XComplexe then
            begin
              AFlotte('Pas de Tangente pour une donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            AFlotte('TangenteDLGR', MsgDureeCourte, clWhite);
            if rbRad.Checked {// x Entré en radians} then
              RegistreX.a := RadToDegGR(RegistreX.a);
            RegistreX.b := GR0;
            RegistreX.a := TangenteDLGR(RegistreX.a);
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'ArcTangente2' then
          begin
            if XComplexe then
            begin
              AFlotte('Pas d''ArcTangente(Y/X) pour une donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            AFlotte('ArcTan2DLGR', MsgDureeCourte, clWhite);
            RegistreX.a := ArcTan2DLGR(RegistreY.a, RegistreX.a);
            RegistreX.b := GR0;
            if rbDeg.Checked {// res Sorti en degrés} then
              RegistreX.a := RadToDegGR(RegistreX.a);
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'ArcTangente' then
          begin
            if XComplexe then
            begin
              AFlotte('Pas d''ArcTangente pour une donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            AFlotte('ArcTangenteDLGR', MsgDureeCourte, clWhite);
            RegistreX.a := ArcTangenteDLGR(RegistreX.a);
            RegistreX.b := GR0;
            if rbDeg.Checked {// resultat Sorti en degrés} then
              RegistreX.a := RadToDegGR(RegistreX.a);
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'ArcSinus' then
          begin
            if XComplexe then
            begin
              AFlotte('Pas d''ArcSinus pour une donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            AFlotte('ArcSinusGR', MsgDureeCourte, clWhite);
            RegistreX.a := ArcSinusGR(RegistreX.a);
            RegistreX.b := GR0;
            if rbDeg.Checked {// resultat Sorti en degrés} then
              RegistreX.a := RadToDegGR(RegistreX.a);
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'ArcCosinus' then
          begin
            if XComplexe then
            begin
              AFlotte('Pas d''ArcCosinus pour une donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            AFlotte('ArcCosinusGR', MsgDureeCourte, clWhite);
            RegistreX.a := ArcCosinusGR(RegistreX.a);
            RegistreX.b := GR0;
            if rbDeg.Checked {// res Sorti en degrés} then
              RegistreX.a := RadToDegGR(RegistreX.a);
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'CosHyperbolique' then
          begin
            if XComplexe then
            begin
              AFlotte('Pas de Cosinus hyperbolique pour une donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            AFlotte('ChxGR', MsgDureeCourte, clWhite);
            RegistreX.a := ChxGR(RegistreX.a);
            RegistreX.b := GR0;
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'SinHyperbolique' then
          begin
            if XComplexe then
            begin
              AFlotte('Pas de Sinus hyperbolique pour une donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            AFlotte('ShxGR', MsgDureeCourte, clWhite);
            RegistreX.a := ShxGR(RegistreX.a);
            RegistreX.b := GR0;
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'TanHyperbolique' then
          begin
            if XComplexe then
            begin
              AFlotte('Pas de Tangente hyperbolique pour une donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            AFlotte('ThxGr', MsgDureeCourte, clWhite);
            RegistreX.a := ThxGr(RegistreX.a);
            RegistreX.b := GR0;
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'ArgCh' then
          begin
            if XComplexe then
            begin
              AFlotte('Argument Cosinus-hyperbolique : non prévu pour donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            AFlotte('ArgCh', MsgDureeCourte, clWhite);
            RegistreX.a := ArgChGR(RegistreX.a);
            RegistreX.b := GR0;
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'ArgSh' then
          begin
            if XComplexe then
            begin
              AFlotte('Argument Sinus-hyperbolique : non prévu pour donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            AFlotte('ArgSh', MsgDureeCourte, clWhite);
            RegistreX.a := ArgShGR(RegistreX.a);
            RegistreX.b := GR0;
            Affiche.text := GCToStrE(RegistreX);
            goto Saut;
          end
          else if oper = 'ArgTh' then
          begin
            if XComplexe then
            begin
              AFlotte('Argument Tangente-hyperbolique : non prévu pour donnée complexe',
                MsgDureeLongue, clYellow);
              Sablier;
              EXIT;
            end;
            AFlotte('ArgTh', MsgDureeCourte, clWhite);
            RegistreX.a := ArgThGR(RegistreX.a);
            RegistreX.b := GR0;
            Affiche.text := GCToStrE(RegistreX);
          end;
    Saut:
    plMis.caption := oper + ' : ' + Chrono.Mis;
    labMem.caption := fGoMoKo(memDispo);
    Enluminures;
    if (pos('infini', Affiche.Text) > 0) then
      RegistreX := GC0;
    if (oper = 'ConvertThetaRXY') and (ssAlt in shift) then
      Efface := False
    else
      Efface := True;
    Enter := False;
    Affiche.SetFocus;
  finally
    Sablier;
    (Sender as tSpeedButton).Down := False;
  end;
end;

procedure TfrmCalcGR.FormActivate(Sender: TObject);
begin // Actualisation pour cas où NC affiché a été modifié via une autre fiche
  ednbCSGR.text := IntToStr(nbCsGr);
  bColler.Enabled := Clipboard.AsText <> '';
end;

procedure TfrmCalcGR.AfficheChange(Sender: TObject);
var
  len: integer;
begin
  len := length(Affiche.text);
  labNbCar.caption := intToStr(len) + ' car';
end;

// Couper, Copier, Coller :

procedure TfrmCalcGR.bCouperCopierCollerMouseUp(Sender: TObject; Button:
  TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  u: string;
begin
  with Affiche do
  begin
    if (Sender as tSpeedButton).name = 'bColler' then
    begin
      if pos('...', affiche.text) > 0 then
        affiche.text := '';
      Affiche.clear;
      Affiche.PasteFromClipBoard;
      u := Affiche.text;
      NettSaisieGC(u);
      Affiche.text := u;
      try
        RegistreX := StrToGC(Affiche.Text);
      except
        Affiche.text := '0';
        raise;
      end;
      EXIT;
    end;
    if (Sender as tSpeedButton).name = 'bCouperCopierColler' then
    begin
      if Sellength = 0 then
        SelectAll;
      Affiche.CutToClipboard;
      bColler.enabled := true;
    end;
    if (Sender as tSpeedButton).name = 'bCopier' then
    begin
      if Sellength = 0 then
        SelectAll;
      Affiche.CopyToClipBoard;
      bColler.enabled := true;
    end;
    SelLength := 0;
  end;
end;

procedure TfrmCalcGR.AfficheMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  bCouperCopierColler.Enabled := Affiche.SelLength <> 0;
  bCopier.Enabled := Affiche.SelLength <> 0;
end;

procedure TfrmCalcGR.bVisuClick(Sender: TObject);
begin
  LRFlotte('Mémoires : ' + cls
    + 'RCL = ' + GCToStrE(Constante) + cls
    + '----------------------' + cls
    + 'T = ' + GCToStrE(RegistreT) + cls
    + 'Z = ' + GCToStrE(RegistreZ) + cls
    + 'Y = ' + GCToStrE(RegistreY) + cls
    + 'X = ' + GCToStrE(RegistreX), 30, clBeige, clWhite);
end;

procedure TfrmCalcGR.bSwapXYClick(Sender: TObject);
begin
  RegistreS := RegistreX;
  RegistreX := RegistreY;
  RegistreY := RegistreS;
  Affiche.text := GCToStrE(RegistreX);
  Efface := True;
end;

procedure TfrmCalcGR.bSTOClick(Sender: TObject);
begin
  Constante := StrToGC(Affiche.Text);
  Efface := True;
end;

procedure TfrmCalcGR.bRCLClick(Sender: TObject);
begin
  if Enter = False then
  begin
    RegistreT := RegistreZ;
    RegistreZ := RegistreY;
    RegistreY := RegistreX;
    RegistreX := Constante;
  end
  else if Enter = True then
    RegistreX := Constante;
  Affiche.text := GCToStrE(RegistreX);
  Efface := true;
end;

procedure TfrmCalcGR.bAideClick(Sender: TObject);
begin
  cacheFlotte1;
  ShellExecute(0, 'OPEN', PChar(RepAppli + 'Aide_Equas_Calc8.chm'), nil, nil,
    SW_SHOW);
end;

procedure TfrmCalcGR.bInfoAccueilClick(Sender: TObject);
begin
  Affiche.text := msgAccueil;
  Enluminures;
  MettreEnGrasEtCoul(Affiche, 'x', clBlue);
  MettreEnGrasEtCoul(Affiche, 'y', clBlue);
  MettreEnGrasEtCoul(Affiche, 'notation polonaise inverse', clBlue);
  MettreEnGrasEtCoul(Affiche, 'i*', clBlue);
end;

end. //-------------------------------------------------------------------------

