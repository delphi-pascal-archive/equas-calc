program Equations_Calculette8;

uses
  Forms,
  uConstPrecalculees in 'uConstPrecalculees.pas',
  uEquas8 in 'uEquas8.pas' {frmEquas7},
  uFun2 in 'uFun2.pas' {frmFun},
  uFlotte2 in 'uFlotte2.pas' {frmFlotte2},
  uMarges in 'uMarges.pas' {frmMarges},
  uCourbe in 'uCourbe.pas' {frmCourbe},
  uCouleurs in 'uCouleurs.pas' {frmCouleurs},
  UcalcGR in 'UcalcGR.pas' {frmCalcGR},
  uTrace in 'uTrace.pas' {frmTrace},
  uAPropos in 'uAPropos.pas' {frmAPropos},
  UnitGC in 'UnitGC.pas',
  UnitGR in 'UnitGR.pas',
  NewGCent in 'NewGCent.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmEquas7, frmEquas7);
  Application.CreateForm(TfrmFun, frmFun);
  Application.CreateForm(TfrmFlotte2, frmFlotte2);
  Application.CreateForm(TfrmMarges, frmMarges);
  Application.CreateForm(TfrmCourbe, frmCourbe);
  Application.CreateForm(TfrmCouleurs, frmCouleurs);
  Application.CreateForm(TfrmCalcGR, frmCalcGR);
  Application.CreateForm(TfrmTrace, frmTrace);
  Application.CreateForm(TfrmAPropos, frmAPropos);
  Application.Run;
end.

