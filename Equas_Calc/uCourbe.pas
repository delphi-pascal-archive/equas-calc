unit uCourbe;
// uCourbe : gère le tracé de courbes suite à la résolution d'une équa

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, uFun2, uFlotte2, ExtDlgs, uMarges, Math, Menus,
  uCouleurs, UnitGR, UnitGC, StdCtrls, uTrace, ComCtrls;

type
  TfrmCourbe = class(TForm)
    plCourbe: TPanel;
    imgF: TImage;
    plGauche: TPanel;
    bAgrandirY: TSpeedButton;
    bReduireY: TSpeedButton;
    bAjusterCourbe: TSpeedButton;
    plDroit: TPanel;
    bCopier2: TSpeedButton;
    bSauver2: TSpeedButton;
    bImprimer2: TSpeedButton;
    SavePictureDialog1: TSavePictureDialog;
    bEchelles: TSpeedButton;
    SpeedButton1: TSpeedButton;
    popEchellesCoul: TPopupMenu;
    EchellesXetY: TMenuItem;
    CouleursDeLaCourbe1: TMenuItem;
    InfosSurCoul: TMenuItem;
    ModifierCoul: TMenuItem;
    ArcEnCiel: TMenuItem;
    Monochrome: TMenuItem;
    PopupMenu1: TPopupMenu;
    EchellesXetY2: TMenuItem;
    CouleursCourbe2: TMenuItem;
    Modifier1: TMenuItem;
    Arcenciel2: TMenuItem;
    Monochrome2: TMenuItem;
    Panel1: TPanel;
    labCoos: TLabel;
    UpDown1: TUpDown;
    bInfos: TSpeedButton;
    Red1: TRichEdit;
    bCopierLuc: TSpeedButton;
    bCollerDansLuc: TSpeedButton;
    bLucVersVoirPlus: TSpeedButton;
    bImprimerLuc: TSpeedButton;
    bSauverLuc: TSpeedButton;
    SaveDialog1: TSaveDialog;
    bEffaceLuc: TSpeedButton;
    procedure bAgrandirYClick(Sender: TObject);
    procedure bReduireYClick(Sender: TObject);
    procedure bAjusterCourbeClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure bCopier2Click(Sender: TObject);
    procedure bSauver2Click(Sender: TObject);
    procedure bImprimer2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure imgFMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EchellesXetY2Click(Sender: TObject);
    procedure InfosSurCoulClick(Sender: TObject);
    procedure Monochrome2Click(Sender: TObject);
    procedure Arcenciel2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bEchellesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgFMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure plGaucheMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure Panel1DblClick(Sender: TObject);
    procedure bInfosClick(Sender: TObject);
    procedure Red1KeyPress(Sender: TObject; var Key: Char);
    procedure bCopierLucClick(Sender: TObject);
    procedure bCollerDansLucClick(Sender: TObject);
    procedure bLucVersVoirPlusClick(Sender: TObject);
    procedure bImprimerLucClick(Sender: TObject);
    procedure bSauverLucClick(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bEffaceLucClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmCourbe: TfrmCourbe;

type
  tFonc = function(X: tGC): tGC of object;

type
  oCourbe = object
    F: tFonc; // f(x)
    Affichee: boolean;
    Deg: integer;
    slRacinesX: tStringList; // racines classées val num
    slRacinesC: tStringList; // racines classées précédées de xi =
    slCoeffs: tStringList; // coeffs pour imprimer
    kx, ky: Extended; // coeff échelle des Y et des X
    yO, xO: integer; // coordonnées du repère
    DeX, JusquaX: tGC;
    iFDeXmax: Extended;
    bmpArc: tBitMap;
    bmpCourbe: tBitMap;
    Larg, Haut: integer;
    cCourbe: tColor; // = -1 pour Arc-en-ciel
    zii: array of tGC;
    sii: array of shortString;
    xei: array of integer;
    yei: array of integer;
    procedure init(iFun: tfonc; islRacines, islCoeffs: tStringList;
      iLarg, iHaut: integer);
    procedure CreebmpCourbe;
    procedure Affiche;
    procedure ReAffiche;
    procedure Effacer;
    procedure free;
  end;

var
  Courbe: oCourbe;

function chaineCourte(ChnComplexe: string; nbDecim: integer): shortString;

implementation

uses uEquas8, Clipbrd;

{$R *.DFM}

function chaineCourte(ChnComplexe: string; nbDecim: integer): shortString;
//       ChnComplexe en entrée de forme -8.88888888888E11 + i*2.98765432109E-24
//       Renvoie chaine courte pour tracé des racines sur courbe en retenant
//       nbDecim = nombre de décimales pour les chiffres significatifs suivi
//       de l''exposant
var
  st, sa, sb: string;
  poi: integer;

  function Reduc(var ss: string): shortString;
  var
    poCut, poE, poDS, lg: integer;
    nz: int64;
    expo: shortString;
  begin
    Result := '';
    if ss = '' then
      EXIT;
    poE := pos('E', ss);
    expo := '';
    if poE > 0 then
    begin
      expo := copy(ss, poE, maxInt);
      Delete(ss, poE, MaxInt);
    end;
    poDS := pos(DecimalSeparator, ss);
    if poDS > 0 then
      TrimD0(ss, nz);
    lg := length(ss);
    poCut := poDS + nbDecim;
    if (poE > 0) and (poCut > poE) then
      poCut := poE - 1;
    if (lg < poCut) then
      poCut := lg;
    ss := copy(ss, 1, poCut);
    TrimD0(ss, nz);
    lg := length(ss);
    if ss[lg] = DecimalSeparator then
      Delete(ss, lg, 1);
    Result := ss + expo;
  end;

begin
  if ChnComplexe = '' then
  begin
    Result := '';
    EXIT;
  end;
  st := trimS(ChnComplexe);
  poi := pos('i', st);
  sa := '';
  sb := '';
  if poi > 0 then
    SeparerPartiesGC(ChnComplexe, sa, sb)
  else
  begin
    sa := st;
    sb := '';
  end;
  sb := Reduc(sb);
  // Remplacement de i*1 par i si 1 en fin de sb
  poi := pos('i*1', sb);
  if (poi > 0) and (poi + 2 = length(sb)) then
    Delete(sb, poi + 1, 2);
  Result := Reduc(sa) + sb;
end;

procedure oCourbe.init(iFun: tfonc; islRacines, islCoeffs: tStringList;
  iLarg, iHaut: integer);
var
  i, po: integer;
  sd, sf, cc: shortString;
  marge: tGR;
begin
  F := iFun;
  Deg := islCoeffs.count - 1;
  Larg := iLarg;
  Haut := iHaut;
  ky := 100;
  slRacinesC := tStringList.create;
  slRacinesC.addstrings(islRacines);
  slRacinesX := tStringList.create;
  for i := 0 to slRacinesC.count - 1 do
  begin
    sf := slRacinesC[i];
    po := pos('=', sf);
    sd := copy(sf, 1, po + 1);
    Delete(sf, 1, po);
    sf := trim(sf);
    slRacinesX.add(sf);
    cc := chaineCourte(slRacinesX[i], 3);
    if cc = '' then
      cc := '0';
    slRacinesC[i] := sd + cc;
  end;
  DeX := StrToGC(slRacinesX[0]);
  JusquaX := StrToGC(slRacinesX[slRacinesX.count - 1]);
  JusquaX := AddGC(JusquaX, GC1);
  //Ajout de marges pour tracé courbe :
  marge := StrToGR('-1.5');
  DeX.a := AddGR(DeX.a, marge);
  DeX.b := GR0;
  marge := StrToGR('1.5');
  JusquaX.a := AddGR(JusquaX.a, marge);
  JusquaX.b := GR0;

  setLength(zii, slRacinesC.count + 1);
  SetLength(sii, High(zii));
  SetLength(xei, High(zii));
  SetLength(yei, High(zii));

  slCoeffs := tStringList.create;
  slCoeffs.addstrings(islCoeffs);
  // couleurs
  bmpArc := BmpArcEnCiel360x3(255, 255);
  cCourbe := frmCouleurs.choixCouleur;
end;

procedure oCourbe.CreebmpCourbe;
label
  Saut;
var
  bmp: tBitMap;
  rr: tRect;
  i, yec, xec, yecF1, yecF2, yecFF, iCoul: integer;
  xf, yf: tGC;
  yfa, yfb: Extended;
  ex, courbeInvisible: boolean;
  plagex, DeXa, JusquaXa: Extended;
  cmp1, cmp2: shortint;
  info: string;

  function ZZ(i: integer): tGC;
  begin
    ZZ := StrToGC(slRacinesX[i]);
  end;

  procedure AffRacines;
    //        Affichage des racines :
  var
    i: byte;
    lgsp: integer;
  begin
    with bmp.canvas do
    begin
      for i := 0 to slRacinesC.count - 1 do
      begin
        if pos('i', sii[i]) > 0 then
          font.color := clMaroon
        else
          font.color := clGreen;
        pen.color := clBlack;
        if odd(i) then // i impair
        begin
          yei[i] := yO + 5;
          if i >= 3 then
          begin
            lgsp := textWidth(sii[i - 2]);
            if (i > 0) and ((xei[i - 2] + lgsp + 15) > xei[i]) then
              yei[i] := yei[i - 2] + 20;
          end;
          lgsp := textWidth(sii[i]);
          if xei[i] + lgsp > bmp.width then
            textOut(bmp.width - lgsp - 5, yei[i], sii[i])
          else
            textOut(xei[i], yei[i], sii[i]);
          moveTo(xei[i], yO + 3);
          lineTo(xei[i], yO - 3);
        end
        else // i pair 0 = pair
        begin
          yei[i] := yO - 20;
          if i >= 2 then
          begin
            lgsp := textWidth(sii[i - 2]);
            if (i > 0) and ((xei[i - 2] + lgsp + 15) > xei[i]) then
              yei[i] := yei[i - 2] - 20;
          end;
          lgsp := textWidth(sii[i]);
          if xei[i] + lgsp > bmp.width then
            textOut(bmp.width - lgsp - 5, yei[i], sii[i])
          else
            textOut(xei[i], yei[i], sii[i]);
          moveTo(xei[i], yO + 3);
          lineTo(xei[i], yO - 3);
        end;
      end;
    end;
  end; // AffRacines

  procedure AffFonction;
    //Affichage de la fonction correspondant au tracé :
  var
    i, xr, yr, ld, lg, poi: integer;
    s, sa, sb: string;
  begin
    with bmp.canvas do
    begin
      xr := 10;
      yr := 10;
      s := 'Racines de y = f(x) = ';
      font.size := 8;
      font.color := clBlack;
      textOut(xr, yr, s);
      ld := textWidth(s);
      xr := xr + ld;
      for i := 0 to Deg do
      begin
        s := slCoeffs[i];
        s := trim(s);
        poi := pos('i', s);
        if (poi > 0) and (s <> '-i') and (s <> 'i') then
        begin
          SeparerPartiesGC(s, sa, sb);
          if (sa <> '') and (sa[1] = '-') and (sb <> '') and (sb[1] = '-') then
          begin
            Delete(sa, 1, 1);
            Delete(sb, 1, 3);
            s := '-(' + sa + '+i*' + sb + ')';
          end
          else
            s := '(' + s + ')';
        end;

        if (i < Deg) and (s = '1') then
          s := '+';
        if (i < Deg) and (s = '-1') then
          s := '-';
        if (s[1] <> '-') and (s[1] <> '+') then
          s := '+' + s;
        if i < Deg then
          s := s + '.x';
        if s[2] = '.' then
          Delete(s, 2, 1);
        insert(' ', s, 2);
        if (i = 0) and (pos('+ x', s) = 1) then
          Delete(s, 1, 2);
        if i = Deg then
          s := ' ' + s + ' = 0';
        lg := textWidth(s);
        if xr + lg > bmp.width then
        begin
          yr := yr + 20;
          xr := ld;
        end;
        if s <> '+ 0.x' then
        begin
          textOut(xr, yr, s);
          xr := xr + lg;
        end;
        if (i < Deg - 1) and (s <> '+ 0.x') then // exposant
        begin
          s := intToStr(Deg - i) + ' ';
          font.size := 6;
          lg := textWidth(s);
          if xr + lg > bmp.width then
          begin
            yr := yr + 20;
            xr := ld;
          end;
          textOut(xr, yr - 3, s);
          xr := xr + lg;
        end;
      end;
      yecFF := yr + textHeight('R');
    end;
  end; // AffFonction

begin
  cCourbe := frmCouleurs.choixCouleur;
  bmp := tBitMap.create;
  bmp.width := Larg;
  bmp.height := Haut;
  bmp.pixelformat := pf24bit;

  with bmp.canvas do
  begin
    Pen.mode := pmcopy;
    Pen.Width := 1;
    Brush.Color := clWhite;
    rr := rect(0, 0, bmp.width, bmp.height);
    FillRect(rr);
    yO := bmp.height div 2;
    pen.color := clBlack;
    MoveTo(35, yO);
    LineTo(bmp.width - 5, yO); // axe des x
    moveTo(bmp.width - 25, yO + 2);
    lineTo(bmp.width - 5, yO);
    moveTo(bmp.width - 25, yO - 2);
    lineTo(bmp.width - 5, yO);
    textOut(bmp.width - 25, yO + 8, 'x');
    textOut(5, yO - 7, 'f(x) = 0');
    try
      //Calcul étendue de la plage des x :
      cmp1 := CompAlgGR(JusquaX.a, GR0);
      cmp2 := CompAlgGR(DeX.a, GR0);
      DeXa := StrToFloat(GrToStrE(DeX.a));
      JusquaXa := StrToFloat(GrToStrE(JusquaX.a));
      if (cmp1 <= 0) and (cmp2 <= 0) then
        plagex := abs(JusquaXa) - abs(DeXa)
      else
        plagex := JusquaXa - DeXa;
      if plagex = 0 then
        plagex := 2;
      kx := bmp.width / plagex;
      xO := round(kx * (0 - DeXa));
      //Affichage de la fonction correspondant au tracé si Deg >= 35 :
      if Deg <= 35 then
        AffFonction;
      if xO > 35 then // axe des Y et des i
      begin
        moveTo(xO, yecFF + 5);
        lineTo(xO, bmp.height - 10);
        moveTo(xO - 2, yecFF + 20);
        lineTo(xO, yecFF + 5);
        moveTo(xO + 2, yecFF + 20);
        lineTo(xO, yecFF + 5);
        textOut(xO + 8, yecFF + 15, 'y');
        // Tracer axe des i :
        if iFDeXmax <> 0 then
          for i := -45 to 45 do
          begin
            xec := xO + i;
            yec := round(yO - i * tan(30 * Pi / 180));
            iCoul := round((1 - i / 40) * 180);
            Pixels[xec, yec] := bmpArc.Canvas.Pixels[iCoul, 1];
            if i = -45 then // Tracer flèche
            begin
              moveTo(xec, yec);
              yecF1 := yec - round(15 * tan(20 * Pi / 180));
              lineTo(xec + 15, yecF1);
              moveTo(xec, yec);
              yecF2 := yec - round(15 * tan(40 * Pi / 180));
              lineTo(xec + 15, yecF2);
              textOut(xec, yec + 5, 'i')
            end;
          end;
      end;
      // Tracer courbe :
      courbeInvisible := true;
      ex := true;
      Saut:
      for xec := 0 to bmp.width - 1 do
      begin // "xf.a = DeX.a+xec/kx" :
        xf.a := DivGR(StrToGR(intToStr(xec)), StrToGR(FloatToStr(kx)));
        xf.a := AddGR(DeX.a, xf.a);
        xf.b := GR0;
        try
          yf := F(xf);
          // "yec = yO-round(ky*yf.a)" :
          yfa := StrToFloat(GrToStrE(yf.a));
          yec := yO - round(ky * yfa);
          if (yec < 0) or (yec > bmp.height - 1) then
            ex := true;
          if (yec >= 0) and (yec <= bmp.height - 1) then
          begin
            if ex then
            begin
              ex := false;
              moveTo(xec, yec);
            end
            else
            begin
              iCoul := 180;
              yfb := StrToFloat(GrToStrE(yf.b));
              if courbeInvisible then
                iFDeXmax := abs(yfb)
              else
              begin
                if iFDeXmax <> 0 then
                  iCoul := round((1 + yfb / iFDeXmax) * 180);
              end;

              if cCourbe = -1 then
                pen.color := bmpArc.Canvas.Pixels[iCoul, 1]
              else
                pen.color := cCourbe;
              lineTo(xec, yec);
              courbeInvisible := false;
            end;
          end;
        except
          bmpCourbe := bmp;
          EXIT;
        end;
      end;
      if courbeInvisible then
      begin
        ky := ky / 2;
        goto Saut;
      end;
      // Affichage racines :
      for i := Low(sii) to High(sii) do
        sii[i] := '';
      for i := 0 to slRacinesC.count - 1 do
      begin
        zii[i] := ZZ(i);
        sii[i] := slRacinesC[i];
        xei[i] := round(kx * (StrToFloat(GrToStrE(zii[i].a)) - DeXa));
      end;
      AffRacines;
    except
      info := 'Cas d''exception : Les coefficients de l''équation' + cls
        + 'amènent  à tracer la courbe dans une plage dans' + cls
        + '    laquelle les valeurs de f(x) produisent' + cls
        + '           un débordement de capacité.';
      LRFlotte(info, 30, clBeige, clYellow);
      Courbe.Affichee := False;
      EXIT;
    end;
  end;
  bmpCourbe := bmp;
  Courbe.Affichee := True;
end; // oCourbe.CreebmpCourbe(icCourbe

procedure oCourbe.Affiche;
begin
  CreebmpCourbe;
  if Courbe.Affichee then
  begin
    frmCourbe.imgF.Picture.Graphic := bmpCourbe;
    frmCourbe.imgF.visible := true;
  end;
end;

procedure oCourbe.ReAffiche;
begin
  with frmCourbe.imgF do
    if visible then
    begin
      Picture.Graphic.CleanupInstance;
      bmpCourbe.free;
      CreebmpCourbe;
      Picture.Graphic := bmpCourbe;
    end;
end;

procedure oCourbe.Effacer;
var
  rr: tRect;
  bmp: tbitMap;
begin
  bmp := frmCourbe.imgF.Picture.Bitmap;
  with bmp.Canvas do
  begin
    Brush.Color := clWhite;
    rr := rect(0, 0, bmp.width, bmp.height);
    FillRect(rr);
  end;
end;

procedure oCourbe.free;
begin
  Affichee := false;
  slRacinesX.free;
  slRacinesC.free;
  slCoeffs.free;
  bmpArc.free;
  bmpCourbe.Free;
end;

procedure TfrmCourbe.bAgrandirYClick(Sender: TObject);
begin
  Sablier;
  with courbe do
  begin
    ky := ky * 2;
    ReAffiche;
  end;
  Sablier;
end;

procedure TfrmCourbe.bReduireYClick(Sender: TObject);
begin
  Sablier;
  with Courbe do
  begin
    ky := ky / 2;
    ReAffiche;
  end;
  Sablier;
end;

procedure TfrmCourbe.bAjusterCourbeClick(Sender: TObject);
begin
  Sablier;
  with Courbe do
  begin
    ky := kx;
    ReAffiche;
  end;
  Sablier;
end;

procedure AjusterMemoPanel;
var
  pixparcar, carparli, nli1, nli2: integer;
begin
  with frmCourbe do
  begin
    pixparcar := Canvas.TextWidth('8');
    carparli := (Red1.Width * 155 div 182) div pixparcar;
    nli1 := Red1.GetTextLen div carparli;
    nli2 := Red1.Lines.Count;
    nli1 := max(nli1, nli2);
    if nli1 = 0 then
      nli1 := 1;
    Red1.height := Canvas.TextHeight('8') * nli1 + 6;
    if Red1.height > (imgF.height div 2) - 20 then
      Red1.height := (imgF.height div 2) - 20;
    panel1.height := Red1.height + 14;
  end;
end;

procedure TfrmCourbe.FormResize(Sender: TObject);
begin
  bAjusterCourbe.top := (plGauche.height - bAjusterCourbe.height) div 2;
  bAgrandirY.top := bAjusterCourbe.top - bAgrandirY.height - 4;
  bReduireY.top := bAjusterCourbe.top + bAjusterCourbe.height + 4;
  bEchelles.top := bReduireY.top + 22;
  bImprimer2.top := bAgrandirY.top;
  bSauver2.top := bAjusterCourbe.top;
  bCopier2.top := bReduireY.top;
  Red1.width := imgF.Width;
  with Courbe do
  begin
    Larg := imgF.Width;
    Haut := imgF.Height;
    ReAffiche;
  end;
  AjusterMemoPanel;
end;

procedure TfrmCourbe.bCopier2Click(Sender: TObject);
begin
  Clipboard.Assign(Courbe.bmpCourbe);
  AFlotte('Mis dans presse-papier', 15, clAqua);
end;

procedure TfrmCourbe.bSauver2Click(Sender: TObject);
begin
  SavePictureDialog1.InitialDir := RepAppli;
  SavePictureDialog1.Filter := 'Fichier image (*.bmp)|*.bmp';
  SavePictureDialog1.FileName := 'Courbe.bmp';
  if SavePictureDialog1.execute then
  begin
    Courbe.bmpCourbe.saveToFile(SavePictureDialog1.FileName);
    AFlotte('Sauvé', 15, clAqua);
  end;
end;

procedure TfrmCourbe.bImprimer2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  signe: chn3;
  psuite: tPoint;
  i, Deg: integer;

  procedure ImprimeSi(ss: shortString; expo: integer);
  begin
    if (ss <> '0') and (ss <> '') then
    begin
      if ss[1] = '-' then
      begin
        Delete(ss, 1, 1);
        signe := ' - ';
      end
      else
        signe := ' + ';
      ss := ss + '.x';
      if pos('1.', ss) = 1 then
        Delete(ss, 1, 2);
      psuite := ImprMM(psuite, signe + ss, poNormal);
      if expo > 1 then
        psuite := ImprMM(psuite, intToStr(expo), poExposant);
    end;
  end;

begin
  if button = mbRight then
  begin
    frmMarges.show;
    EXIT;
  end;
  if button = mbLeft then
  begin
    Beg_Doc;
    psuite.x := MargeG * 10; // Dixièmes de mm
    psuite.y := MargeH * 10;

    Deg := Courbe.Deg;
    for i := 0 to Deg do
      ImprimeSi(Courbe.slCoeffs[i], Deg - i);

    psuite := ImprMM(psuite, ' = 0', poNormal);
    psuite := SauteLignes(psuite, 3); // 3 lignes
    psuite.x := xmg; // aligner image à gauche
    psuite := ImprImg(imgF, psuite, 0, 0);
    End_Doc;
  end;
end;

// Convertir une couleur en une couleur héxadécimale

function ColorToHtml(Col: TColor): string;
var
  St: string;
begin
  St := IntToHex(Col, 6);
  Result := '#' + Copy(St, 5, 2) + Copy(St, 3, 2) + Copy(St, 1, 2);
end;

procedure TfrmCourbe.FormCreate(Sender: TObject);
begin
  bReduireY.hint := 'Diviser l''échelle des Y par 2' + cLS
    + '(autant de fois q''il faut' + cLS
    + 'si la courbe n''est visible' + cLS
    + 'qu''en partie)';
  bEchelles.hint := 'Echelles + Couleurs';
  WindowState := wsMaximized;
end;

var
  slRC: tStringList;
  iRacine: integer; // Racines non tronquées classées ordre croissant;
  nbCCNini: int64; // valeur initiale de nbCSGr
  sInfos: string; // message d'accueil

procedure TfrmCourbe.FormShow(Sender: TObject);
var
  i: integer;
begin // Pour le tracé de courbe réduire temporairement les calculs avec nbCsGr=30
  // sinon ralentissement superflu :
  nbCCNini := nbCsGr;
  nbCsGr := 30;
  ActuLgConstantes;

  if Courbe.Affichee then
  begin
    Courbe.Effacer;
    Courbe.free;
  end;
  Courbe.Affiche;
  sInfos := 'Courbe :' + cls + cls
    + '1) Aspect de la courbe :' + cls
    + '   Si la courbe est invisible ou partielle en raison de sa forte croissance' +
      cls
    + '   modifier l''échelle des Y avec le bouton flèche-rouge-vers-bas à gauche' +
      cls + cls
    + '2) Caractéristiques de la courbe :' + cls
    + '   - Click-souris-Gauche : Affiche x-du-Click, y et y'' dans lucarne du bas' +
      cls
    + '   - Click-souris-Droite à proximité d''un Maxi/Mini: Affiche x, y et y'' du Maxi/Mini' +
      cls + cls
    + '3) Pour obtenir y et y'' d''un x quelconque : Saisir x dans la lucarne puis' +
      cls
    + '   valider avec la touche Enter' + cls + cls
    + '4) Un click-souris-Droite sur les bords de la lucarne :' + cls
    + '                - réduit sa hauteur à une seule ligne,' + cls
    + '                - ou rétablit sa hauteur précédente' + cls + cls
    + '5) Les boutons de l''angle extrème-inférieur-droit permettent de faire dérouler les' +
      cls
    + '   racines Non Tronquées dans la lucarne' + cls + cls
    + '   Des info-bulles précisent le rôle de tous les boutons';
  if Courbe.Affichee then
    LRFlotte(sInfos, 30, clBeige, clAqua);
  // Liste des Racines classées dans un ordre croissant :
  slRC := tStringList.create;
  with Equa do
    for i := 1 to Degre do
      slRC.Add(GCToStrE(vRCGC[i]));
  iRacine := 0;
end;

procedure TfrmCourbe.imgFMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  xf, xd, F, D: tGC;
  s: string;
begin
  nbCsGr := nbCCNini;
  ActuLgConstantes;
  xf.a := DivGR(Int64ToGR(X - Courbe.xO), ExtendedToGR(Courbe.kx));
  xf.b := GR0;
  F := Equa.FdeXiniGC(xf);
  if Button = mbLeft then // Affichage de x, y et y' au point du click
  begin
    D := Equa.D1deXiniGCU(xf);
    s := 'Pour x = ' + GCToStrE(xf) + cls
      + '- y  = ' + GCToStrE(F) + cls
      + '- y'' = ' + GCToStrE(D);
  end
  else // Recherche de f'(x) = 0 ou mini et affichage coordonnées Maxi/Mini
  begin
    Sablier;
    Red1.height := 20;
    panel1.height := 34;
    imgF.refresh;
    Red1.text :=
      'Touche Echap si lenteur : renvoie néanmoins valeurs approchées';
    Red1.Update;
    xd := Equa.XANewtonGC(xf); //<- Utilisation de la méthode de Newton
    D := Equa.D1deXiniGCU(xd);
    s := 'Maxima/Minima : ';
    if AbsInfOuEgalALimiteGC(D, ExtendedToGR(1E-20)) then
    begin
      F := Equa.FdeXiniGC(xd);
      s := s + cls + '- En x = ' + GCToStrE(xd) + cls
        + '- y = ' + GCToStrE(F) + cls
        + '- y'' = ' + GCToStrE(D);
    end
    else
    begin
      s := s +
        'Clicker au plus près d''un Maxi/Mini s''il en existe un de réel';
      with Red1 do
      begin
        text := s;
        height := 20;
      end;
      panel1.height := 34;
      Sablier;
      nbCsGr := 30;
      ActuLgConstantes;
      EXIT;
    end;
    Sablier;
  end;
  Red1.text := s;
  Red1.Update;
  AjusterMemoPanel;
  nbCsGr := 30;
  ActuLgConstantes;
end;

procedure TfrmCourbe.imgFMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
//        Affichage coordonnées curseur écran
var
  w, h: integer;
  xe, ye: tGC;
  sxe, sye: string;
begin
  with labCoos do
  begin
    left := X + imgF.left + 6;
    top := Y + imgF.top + 6;

    xe.a := DivGR(Int64ToGR(X - Courbe.xO), ExtendedToGR(Courbe.kx));
    xe.b := GR0;
    sxe := GCToStrECut(xe, 30);

    ye.a := DivGR(Int64ToGR(Courbe.yO - Y), ExtendedToGR(Courbe.ky));
    ye.b := GR0;
    sye := GCToStrECut(ye, 30);
    caption := 'x=' + sxe + cls + 'y=' + sye;
    w := width;
    h := height;
    if left + w > imgF.width then
      left := X + imgF.left - w - 6;
    if top + h > imgF.height then
      top := Y + imgF.top - h - 6;
  end;
end;

procedure TfrmCourbe.plGaucheMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  labCoos.caption := '';
end;

procedure TfrmCourbe.EchellesXetY2Click(Sender: TObject);
var
  s: string;
  k: extended;
begin
  s := 'Echelles suivant X et Y :' + cLS;
  k := Courbe.ky / Courbe.kx;
  s := s + 'Rapport Echelle Y / Echelle X = ' + FloatToStrF(k, ffGeneral, 18, 4)
    + cLS;
  s := s + 'Echelle Y = ' + FloatToStrF(Courbe.ky, ffGeneral, 18, 4) +
    ' pixels/unité' + cLS;
  s := s + 'Echelle X = ' + FloatToStrF(Courbe.kx, ffGeneral, 18, 4) +
    ' pixels/unité' + cLS;
  LRFlotte(s, 30, clBeige, clWhite);
end;

procedure TfrmCourbe.InfosSurCoulClick(Sender: TObject);
var
  s: string;
begin
  s := 'Couleurs de l''arc-en-ciel du tracé de courbe :' + cLS;
  s := s + '- Elles forment l''échelle de la part imaginaire de f(x).' + cLS;
  s := s + '' + cLS;
  s := s + '- Couleur cyan = plages où cette part imaginaire est' + cLS;
  s := s + '  relativement faible ou nulle.' + cLS;
  s := s + '  En conséquence la courbe est cyan si f(x) est réelle.';
  s := s + '' + cLS;
  s := s + '- Du cyan au vert, jaune, orangé, rouge ... la part imaginaire' +
    cLS;
  s := s + '  croît positivement.' + cLS;
  s := s + '' + cLS;
  s := s + '- Du cyan au bleu pâle, bleu foncé, violet ... elle croît' + cLS;
  s := s + '  négativement.' + cLS;
  s := s + '' + cLS;
  s := s + '- Le noir signale les plages où la part imaginaire est' + cLS;
  s := s + '  plus importante qu''elle soit positive ou négative.' + cLS;
  LRFlotte(s, 30, clBeige, clWhite);
end;

procedure TfrmCourbe.Monochrome2Click(Sender: TObject);
var
  cl: tColor;
begin
  cl := frmCouleurs.choixCouleur;
  frmCouleurs.showModal;
  if frmCouleurs.choixCouleur <> cl then
  begin
    with Courbe do
    begin
      cl := frmCouleurs.choixCouleur;
      bmpCourbe.Free;
      cCourbe := cl;
      CreebmpCourbe;
      ReAffiche;
    end;
  end;
  ArcEnCiel2.Checked := cl = -1;
  Monochrome2.Checked := cl <> -1;
end;

procedure TfrmCourbe.ArcEnCiel2Click(Sender: TObject);
begin
  frmCouleurs.choixCouleur := -1;
  ArcEnCiel2.Checked := true;
  Monochrome2.Checked := false;
  with Courbe do
  begin
    bmpCourbe.Free;
    cCourbe := -1;
    CreebmpCourbe;
    ReAffiche;
  end;
end;

procedure TfrmCourbe.bEchellesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p: tPoint;
begin
  p.x := bEchelles.Left + X;
  p.y := bEchelles.Top + Y;
  p := clientToScreen(p);
  PopupMenu1.Popup(p.x, p.y);
end;

procedure TfrmCourbe.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Courbe.Affichee then
    Courbe.free;
end;

procedure TfrmCourbe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CacheFlotte1;
  Red1.clear;
  Red1.height := 20;
  Red1.Update;
  Panel1.height := 34;
  Panel1.Update;
  nbCsGr := nbCCNini;
  ActuLgConstantes;
end;

procedure TfrmCourbe.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ssCtrl in shift then
  begin
    case key of
      65: {A} Red1.SelectAll;
      67: {C} ClipBoard.AsText := Red1.SelText;
      77: {M} frmFlotte2.show; // restitution courante d'une lucarne évanescente
      86: {V}
        begin
          Red1.PasteFromClipboard;
          AjusterMemoPanel;
        end;
      88: {X} Red1.CutToClipboard;
    end;
  end;
end;

procedure TfrmCourbe.Red1KeyPress(Sender: TObject; var Key: Char);
//        Affichage de x, y et y' à partir d'une saisie
const
  esp = ['0'..'9', '+', '-', '.', 'i', '*', 'e', 'E', Chr(VK_BACK)];
var
  x, F, D: tGC;
  s: string;
begin
  if Key = Chr(VK_Return) then
  begin
    try
      nbCsGr := nbCCNini;
      ActuLgConstantes;
      Red1.text := Trim(Red1.text);
      s := Red1.text;
      NettSaisieGC(s);

      x := StrToGC(s);
      F := Equa.FdeXiniGC(x);
      D := Equa.D1deXiniGCU(x);
      s := 'Pour x = ' + GCToStrE(x) + cls
        + '- y  = ' + GCToStrE(F) + cls
        + '- y'' = ' + GCToStrE(D);
      Red1.text := s;
      Red1.Update;
      AjusterMemoPanel;
      nbCsGr := 30;
      ActuLgConstantes;
      Key := #0;
    except
      AFlotte('Pour lancer un calcul : Remplacer le texte par une valeur correcte de x ', 30, clYellow);
      Key := #0;
      EXit;
    end;
  end;
  if Key = 'e' then
    Key := 'E';
  if not (Key in esp) then
    Key := #0;
end;

procedure TfrmCourbe.UpDown1Click(Sender: TObject; Button: TUDBtnType);
//        Rappel des racines non tronquées
begin
  if Button = btNext then
  begin
    Red1.text := slRC[iRacine];
    if iRacine < slRC.Count - 1 then
      inc(iRacine)
    else
      iRacine := 0;
  end
  else if Button = btPrev then
  begin
    Red1.text := slRC[iRacine];
    if iRacine > 0 then
      dec(iRacine)
    else
      iRacine := slRC.Count - 1;
  end;
  Red1.Update;
  AjusterMemoPanel;
end;

var
  Red1HeightPrec: integer;

procedure TfrmCourbe.Panel1DblClick(Sender: TObject);
begin
  with Red1 do
  begin
    if height > 20 then
    begin
      Red1HeightPrec := height;
      height := 20;
    end
    else
      height := Red1HeightPrec;
    if height < 20 then
      height := 20;
  end;
  Panel1.height := Red1.height + 14;
end;

procedure TfrmCourbe.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
  begin
    with Red1 do
    begin
      if height > 20 then
      begin
        Red1HeightPrec := height;
        height := 20;
      end
      else
        height := Red1HeightPrec;
      if height < 20 then
        height := 20;
    end;
    Panel1.height := Red1.height + 14;
  end;
end;

procedure TfrmCourbe.bInfosClick(Sender: TObject);
begin
  LRFlotte(sInfos, 30, clBeige, clYellow);
end;

// Lucarne : Effacer, Copier, Coller, Copier dans Voir +, Imprimer, Sauver

procedure TfrmCourbe.bEffaceLucClick(Sender: TObject);
begin
  with Red1 do
  begin
    clear;
    height := 20;
  end;
  panel1.height := 34;
end;

procedure TfrmCourbe.bCopierLucClick(Sender: TObject);
begin
  ClipBoard.AsText := Red1.SelText;
end;

procedure TfrmCourbe.bCollerDansLucClick(Sender: TObject);
begin
  Red1.PasteFromClipboard;
  AjusterMemoPanel;
  Red1.upDate;
  Red1.Perform(WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TfrmCourbe.bLucVersVoirPlusClick(Sender: TObject);
var
  s: string;
begin
  s := cls + Red1.text;
  TraceZGC(s);
end;

procedure TfrmCourbe.bImprimerLucClick(Sender: TObject);
begin
  Red1.Print('Lucarne caracteristique courbe');
end;

procedure TfrmCourbe.bSauverLucClick(Sender: TObject);
const
  filtre = 'Texte format (*.rtf)|*.rtf|Texte seul (*.txt)|*.txt|tous (*.*)|*.*';
begin
  SaveDialog1.InitialDir := RepAppli;
  SaveDialog1.Filter := filtre;
  SaveDialog1.FileName := 'Caracteristiques_Courbe.rtf';
  if SaveDialog1.execute then
  begin
    Red1.lines.saveToFile(SaveDialog1.FileName);
    AFlotte('Sauvé', 15, clAqua);
  end;

end;

initialization

  Courbe.Affichee := false;

end.

