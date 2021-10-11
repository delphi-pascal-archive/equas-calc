unit uFun2; // Cette unité contient des utilitaires divers
// utilisés par les autres unités

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  extctrls, StdCtrls, ComCtrls, Buttons, RichEdit, clipBrd;

type
  TfrmFun = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmFun: TfrmFun;

var
  nbTours: longWord;

type
  chn3 = string[3];
  chn4 = string[4];

const
  cLS = #13#10; // Ligne Suivante
  cTab = #09; // Tabulation

const
  clBeige = $00BBCCD5; // Couleur Beige

procedure SMS(s: string);
procedure SMI(i: integer);
procedure PP_(s: string);

function TrimG(s: string): string; // supprime espaces à Gauche uniquement
function TrimD(s: string): string; // supprime espaces à Droite uniquement
function TrimChar(const S: string; CharTrim: Char): string;
  // supprime tous les CharTrim
function SupprCharV5(const S: string; CharSuppr: Char): string;
  // Idem mais sans SetLength
function TrimS(s: string): string;
  // comme Trim mais supprime en plus les espaces intermédiaires

type
  tCharAdmis = set of Char;
function TrimCharToutSauf(const S: string; CharAdmis: tCharAdmis): string;
//         Supprime tout sauf les caractères admis

type
  tCharSuppr = set of Char; // 1,23 fois plus lente que SupprCharS
function TrimCharS(const S: string; CharSuppr: tCharSuppr): string;
//        Renvoie S débarrasé de tous les caractères contenus dans CharSuppr

// Enlève de la chaîne S tous les chr contenus dans CharS  / KR 85
function SupprCharS(const S, Chars: string): string;

function chnFloat(val: extended; decim: byte): string;
function RepAppli: string; // renvoie Repertoire avec \ terminal
function Echapper: boolean;
procedure Sablier;
procedure FiltreNumeriqueReel(Sender: TObject; var Key: Char);
procedure FiltreNumeriqueEntier(Sender: TObject; var Key: Char);
procedure Deplacement(Sender: TObject; X, Y: Integer);

type
  tChronoMS = object
    Start: DWORD;
    procedure Top;
    function Mis: DWORD; // en millisec
  end;

function sDuree(intro: string; sec: longint): string;

type
  oChrono = object
    t0, t1: tDateTime;
    Heure, Minu, Sec, MSec: Word;
    dHeure, dMin, dSec, dMSec: Word;
    cHe, cMi, cSe, cMs: shortString;
    procedure Top;
    function Mis: shortString; // chaine temps passé depuis Chrono.Top
  end;

function fGoMoKo(mem: int64): string;
function Memoire: string;
function memDispo: DWORD; // renvoie mem vive dispo

// Gestion RichEdit ----------------------------------------------------------

type
  TCharPos = (Indice, Exposant, Normal);

procedure RedSelectionEnIndiceExposant(RE: TRichEdit; CharPos: TCharPos);
//        Place la sélection de RE en indice, exposant ou en position normale

procedure redParagraph(RE: tRichEdit; Alig: char; MargeG, Retrait, MargeD:
  Longint);
// Alig = g c ou d suivant gauche centré ou droit

procedure RedSuiteText(RE: TRichEdit; s: string; CharPos: TCharPos; FontName:
  string; SizeFont: integer;
  Styl: tFontStyles; Coul: TColor);

procedure RedEspacementLignes(RichEdit: TRichEdit; Espacement: Byte);
//        Pour Espacement = 0 texte serré au maxi

// Edit pour texte aligné à droite en cas de Vista :

type
  TMonEdit = class(TEdit)
  private
    FTextAlign: TAlignment;
    procedure SetTextAlign(Value: TAlignment);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property TextAlignment: TAlignment read FTextAlign write SetTextAlign;
  end;

implementation

{$R *.DFM}

procedure SMS(s: string);
begin
  Showmessage(s);
end;

procedure SMI(i: integer);
begin
  Showmessage(intToStr(i));
end;

procedure PP_(s: string);
begin
  clipboard.AsText := s;
end;

{ --------------------------------------------------------------------------- }

function TrimG(s: string): string;
var
  n: integer;
begin
  n := length(s);
  if n = 0 then
  begin
    TrimG := '';
    EXIT;
  end;
  while ((length(s) >= 1) and (s[1] = ' ')) do
  begin
    s := copy(s, 2, n - 1);
    dec(n);
  end;
  TrimG := s;
end;

function TrimD(s: string): string;
var
  n: integer;
begin
  n := length(s);
  while s[n] = ' ' do
  begin
    s := copy(s, 1, n - 1);
    dec(n);
  end;
  TrimD := s;
end;

function TrimChar(const S: string; CharTrim: Char): string;
var
  i, Transf: integer;
  pIn, pOut: PChar; // 2,392 Mo/sec Pentium III à 1,13 GHz
begin
  Result := S;
  if Result = '' then
    Exit;
  pIn := @S[1];
  pOut := @Result[1];
  Transf := 0;
  for i := 1 to length(S) do
  begin
    if pIn^ <> CharTrim then
    begin
      pOut^ := pIn^;
      inc(Transf);
      inc(pOut);
    end;
    inc(pIn);
  end;
  SetLength(Result, Transf);
end; // TrimChar

function TrimCharToutSauf(const S: string; CharAdmis: tCharAdmis): string;
var
  i, Transf: integer;
  pIn, pOut: PChar;
begin
  Result := S;
  if Result = '' then
    Exit;
  pIn := @S[1];
  pOut := @Result[1];
  Transf := 0;
  for i := 1 to length(S) do
  begin
    if pIn^ in CharAdmis then
    begin
      pOut^ := pIn^;
      inc(Transf);
      inc(pOut);
    end;
    inc(pIn);
  end;
  SetLength(Result, Transf);
end; // TrimCharToutSauf

function TrimCharS(const S: string; CharSuppr: tCharSuppr): string;
//        Renvoie S débarrasé de tous les caractères contenus dans CharSuppr
var
  i, Transf: integer;
  pIn, pOut: PChar;
begin
  Result := S;
  if Result = '' then
    Exit;
  pIn := @S[1];
  pOut := @Result[1];
  Transf := 0;
  for i := 1 to length(S) do
  begin
    if not (pIn^ in CharSuppr) then
    begin
      pOut^ := pIn^;
      inc(Transf);
      inc(pOut);
    end;
    inc(pIn);
  end;
  SetLength(Result, Transf);
end; // TrimCharS

function TrimS(s: string): string;
//        idem à Trim + suppression de tous les espaces
begin
  Result := Trim(s);
  Result := TrimChar(Result, ' ');
end;

function SupprCharV5(const S: string; CharSuppr: Char): string; // KR 85
asm
  push   ebx                       // registres de travail
  push   esi
  push   edi
  push   ecx                       // empiler adresse retour
  mov    ebx,edx                   // garder Char
  mov    esi,eax                   // esi pointe S
  mov    eax,[esi]-$4              // eax = length(S)
  add    esi,eax                   // esi pointe fin S + 1
  mov    ecx,eax                   // ecx = itérations comptage
  @compteur:                       // compteur des Char à supprimer
    dec    esi
    cmp    byte ptr[esi],bl        // chr = Char ?
    jne    @non
    dec    eax                     // si oui, décrémente longueur de S
    @non:
    loop   @compteur
  call   System.@NewAnsiString     // demander nouvelle chaîne de eax long
  mov    edi,eax                   // edi pointe newString
  pop    eax                       // rappel Result
  call   System.@LStrClr           // déréférencement
  mov    [eax],edi                 // place Nouvelle Str en Result
  mov    ecx,[esi]-$4              // compteur copy
  @Copy:                           // Copie de la nouvelle Str sans Char
    mov    al,byte ptr[esi]
    inc    esi
    cmp    al,bl
    je     @SCopy
    mov    byte ptr[edi],al
    inc    edi
    @SCopy:
    loop   @Copy
  @fin:
  pop    edi
  pop    esi
  pop    ebx
end;

// Enlève tous les chr contenus dans CharS de la chaîne S  KR 85

function SupprCharS(const S, Chars: string): string;
var
  Cpt: longword;
asm
  push   ebx
  push   esi
  push   edi
  mov    esi,eax
  mov    ebx,edx
  push   ecx
  mov    edx,[esi]-$4
  mov    eax,ecx
  call   System.@LStrSetLength
  mov    edi,[eax]
  mov    ecx,[esi]-$4
  mov    Cpt,0
  @Copy:
    mov    al,byte ptr[esi]
    inc    esi
    mov    edx,[ebx]-$4
    dec    edx
    @RChars:
      cmp    al,byte ptr[ebx]+edx
      je     @NoCopy
      dec    edx
      jnl    @RChars
    mov    byte ptr[edi],al
    inc    edi
    inc    Cpt
    @NoCopy:
    loop   @Copy
  pop    eax
  mov    edx,Cpt
  call   System.@LStrSetLength
  pop    edi
  pop    esi
  pop    ebx
end; // Attention : il ne s'agit pas d'ôter une sous chaîne (Delete de Delphi le fait très bien)...

function chnFloat(val: extended; decim: byte): string;
var
  s, pu: string;
  poE, poV: byte;
begin
  s := FloatToStrF(val, ffGeneral, 18, 4);
  poE := pos('E', s);
  poV := 0;
  if decimalSeparator = ',' then
    poV := pos(',', s)
  else if decimalSeparator = '.' then
    poV := pos('.', s);
  if (poE = 0) and (poV > 0) then
    s := copy(s, 1, poV + decim)
  else if (poE > 0) and (poV > 0) then
  begin
    pu := copy(s, poE, 6);
    s := copy(s, 1, poV + decim) + pu;
  end;
  if poV > 0 then
    s[poV] := '.';
  if poV = length(s) then
    delete(s, poV, 1);
  chnFloat := s;
end;

function RepAppli: string; // renvoie Rep avec \ terminal
begin
  RepAppli := ExtractFilePath(Application.ExeName);
end;

function Echapper: boolean;
begin
  if getAsyncKeyState(VK_ESCAPE) <> 0 then
    Result := true
  else
    Result := false;
end;

procedure Sablier;
begin
  with Screen do
    if cursor = crHourGlass then
      cursor := crDefault
    else
      cursor := crHourGlass;
end;

procedure FiltreNumeriqueReel(Sender: TObject; var Key: Char);
begin
  if Key = 'e' then
    Key := 'E';
  if not (Key in ['-', DecimalSeparator, '0'..'9', 'E', Chr(VK_BACK)]) then
    Key := #0;
end;

procedure FiltreNumeriqueEntier(Sender: TObject; var Key: Char);
begin
  if not (Key in ['-', '0'..'9', Chr(VK_BACK)]) then
    Key := #0;
end;

procedure Deplacement(Sender: TObject; X, Y: Integer);
const
  SC_DragMove = $F014;
begin
  ReleaseCapture;
  TControl(Sender).Perform(WM_SysCommand, SC_DragMove, 0);
end;

// Chrono ---------------------------------------------------------------------

procedure tChronoMS.Top;
begin
  Start := GetTickCount;
end;

function tChronoMS.Mis;
begin
  Mis := GetTickCount - Start;
end;

//------------------

function sDuree(intro: string; sec: longint): string;
var
  time: longint;
  s: string;
begin
  s := intro;
  time := sec;
  if time > 24 * 60 * 60 then
    s := s + intToStr(time div 24 div 60 div 60) + ' jour(s) ';
  time := time - time div 24 div 60 div 60 * 24 * 60 * 60;
  if time > 60 * 60 then
    s := s + intToStr(time div 60 div 60) + ' heure(s) ';
  time := time - time div 60 div 60 * 60 * 60;
  if time > 60 then
    s := s + intToStr(time div 60) + ' minute(s) ';
  time := time - time div 60 * 60;
  s := s + intToStr(time) + ' seconde(s) ... si Pentium III à 1.13 GHz';
  Result := s;
end;

procedure oChrono.Top;
begin
  t0 := Time;
  DecodeTime(Now, Heure, Minu, Sec, MSec);
end;

function oChrono.Mis: shortString;
  // renvoie chaine temps passé depuis oChrono.Top
begin
  t1 := time;
  t1 := t1 - t0;
  DecodeTime(t1, dHeure, dMin, dSec, dMSec);
  cHe := '';
  if dHeure > 0 then
    cHe := IntToStr(dHeure) + 'h ';
  cMi := '';
  if dMin > 0 then
    cMi := IntToStr(dMin) + 'm ';
  cSe := '';
  if dSec > 0 then
    cSe := IntToStr(dSec) + 's ';
  cMs := '';
  if dMSec > 0 then
    cMs := IntToStr(dMSec) + ' ms';
  Result := cHE + cMi + cSe + cMs;
end;

procedure TfrmFun.FormCreate(Sender: TObject);
begin
  caption := 'Fonctions diverses';
end;

function fGoMoKo(mem: int64): string;
  // Conversion Tailles en chaînes avec unités (Ko, Mo, etc) variables
var
  e: integer;
  s: string;
  r: real;
begin
  e := 0;
  r := mem;
  if r >= 0 then
  begin
    while r > 1024 do
    begin
      r := r / 1024;
      inc(e);
    end;
    case e of
      0: s := 'oct';
      1: s := 'Ko';
      2: s := 'Mo';
      3: s := 'Go';
      4: s := 'To';
    end;
    fGoMoKo := FormatFloat('#.###', r) + ' ' + s;
  end;
end; // fGoMoKo

function Memoire: string;
var
  MS: TMemoryStatus;
  MemPhys, MemOccu, MemDisp, msg: string;
begin
  GlobalMemoryStatus(MS);
  //MemPhys:='Total : '+FormatFloat('#,###" Ko"', MS.dwTotalPhys / 1024);
  //MemDisp:='Dispo : '+FormatFloat('#,###" Ko"', MS.dwAvailPhys / 1024);
  //MemOccu:='- Occup : '+ Format('%d %%', [MS.dwMemoryLoad]);
  MemPhys := '- Totale : ' + fGoMoKo(MS.dwTotalPhys);
  MemDisp := '- Dispon : ' + fGoMoKo(MS.dwAvailPhys);
  MemOccu := '- Occupé : ' + fGoMoKo(MS.dwTotalPhys - MS.dwAvailPhys);
  msg := 'Mémoire' + cLS;
  msg := msg + MemDisp + cLS;
  msg := msg + MemOccu + cLS;
  msg := msg + MemPhys;
  Result := msg;
end;

function memDispo: DWORD; // renvoie mem-vive-dispo
var
  Mem: TMemoryStatus;
begin
  Mem.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(Mem);
  memDispo := Mem.dwAvailPhys;
end; // Pour plus de détails voir MemoryStatus dans l''aide SDKWindows

// Gestion RichEdit ----------------------------------------------------------

procedure redAttriPol(red: tRichEdit; nomPol: string; szPol: integer;
  fsPol: tFontStyles; clPol: tColor);
begin
  red.selStart := length(red.text);
  with red.SelAttributes do
  begin
    name := nomPol;
    Size := szPol;
    Style := fsPol;
    Color := clPol;
  end;
  red.Update;
end;

procedure redParagraph(RE: tRichEdit; Alig: char; MargeG, Retrait, MargeD:
  Longint);
//        Ali = g c ou d selon gauche, centré, droite
begin
  RE.SelStart := length(RE.text);
  with RE.Paragraph do
  begin
    case alig of
      'c': Alignment := taCenter;
      'd': Alignment := taRightJustify;
      'g': Alignment := taLeftJustify;
    end;
    LeftIndent := MargeG;
    FirstIndent := Retrait;
    RightIndent := MargeD;
    Numbering := nsNone; //<- remplaçable par un chr de WingDings ou WebDings
  end;
  RE.Update;
end;

procedure RedSelectionEnIndiceExposant(RE: TRichEdit; CharPos: TCharPos);
var
  Format: TCharFormat;
    // infos sur formattage de caractères RichEdit (voir SDK Win)
  DeltaY: integer;
begin
  DeltaY := abs((55 * RE.Font.Size) div 8);
  FillChar(format, SizeOf(Format), 0);
  with Format do
  begin
    cbSize := SizeOf(Format);
    dwMask := CFM_OFFSET; // Pour positionnement deltaY du caractère
    case CharPos of
      Exposant: yOffset := DeltaY;
        //<- en twips 1 twip = 1/1440 pouce ou 1/20 point.
      Normal: yOffset := 0;
      Indice: yOffset := -DeltaY; //négatif en twips
    end;
  end;
  // Transfert du formattage des caractères dans la sélection du RichEdit
  SendMessage(RE.Handle, EM_SETCHARFORMAT, SCF_SELECTION, LPARAM(@Format))
end;

procedure RedSuiteText(RE: TRichEdit; s: string; CharPos: TCharPos; FontName:
  string; SizeFont: integer;
  Styl: tFontStyles; Coul: TColor);
var
  ss: integer;
begin
  ss := length(re.text);
  if (ss > 0) and (re.text[ss] = #10) then
    dec(ss);
  with RE do
  begin
    if ss = 0 then
      lines.add('');
    SelStart := ss;
    SelText := s;
    SelStart := ss - 1;
    SelLength := length(s);
  end;
  RedSelectionEnIndiceExposant(RE, CharPos);
  with Re.SelAttributes do
  begin
    name := FontName;
    size := SizeFont;
    Style := Styl;
    color := Coul;
  end;
  Re.SelLength := 0;
end;

procedure RedEspacementLignes(RichEdit: TRichEdit; Espacement: Byte);
//        Réglage espacement lignes dans RichEdit
var
  pformat2: ParaFormat2;
begin
  FillChar(pformat2, SizeOf(pformat2), 0);
  pformat2.cbSize := SizeOf(PARAFORMAT2);
  pformat2.dwMask := PFM_LINESPACING;
  pformat2.bLineSpacingRule := Espacement;
  SendMessage(RichEdit.Handle, EM_SETPARAFORMAT, 0, Longint(@pformat2));
end;

// Edit pour texte aligné à droite en cas de Vista

constructor TMonEdit.Create(AOwner: TComponent);
begin
  inherited;
  FTextAlign := taRightJustify;
end;

procedure TMonEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of Word = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or Alignments[TextAlignment];
end;

procedure TMonEdit.SetTextAlign(Value: TAlignment);
begin
  if FTextAlign <> Value then
  begin
    FTextAlign := Value;
    RecreateWnd;
  end;
end;

end. //-------------------------------------------------------------------------

