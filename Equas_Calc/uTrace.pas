unit uTrace;

interface // uTrace : Utilisée par uEquas7 pour affichage de "Voir +"

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, uFun2, uFlotte2, Buttons, RichEdit, ComCtrls, ExtCtrls, UnitGR;

type
  TfrmTrace = class(TForm)
    red2: TRichEdit;
    Panel1: TPanel;
    Label1: TLabel;
    edNAT: TEdit;
    bImprimer2: TSpeedButton;
    bSauver: TSpeedButton;
    bCopier2: TSpeedButton;
    SaveDialog1: TSaveDialog;
    bOuvrir: TSpeedButton;
    OpenDialog1: TOpenDialog;
    procedure edNATChange(Sender: TObject);
    procedure bImprimer2Click(Sender: TObject);
    procedure bSauverClick(Sender: TObject);
    procedure bCopier2Click(Sender: TObject);
    procedure bOuvrirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmTrace: TfrmTrace;

procedure TraceZGC(msg: string);

procedure TraceZGC2(msg: string; CharPos: TCharPos; FontName: string; SizeFont:
  integer;
  Styl: tFontStyles; Coul: TColor);
procedure RazTrace;

var
  NAT: integer;
    // Nombre de chiffres à Afficher dans Trace par composante du résultat

implementation

{$R *.DFM}

procedure RazTrace;
begin
  with frmTrace.red2 do
  begin
    clear;
    Lines.add('');
  end;
end;

procedure TraceZGC(msg: string);
begin
  frmTrace.red2.lines.add(msg);
end;

procedure TraceZGC2(msg: string; CharPos: TCharPos; FontName: string; SizeFont:
  integer;
  Styl: tFontStyles; Coul: TColor);
begin
  RedSuiteText(frmTrace.red2, msg, CharPos, FontName, SizeFont, Styl, Coul);
  frmTrace.red2.Update;
end;

procedure TfrmTrace.FormCreate(Sender: TObject);
begin
  NAT := nbCSGR;
  edNAT.Text := IntToStr(NAT);
end;

procedure TfrmTrace.edNATChange(Sender: TObject);
begin
  NAT := StrToInt(edNAT.text);
  if NAT < 20 then
  begin
    NAT := 20;
    edNAT.text := intToStr(NAT);
    edNAT.SelStart := 3;
  end;
end;

procedure TfrmTrace.bImprimer2Click(Sender: TObject);
begin
  Red2.Print('Equation');
end;

procedure TfrmTrace.bSauverClick(Sender: TObject);
begin
  SaveDialog1.InitialDir := RepAppli;
  SaveDialog1.Filter := 'Fichier rtf (*.rtf)|*.rtf';
  SaveDialog1.FileName := 'Equation.rtf';
  if SaveDialog1.execute then
  begin
    Red2.lines.saveToFile(SaveDialog1.FileName);
    AFlotte('Sauvé', 15, clAqua);
  end;
end;

procedure TfrmTrace.bCopier2Click(Sender: TObject);
begin
  with Red2 do
  begin
    if SelLength = 0 then
      SelectAll;
    CopyToClipBoard;
    SelLength := 0;
  end;
end;

procedure TfrmTrace.bOuvrirClick(Sender: TObject);
begin
  OpenDialog1.InitialDir := RepAppli;
  OpenDialog1.Filter := 'Fichier rtf (*.rtf)|*.rtf';
  OpenDialog1.FileName := '*.rtf';
  if OpenDialog1.execute then
    Red2.lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TfrmTrace.Panel1DblClick(Sender: TObject);
begin
  RazTrace;
end;

procedure TfrmTrace.FormShow(Sender: TObject);
begin // Se positionner sur 1ière ligne
  with Red2 do
  begin
    SelStart := Perform(EM_LINEINDEX, 0, 0);
    Perform(EM_SCROLLCARET, 0, 0);
  end;
end;

end. ///////////////////////////////////////////////////////////////////////////

