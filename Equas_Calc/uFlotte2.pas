unit uFlotte2;

interface // Pour faire apparaître des fiches flottantes éphémères évanescentes
// au bout de iduree en secondes

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, uFun2, Buttons;

type
  TfrmFlotte2 = class(TForm)
    plSupport: TPanel;
    labTitre: TLabel;
    red: TRichEdit;
    Timer1: TTimer;
    procedure labTitreMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure labTitreDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure redMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure redSelectionChange(Sender: TObject);
    procedure labTitreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
    duree: Word;
  public
    { Déclarations publiques }
    ignoreTempo: boolean;
  end;

var
  frmFlotte2: TfrmFlotte2;

  // Pour afficher :
procedure AFlotte(msg: string; iduree: Word; icFond: tColor);
procedure LRFlotte(msg: string; iduree: Word; icFondL, icFondR: tColor);
// Pour forcer fermeture immédiate :
procedure cacheFlotte1;
procedure cacheFlotte2(frmRetour: tForm; FocusPour: tObject);

implementation

{$R *.DFM}

// ---------------------------------------------------------------- Durées : -

var
  Start: DWORD;

procedure TopC;
begin
  Start := GetTickCount;
end;

function fSec: Word; { renvoie durée en secondes depuis Top Chrono }
begin
  fsec := (GetTickCount - Start) div 1000;
end;

{ --------------------------------------------------------- Relance tempo : - }
var
  coulFonteTitre: tColor;

procedure TfrmFlotte2.labTitreClick(Sender: TObject);
begin
  TopC;
  labTitre.Font.color := coulFonteTitre;
end;

{ --------------------------------------------------------- Ouverture Frm : - }

procedure AjustPosit(F: tForm);
begin
  with F do
  begin
    if top + height > screen.height then
      top := screen.height - height;
    if left + width > screen.width then
      left := screen.width - width;
  end;
end;

procedure TfrmFlotte2.FormShow(Sender: TObject);
begin
  AjustPosit(frmFlotte2);
  if height > screen.Height then
    red.ScrollBars := ssVertical
  else
    red.ScrollBars := ssNone;
  coulFonteTitre := clBlack;
  red.wordWrap := false;
  if ignoreTempo = false then
    TopC;
end;

// -------------------------------------------------- Déplacement de la Form :

procedure TfrmFlotte2.labTitreMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin // Déplacement avec le bouton gauche de la souris
  if (ssLeft in Shift) then
    Deplacement(frmFlotte2, X, Y);
end;

//----------------------------------------------------------------- Femeture :

procedure TfrmFlotte2.labTitreDblClick(Sender: TObject);
begin
  screen.cursor := crDefault;
  labTitre.Font.color := coulFonteTitre;
  close;
end;

procedure TfrmFlotte2.Timer1Timer(Sender: TObject);
begin
  if ignoreTempo then
    EXIT;
  if fSec > duree - 4 then
  begin
    if labTitre.color <> clTeal then
      labTitre.Font.color := clTeal
    else
      labTitre.Font.color := clBlack;

  end;
  if fSec > duree then
    labTitreDblClick(Sender);
end;

// ------------------------------------------------------------ Affichages : -

procedure AFlotte(msg: string; iduree: Word; icFond: tColor);
var
  w, h: integer;
begin
  with frmFlotte2 do
  begin
    labTitre.visible := true;
    labTitre.align := alNone;
    labTitre.font.color := coulFonteTitre;
    labTitre.caption := msg;
    red.visible := false;
    w := canvas.textWidth(msg);
    h := canvas.textHeight(msg);
    labTitre.left := 1;
    labTitre.top := 1;
    labTitre.width := w + 30;
    labTitre.height := h + 2;
    labTitre.color := icFond;
    plSupport.width := labTitre.width + 3;
    plSupport.height := labTitre.height + 3;
    plSupport.color := clBlack;
    clientWidth := plSupport.width - 1;
    clientHeight := plSupport.height - 1;
    if position <> poScreenCenter then
      position := poScreenCenter;
    visible := true;
    duree := iduree;
    topC;
    refresh;
  end;
end;

procedure LRFlotte(msg: string; iduree: Word; icFondL, icFondR: tColor);
var
  w, h, i, c, lg, p, wred, hred: integer;
  mess: string;
begin
  if msg = '' then
    EXIT;
  with frmFlotte2 do
  begin
    red.visible := true;
    labTitre.visible := true;
    mess := msg;
    red.Scrollbars := ssVertical;
    labTitre.align := alTop;
    red.clear;
    plSupport.caption := '';
    with labTitre do
    begin
      p := pos(#13#10, mess);
      if p > 0 then
      begin
        caption := copy(mess, 1, p);
        delete(mess, 1, p + 1);
      end
      else
        caption := mess;
      left := 1;
      top := 1;
      height := canvas.textHeight(caption) + 1;
      w := canvas.textWidth(caption);
      color := icFondL;
    end;
    red.paragraph.FirstIndent := 6;
    red.paragraph.RightIndent := 6;
    red.lines.add(mess);
    red.selStart := 0;
    c := red.lines.count;
    h := c * canvas.textHeight(red.lines[1]);
    for i := 0 to c - 1 do
    begin
      lg := canvas.textWidth(red.lines[i]);
      if lg > w then
        w := lg;
    end;
    wred := w + 15 + ((12 * 4) div 3);
    hred := h + 1;
    clientWidth := wred + 2;
    clientHeight := labTitre.top + labTitre.height + hred + 2;
    plSupport.width := clientWidth;
    plSupport.height := clientHeight;
    plSupport.color := clBlack;
    with red do
    begin
      left := 1;
      top := labTitre.height + 2;
      width := wred;
      height := hred;
      color := icFondR;
    end;
    position := poScreenCenter;
    show;
    duree := iduree;
    //refresh;
    upDate;
    topC;
  end;
end; // LRFlotte

procedure TfrmFlotte2.redMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  topC;
  labTitre.Font.color := coulFonteTitre;
end; // : jouer prolongation

procedure TfrmFlotte2.redSelectionChange(Sender: TObject);
begin
  red.CopyToClipboard;
end;

procedure TfrmFlotte2.FormCreate(Sender: TObject);
begin
  ignoreTempo := false;
  labTitre.hint := 'Double-clik = Fermer';
end;

procedure cacheFlotte1;
begin
  frmFlotte2.red.Clear;
  frmFlotte2.close;
end;

procedure cacheFlotte2(frmRetour: tForm; FocusPour: tObject);
begin
  frmFlotte2.red.Clear;
  frmFlotte2.close;
  if frmRetour.visible then
  begin
    if (FocusPour is tEdit) then
      (FocusPour as tEdit).setFocus;
    if (FocusPour is tRichEdit) then
      (FocusPour as tRichEdit).setFocus;
    if (FocusPour is tMemo) then
      (FocusPour as tMemo).setFocus;
  end;
end;

end.

