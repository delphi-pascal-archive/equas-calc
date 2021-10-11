
///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//                       NEWGCENT  par Kinzinger René                        //
//                                   & Geyer Gilbert                         //
//                          (version du 06-04-2010)                          //
//                          (modifiée 16-12-2011)                            //
//       Calculs sur des nombres entiers géants avec Delphi 32 bits          //
//                                                                           //
//           Réalisée pour les compilateurs de Delphi 5,6,7,2009             //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

unit NewGCent;

interface

uses Dialogs, SysUtils;

type
  GCent = ansistring;
  GInt = ansistring;

  // Base du calcul des pseudo-aléatoires
var
  RndGCent: longword;

  // ROUTINES DE MANIPULATIONS DIVERSES ******************************************

  // Renvoie un GCent distinct du Gcent d'origine
function FCopyGCent(Nb: GCent): GCent;

// Idem mais prend une partition de count octets à partir de Start
function FCopyLGCent(Nb: GCent; Start, Count: longword): GCent;

// ROUTINES DE CONVERSIONS *****************************************************

// Convertit une ansistring de digits décimaux ASCII en GCent
function FStrToGCent(St: string): GCent;
// Convertit un GCent en AnsiString de digit décimaus ASCII
function FGCentToStr(Nb: GCent): string;
// Convertit un entier non signé 32 bits en GCent
function FIntToGCent(Nb: longword): GCent;
// Concertit les 5 derniers octets max d'un Gcent en tier non signé 32 bits
function FGCentToInt(Nb: GCent): longword;
// Convertit les 10 derniers octets (max) d'un GCent en Int64
function FGCentToInt64(Nb: GCent): Int64;
// Convertit un Int64 non signé en GCent
function FInt64ToGCent(Nb: Int64): GCent;

// Passerelles vers les GInt
// Convertit un GCent en GInt de même valeur
function FGCentToGInt(Nb: GCent): GInt;
// Convertit un GInt en GCent de même valeur
function FGIntToGCent(Nb: GInt): GCent;

// ROUTINES OPERATOIRES DE BASE SUR LES STRING GCent ***************************

// En principe à ne pas utiliser sans précaution de l'extérieur
function FAdditionne(Nv1, Nv2: GCent): GCent;
function FSoustrait(Nv1, Nv2: GCent): GCent;
function FMultiplie(Nv1, Nv2: GCent): GCent;
procedure PDivMod(Nv1, Nv2: GCent; var Q, R: GCent);

// Renvoie un GCent demi par défaut du GCent
function FDemiGCent(Nv: GCent): GCent;
// Coupe le GCent en deux
procedure PDemiGCent(var Nv: GCent);
// Renvoie un GCent double
function FDoubleGCent(Nv: GCent): GCent;
// Double directement le GCent
procedure PDoubleGCent(var Nv: GCent);
// Renvoie un GCent Nv + 1
function FIncGCent(Nv: GCent): GCent;
// Incrémente directement le GCent
procedure PIncGCent(var Nv: GCent);
// Renvoie un GCent Nv - 1
function FDecGCent(Nv: GCent): GCent;
// Décrémente directement Le GCent
procedure PDecGCent(var Nv: GCent);

// ROUTINES DE TESTS ***********************************************************

// Compare deux Gcent renvoie +1 si Nv1>Nv2; 0 si Nv1=Nv2; -1 si Nv1<Nv2
function IsCompGCent(Nv1, Nv2: GCent): shortInt;
// Renvoie true si le GCent est nul
function IsGCentNul(Nv: GCent): boolean;
// Renvoie true si le GCent est pair
function IsGCentPair(Nv: GCent): boolean;
// Renvoie true si tous les octets du GCent sont à 99
function IsGCentFull(Nv: GCent): boolean;
// Renvoie true si le GCent est multiple de 3
function IsGCentMult3(Nv: GCent): boolean;
// Renvoie true si le GCent est multiple de 5
function IsGCentMult5(Nv: GCent): boolean;
// Renvoie true en P10 si Nv=10^N et le nombre de 0 terminaux
function IsDiv10GCent(Nv: GCent; var P10: boolean): longword;

// ROUTINES DE GENERATIONS RAPIDES *********************************************

// Renvoie un GCent aléatoire de NbDigits décimaux. pair si Odd à true
function FRandomGCent(NbDigits: longword; const Odd: boolean): GCent;

// Renvoie un GCent 10^Exp
function FDixPowerN(Exp: longword): GCent;

// Renvoie un GCent nul
function FGCentNul: GCent;

// Rafraîchit la variable RndGCent
procedure PRndGCentMize;

// ROUTINES des Opérations optimisées sur GCent ********************************

// décalages
// Renvoie un GCent multiplié N fois par 100 (ultra rapide);
function FShlNGCent(Nv: GCent; N: longword): GCent;
// Renvoie un GCent divisé N fois par 100
function FShrNGCent(Nv: GCent; N: longword): GCent;
// Renvoie un GCent multiplié N fois par 10
function FGCentMulN10(Nv: GCent; N: longword): GCent;
// Renvoie un GCent divisé N fois par 10
function FGCentDivN10(Nv: GCent; N: longword): GCent;

// Additions et soustractions
// Renvoie un GCent total de NV1,Nv2
function FAddGCent(Nv1, Nv2: GCent): GCent;
// Ajoute directement un GCent au Premier
procedure PAddGCent(var Nb: GCent; Delta: GCent);
// Renvoie un GCent = Nv1-Nv2
function FSubGCent(Nv1, Nv2: GCent): GCent;
// Soustrait directement un GCent de Nb
procedure PSubGCent(var Nb: GCent; Delta: GCent);
// Renvoie la différence de deux GCent
function FDifGCent(Nv1, Nv2: GCent): GCent;

// Multiplication et division
// Division euclidienne quotient en Q et Reste en R
procedure PDivModGCent(Nv1, Nv2: GCent; var Q, R: GCent);
// Renvoie Nv1 * Nv2
function FMulGCent(Nv1, Nv2: GCent): GCent;
// Renvoie Nv1^Exp
function FExpGCent(Nv: GCent; Exp: longword): GCent;
// Idem Nv1^Exp mais en mode récursif
function FPuissanceGCent(Nv: GCent; Exp: longword): GCent;
// Renvoie la racine entière du GCent
function FRacineGCent(Nb: GCent): GCent;
// Renvoie le carré du GCent
function FCarreGCent(Nb: Gcent): GCent;

// *****************************************************************************

implementation

// GENERATEUR PSEUDO ALEATOIRE *************************************************

// evite les déboires de compilateurs D5,D7

procedure RndDW;
asm
{     ->EAX     Range   }
{     <-EAX     Result  }
        imul    edx,RndGCent,08088405H
        inc     edx
        mov     RndGCent,edx
        mul     edx
        mov     eax,edx
end;

// ROUTINES INTERNES  **********************************************************

// corrige les 0 avant du buffer esi:eax

procedure SansZero;
asm
   @NoZero:
   cmp    eax,1
   je     @retour
   cmp    byte ptr[esi],0
   jne    @retour
   inc    esi
   dec    eax
   jmp    @NoZero
   @retour:
end;

// recopie très vite esi dans edi sur longueur ecx

procedure Recopie;
asm
    push   edx
    mov    edx,ecx
    and    edx,$3
    shr    ecx,2
    cld
    rep    movsd
    mov    ecx,edx
    rep    movsb
    pop    edx
end;

// Compare deux buffers
// en entrée esi;eax et edi;edx
// Retour par le registre des flags
// S:=1 => N1 < N2 ; Z:=1 => N1=N2; S et Z = 0 => N1 > N2

procedure compare;
asm
   push   eax
   push   edx
   mov    ecx,eax
   sub    eax,edx
   jnz    @fin
   xor    ecx,ecx
   @RCmp:
   mov    ah,byte ptr[esi]+ecx
   mov    al,byte ptr[edi]+ecx
   sub    ah,al
   jnz    @fin
   inc    ecx
   dec    edx
   jnz    @RCmp
   @fin:
   pop    edx
   pop    eax
end;

// Renvoie l'adresse d'un buffer de taille size rempli de 0

function GetBuffer(Size: longWord): longword; register;
asm
   push   edi
   push   eax              // réserver longueur
   call   System.@GetMem
   mov    edi,eax          // edi pointe buffer
   pop    ecx              // remise longueur
   push   eax              // sauvegarde adresse retour
   mov    edx,ecx          // calcul des itérations
   and    edx,$3           // reste div/4
   shr    ecx,2            // longueur div 4
   xor    eax,eax          // dword de 0 pour chargements
   cld                     // incrémenter edi
   rep    stosd            // boucle sur dwords complets
   mov    ecx,edx          // boucle sur octets seuls
   rep    stosb
   pop    eax              // remise adresse buffer
   pop    edi
end;

//renvoie en [eax] la chaîne issue d'un buffer en [esi;eax]

procedure ReString; //en entrée, eax contient la longueur du buffer.
asm
   push   edi
   push   edx
   call   SansZero          // enlève les éventuels '0' au départ de esi
   mov    edx,eax
   call   System.@NewAnsiString
   mov    edi,eax
   mov    ecx,edx
   call   Recopie
   pop    edx
   pop    edi
end;

// Incrémente la valeur contenue dans un buffer pointé esi au début
// eax = len(esi) en sortie idem

procedure Plus1;
asm
   mov    ecx,eax
   @RInc:
   dec    ecx
   inc    byte ptr[esi]+ecx
   cmp    byte ptr[esi]+ecx,$64
   jb     @fin
   sub    byte ptr[esi]+ecx,$64
   jmp    @RInc
   @fin:
   test   ecx,ecx
   jge    @Retour
   neg    ecx
   sub    esi,ecx
   add    eax,ecx
   @Retour:
end;

// Décremente la valeur en buffer esi  pointé début
// eax = len(esi) en sortie idem

procedure Moins1;
asm
   mov    ecx,eax
   @RDec:
   dec    ecx
   dec    byte ptr[esi]+ecx
   jns    @fItere
   mov    byte ptr[esi]+ecx,$63
   jmp    @RDec
   @fItere:
   test   ecx,ecx
   jz     @Retour
   call   SansZero
   @Retour:
end;

// Additionne le contenu de edi avec celui de esi pointés en début
// edi<=esi obligatoire
// eax = len(esi)  et edx = len(edi)
// Sortie résultat en esi pointé début et eax = len(esi)

procedure Ajoute;
asm
   push   edx
   push   eax              // conserve len(esi)
   add    edi,edx
   mov    ecx,edx          // ecx, longueur petit
   add    esi,eax          // pointeurs en fins
   mov    edx,eax          // edx, longueur grand
   xor    eax,eax
   // boucle additive des octets du petit
   @RAdd1:
   mov    al,ah
   xor    ah,ah
   dec    esi
   add    al,byte ptr[esi]
   dec    edi
   add    al,byte ptr[edi]
   cmp    al,$64
   jb     @SRAdd1
   sub    al,$64
   inc    ah
   @SRAdd1:
   mov    byte ptr[esi],al
   dec    edx
   loop   @RAdd1
   test   edx,edx
   jz     @Correct
   // boucle additive jusqu'à fin du grand
   @RAdd2:
   mov    al,ah
   xor    ah,ah
   dec    esi
   add    al,byte ptr[esi]
   cmp    al,$64
   jb     @SRAdd2
   sub    al,$64
   inc    ah
   @SRAdd2:
   mov    byte ptr[esi],al
   dec    edx
   jnz    @RAdd2
   // correction si retenue
   @Correct:
   pop    edx         //Remise l grand
   test   ah,ah       // retenue ?
   jz     @Fin        // non
   dec    esi         // oui, octet supplémentaire
   mov    byte ptr[esi],ah
   inc    edx
   @Fin:
   mov    eax,edx
   pop    edx
end;

// Soustrait le contenu de edi au contenu de esi pointés au début
// edi <= esi obligatoire
// eax = len(esi) et edx = len(edi)
// Sortie résultat en esi pointé début et eax = len(esi)

procedure Retire;
asm
   push  edi
   push  esi
   push  edx
   push  eax
   add   edi,edx          // edi pointe sa fin + 1
   mov   ecx,edx
   add   esi,eax          // esi pointe sa fin + 1
   xor   dl,dl            // dl flag de retenue à 0
   @RSub:    // boucle soustractive des octets du petit
   dec   esi
   mov   ah,byte ptr[esi]  // octet cumulateur
   dec   edi
   mov   al,byte ptr[edi]  // octet à retirer
   add   al,dl             // ajouter retenue à retirer
   xor   dl,dl             // raz retenue
   cmp   al,ah             // soustraction possible ?
   jbe   @Sous
   add   ah,$64             // non ajouter 100 au cumul
   inc   dl                // retenir 1
   @Sous:
   sub   ah,al             // soustraire
   mov   byte ptr[esi],ah
   dec   ecx
   jnz   @RSub
   @Rfin:                  // dernières retenues
   test  dl,dl
   jz    @Sortie
   xor   dl,dl
   dec   esi
   cmp   byte ptr[esi],$0
   jne   @SRFin
   add   byte ptr[esi],$64
   inc   dl
   @SRFin:
   dec   byte ptr[esi]
   jmp   @Rfin
   @Sortie:
   pop   eax      // Remise pointages
   pop   edx
   pop   esi
   pop   edi
   call  SansZero
end;

// multiplie edi par ebx et accumule le résultat en esi  pointés au début
// eax = len (edi) edx = len(ebx) ecx = len(esi)
// Sortie esi avec eax=len(esi); edx = len(edi) et ecx=0;

procedure Produit;
var
  Adr, lbx, ldi, lsi, Cent, Dcr, Ret: longword;
asm
   mov    Adr,esi
   mov    ldi,eax
   mov    lsi,ecx
   add    esi,ecx      // remise pointeur esi fin buffer+1
   mov    lbx,edx
   mov    Cent,$64
   add    ebx,edx      // ebx pointe fin + 1 multiplicateur
          // boucle multiplicative sur les octets d'ebx
          @GMul:
          dec    ebx
          xor    ecx,ecx
          mov    cl,byte ptr[ebx] // octet multiplicateur
          test   cl,cl
          jnz    @SMul
          dec    esi
          jmp    @FMul
          @SMul:
          mov    eax,ldi
          add    edi,eax      // edi pointe fin multiplicande + 1
          mov    Dcr,eax      // Dcr compteur ldi
          xor    eax,eax
          mov    Ret,eax       // init retenue à 0
                 // boucle multiplicative des octets d'edi
                 @LMul:
                 dec    edi
                 mov    al,byte ptr[edi]  // octet à multiplier
                 mul    ecx
                 add    eax,Ret       // ajouter retenue
                 div    Cent
                 mov    Ret,eax      // nouvelle retenue
                 dec    esi
                 mov    al,byte ptr[esi]
                 add    eax,edx     // accumuler les unités du produit
                 cmp    eax,Cent    // dépasse 100 ?
                 jb     @SLMul      // non
                 sub    eax,Cent    // oui retirer 100
                 inc    Ret        // et incrémenter retenue
                 @SLMul:
                 mov    byte ptr[esi],al
                 dec    Dcr
                 jnz    @LMul
          dec    esi          // décalage accumulateur d'un octet
          mov    eax,Ret      // dernière retenue-ligne
          add    byte ptr[esi],al
          add    esi,ldi      // remise esi
          @FMul:
          dec    lbx          // itérations multiplicateur
          jnz    @GMul
   // Remise des valeurs et ajustement sortie
   mov    esi,adr
   mov    eax,lsi
   @RZero:                    // chercher 1er byte significatif
   cmp    eax,1
   je     @fin
   cmp    byte ptr[esi],$0
   jne    @fin
   inc    esi                 // placer esi
   dec    eax
   jmp    @RZero
   @fin:
   mov    ecx,lbx
   mov    edx,ldi
end;

// Divise par 2 le buffer pointé début par esi
// en entrée eax = len(esi) idem en sortie

procedure Div2;
asm
    push  eax       // garder longueur
    push  esi       // garder adresse
    mov   ecx,eax   // décompteur boucle
    xor   ah,ah     // registre retenue
       @RDemi:      // boucle Div 2
       mov    al,byte ptr[esi]
       add    al,ah    // ajouter retenue
       xor    ah,ah    // raz retenue
       shr    al,1     // divise byte par 2
       jnc    @SRd     // pas de reste ?
       mov    ah,$64    // si, retenir 100
       @SRd:
       mov    byte ptr[esi],al
       inc    esi    // itération
       dec    ecx
       jnz    @RDemi
    pop   esi       // revenir au départ
    pop   eax
    call  SansZero
end;

// double le buffer pointé par esi en début
// en entrée et sortie eax = len(esi)

procedure Fois2;
asm
   add    esi,eax      //esi pointe fin + 1
   mov    ecx,eax      // ecx décompteur de boucle
   mov    edx,eax      // compteur octets
   xor    ah,ah
     @RDouble:
     dec    esi
     mov    al,byte ptr[esi]
     shl    al,1        // décimal x 2
     add    al,ah       // ajouter retenue
     xor    ah,ah
     cmp    al,$64      // dépasse 100 ?
     jb     @srd
     sub    al,$64       // oui nouvelle retenue
     mov    ah,$1
     @srd:
     mov   byte ptr[esi],al // replace byte
     dec   ecx          // itérations
     jnz   @RDouble
   test  ah,ah        // dernière retenue ?
   jz    @fin         // non
   dec   esi          // oui
   mov   byte ptr[esi],ah
   inc   edx
   @fin:
   mov  eax,edx
end;

// Divise le buffer esi;eax par le buffer edi;edx
// en entrée ecx adresse le buffer du quotient
// Retourne le reste en esi;eax et le quotient en edi;edx

procedure Divise;
var
  N, Pq, Pr, Pa, lq, lr, la: longword;
asm
   // init des variables
   mov      N,0
   mov      Pr,esi
   mov      lr,eax
   mov      Pa,edi
   mov      la,edx
   mov      Pq,ecx
   mov      lq,1
   @BIter:  // boucle de calcul des itérations
   mov      edi,Pr
   mov      edx,lr
   mov      esi,Pa
   mov      eax,la
   call     Compare     // while aux<=R
   jz       @SIter
   js       @SIter
   jmp      @BDiv
   @SIter:
   call     Fois2       // aux:=2*aux
   inc      N           // N:=N+1
   mov      Pa,esi      // paramètres aux
   mov      la,eax
   jmp      @BIter
   @BDiv: // boucle de division proprement dite
   cmp      N,0          // while N>0
   je       @Retour
   dec      N            // N:=N-1
   mov      esi,Pa       // aux:=aux/2
   mov      eax,la
   call     Div2
   mov      Pa,esi
   mov      la,eax
   mov      esi,Pq       // Q:=Q*2
   mov      eax,lq
   call     Fois2
   mov      Pq,esi
   mov      lq,eax
   mov      esi,Pr       // r>=aux ?
   mov      eax,lr
   mov      edi,Pa
   mov      edx,la
   call     Compare
   jz       @SDiv2
   js       @BDiv       // non on boucle
   @SDiv2:
   call     Retire      // oui : R:=R-aux
   mov      Pr,esi
   mov      lr,eax
   mov      esi,Pq      // et Q:=Q+1
   mov      eax,lq
   call     Plus1
   mov      Pq,esi
   mov      lq,eax
   jmp      @BDiv
   @Retour:  // remise des paramètres
   mov     edi,Pq
   mov     edx,lq
   mov     esi,Pr
   mov     eax,lr
end;

// multiplie un buffer esi;eax par 10
// en sortie esi;eax en place

procedure Fois10;
var
  ln: longword;
asm
    push   ecx
    push   edx
    mov    ln,eax
    add    esi,eax            // esi pointe fin buffer+1
    mov    ecx,eax
    xor    edx,edx
    @RShl4:  // boucle de rotation de 4 bits à gauche de tous les bytes
    dec    esi
    mov    al,byte ptr[esi]  // charger ancien octet
    aam                      // décompactage h.ah|b.al
    mov    dh,ah             // garder le haut en haut dx
    mov    ah,al             // passer le bas de ax en haut
    mov    al,dl             // passer le bas de dx en bas de al
    mov    dl,dh             // passer le haut de dx en bas
    aad                      // recombiner nouvel octet
    mov    byte ptr[esi],al  // et replacer
    dec    ecx
    jnz    @RShl4
    test   dl,dl             // dernier octet ?
    jz     @fin              // non
    inc    ln                // oui 1 byte de plus
    dec    esi
    mov    byte ptr[esi],dl
    @fin:                   // remise des paramètres
    mov    eax,ln
    pop    edx
    pop    ecx
end;

// divise un buffer esi;eax par 10
// sortie esi;eax en place

procedure Div10;
asm
   push    eax
   mov     ecx,eax
   xor     edx,edx
   @RShr4:
   mov     al,byte ptr[esi]
   aam
   mov     dl,al
   mov     al,ah
   mov     ah,dh
   mov     dh,dl
   aad
   mov     byte ptr[esi],al
   inc     esi
   dec     ecx
   jnz     @RShr4
   pop     eax
   sub     esi,eax
end;

// Garantit que la copie est une string séparée dans le gestionnaire

function FCopyGCent(Nb: GCent): GCent; register;
asm
   push   esi
   mov    esi,eax
   push   edx
   mov    eax,[esi]-$4
   call   Restring
   mov    esi,eax
   pop    eax
   call   System.@LStrClr
   mov    [eax],esi
   pop    esi
end;

function FCopyLGCent(Nb: GCent; Start, Count: longword): GCent;
asm
   push  esi
   mov   esi,eax
   dec   edx
   add   esi,edx        //esi pointe le Chr de Nb départ
   mov   eax,ecx        // longueur à copier
   call  Restring       // Retour de string sans Zero
   mov   esi,eax
   mov   eax,ebp+$8     // appeler Result
   call  System.@LStrClr // nettoyage Result
   mov   [eax],esi
   pop   esi
end;

// ROUTINES DE CONVERSIONS *****************************************************

function FGCentToGInt(Nb: GCent): GInt; register;
var
  buffer, lb, ls: longInt;
asm
    push   ebx
    push   edi
    push   esi
    push   edx                      // Adr Result
    mov    edi,eax
    mov    eax,[edi]-$04
    add    edi,eax                    // esi : pointe fin StrNb +1
    mov    ebx,eax                    // ebx := length(Nb)
    inc    eax
    mov    lb,eax                    // buffer Ln + 1
    call   System.@GetMem            // obtenir un buffer de longueur de Nb
    mov    buffer,eax
    mov    esi,eax                  // esi : pointe Buffer
    mov    ecx,ebx
    add    esi,ecx                  // esi pointe fin buffer+1
    @AscHexa:  // compactage des chiffres en base 100 en buffer
    dec    edi
    mov    al,byte ptr[edi]
    dec    esi
    mov    byte ptr[esi],al
    dec    ecx
    jnz    @AscHexa
    dec    esi
    xor    ecx,ecx // conversion en base 256
    mov    edx,ecx
    mov    ls,ecx
    mov    byte ptr[esi],0
    @2:
    xor    edx,edx
    mov    al,byte ptr[esi]+edx
    @1:
    mov    ah,$64
    mul    ah
    xor    ch,ch
    mov    cl,byte ptr[esi]+edx+1
    add    ax,cx
    mov    byte ptr[esi]+edx,ah
    inc    edx
    cmp    ebx,edx
    jne    @1
    mov    byte ptr[esi]+edx,al
    inc    ls
    dec    ebx
    jnz    @2
    inc    esi
    mov    eax,ls
    call   restring
    mov    esi,eax              //Result
    pop    eax
    call   System.@LStrClr
    mov    [eax],esi
    pop    esi
    pop    edi
    pop    ebx
    pop    edx
    mov    eax,buffer            //libérer le buffer
    mov    edx,lb
    call   System.@FreeMem
end;

function FGIntToGCent(Nb: GInt): GCent; register;
var
  buffer, lb, ln, ls: longword;
asm
    push    ebx
    push    esi
    push    edi
    push    edx
    mov     esi,eax              // esi pointe nb
    mov     eax,[esi]-$04
    mov     ln,eax              // ln = longueur de Nb
    mov     ecx,$3
    mul     ecx                 // ln x 3
    mov     lb,eax              // réserver un buffer de 3 fois la capacité Nb
    call    System.@GetMem      //obtenir adr buffer
    mov     buffer,eax
    mov     edi,eax            // edi pointe début de buffer
    mov     ecx,ln             // copie de Nb en début buffer
    call    Recopie
    xor     edx,edx  // Conversion des octets en base 100 en fin de buffer
    mov     ls,edx              // compteur octets décimaux
    xor     ecx,ecx
    mov     ebx,$64
    mov     esi,Buffer
    add     esi,lb
    @RConv2:  //lecture, conversion, stockage
    mov     edi,buffer
    mov     ecx,ln
    @RConv1:
    xor     eax,eax
    mov     al,byte ptr[edi]
    mov     byte ptr[edi],0
    inc     edi
    dec     ecx
    jz      @finConv
    test    al,al
    jz      @RConv1
    mov     dl,al
    @RConv0:
    mov     ah,dl
    xor     dx,dx
    mov     al,byte ptr[edi]
    div     bx
    add     byte ptr[edi]-1,ah  // report de retenue
    mov     byte ptr[edi],al    // place quotient
    inc     edi
    dec     ecx
    jnz     @RConv0
    dec     esi
    mov     byte ptr[esi],dl    // sauve dernier reste de ligne ligne
    inc     ls                  // compteur octets convertis
    jmp     @RConv2
    @FinConv:
    xor     dx,dx
    div     bx
    dec     esi
    mov     byte ptr[esi],dl  // dernier reste
    inc     ls
    dec     esi
    mov     byte ptr[esi],al  // dernier quotient
    inc     ls
    mov     eax,ls
    call   Restring
    mov    esi,eax
    pop    eax
    call   System.@LStrClr
    mov   [eax],esi
    pop    edi
    pop    esi
    pop    ebx
    mov    eax,buffer                 //Libérer buffer
    mov    edx,lb
    call   system.@FreeMem
end;

function FStrToGCent(St: string): GCent; register;
asm
   push     esi
   mov      esi,eax       // esi pointe St
   push     edi
   push     ebx
   push     edx
   mov      eax,edx
   call     System.@LStrClr
   mov      eax,[esi]-$4  // eax = len(esi)
   mov      ebx,eax       // garder en ebx
   shr      eax,1
   adc      eax,$0        // moitié arrondie supérieure
   mov      edx,eax
   call     System.@NewAnsiString
   pop      ecx
   mov      [ecx],eax    // Result
   mov      edi,eax
   add      edi,edx      // edi pointe fin Result +1
   add      esi,ebx      // esi pointe fin St+1
   xor      eax,eax
   @RConv:
   mov      ah,$30
   dec      esi
   dec      ebx
   mov      al,byte ptr[esi]
   test     ebx,ebx
   jz       @SConv
   dec      esi
   dec      ebx
   mov      ah,byte ptr[esi]
   @SConv:
   sub      ax,$3030
   aad
   dec      edi
   mov      byte ptr[edi],al
   dec      edx
   jnz      @RConv
   pop      ebx
   pop      edi
   pop      esi
end;

function FGCentToStr(Nb: GCent): string; register;
var
  buf, lnb: longword;
asm
   push    esi
   push    edi
   push    edx         // Result
   mov     edi,eax     // edi pointe Nb
   mov     eax,[edi]-4
   shl     eax,1       // buffer double
   mov     lnb,eax
   call    GetBuffer
   mov     buf,eax
   mov     esi,eax     // esi pointe buffer
   mov     edx,lnb
   mov     ecx,edx
   shr     ecx,1
   xor     eax,eax
   @RConv:            // Boucle conversion en ASCII
   mov     al,byte ptr[edi]
   inc     edi
   aam
   add     ax,$3030
   mov     byte ptr[esi],ah
   inc     esi
   mov     byte ptr[esi],al
   inc     esi
   dec     ecx
   jnz     @RConv
   mov     esi,buf
   mov     eax,edx
   @Rzed:          // éliminer les zéros devant
   cmp     eax,1
   je      @fin
   cmp     byte ptr[esi],$30
   jne     @fin
   inc     esi
   dec     eax
   jmp     @RZed
   @fin:
   call    ReString
   mov     esi,eax
   pop     eax
   call    System.@LStrClr
   mov     [eax],esi
   mov     eax,buf
   mov     edx,lnb
   call    System.@FreeMem
   pop     edi
   pop     esi
end;

{// Convertit une string ASCII décimale en GCent
function FStrToGCent(St : string): GCent;  register;
asm
   push     esi
   mov      esi,eax       // esi pointe St
   push     edi
   push     ebx
   push     edx           // garde Result
   mov      eax,edx
   call     System.@LStrClr
   mov      eax,[esi]-$4  // eax = len(esi)
   mov      ebx,eax       // garder en ebx
   shr      eax,1
   adc      eax,$0        // moitié arrondie supérieure
   mov      edx,eax
   call     System.@NewAnsiString
   pop      ecx
   mov      [ecx],eax    // Result
   mov      edi,eax
   add      edi,edx      // edi pointe fin Result +1
   add      esi,ebx      // esi pointe fin St+1
   xor      eax,eax
   @RConv:
   mov      ah,$30
   dec      esi
   dec      ebx
   mov      al,byte ptr[esi]
   test     ebx,ebx
   jz       @SConv
   dec      esi
   dec      ebx
   mov      ah,byte ptr[esi]
   @SConv:
   sub      ax,$3030
   aad
   dec      edi
   mov      byte ptr[edi],al
   dec      edx
   jnz      @RConv
   pop      ebx
   pop      edi
   pop      esi
end;

// Convertit un GCent en Chaîne d'ASCII décimaux
function FGCentToStr(Nb : GCent): string; register
var buf,lnb : longword;
asm
   push    esi
   push    edi
   push    edx         // Result
   mov     edi,eax     // edi pointe Nb
   mov     eax,[edi]-4
   shl     eax,1       // buffer double
   mov     lnb,eax
   call    GetBuffer
   mov     buf,eax
   mov     esi,eax     // esi pointe buffer
   mov     edx,lnb
   mov     ecx,edx
   shr     ecx,1
   xor     eax,eax
   @RConv:            // Boucle conversion en ASCII
   mov     al,byte ptr[edi]
   inc     edi
   aam
   add     ax,$3030
   mov     byte ptr[esi],ah
   inc     esi
   mov     byte ptr[esi],al
   inc     esi
   dec     ecx
   jnz     @RConv
   mov     esi,buf
   mov     eax,edx
   @Rzed:          // éliminer les zéros devant
   cmp     eax,1
   je      @fin
   cmp     byte ptr[esi],$30
   jne     @fin
   inc     esi
   dec     eax
   jmp     @RZed
   @fin:
   call    ReString
   mov     esi,eax
   pop     eax
   call    System.@LStrClr
   mov     [eax],esi
   mov     eax,buf
   mov     edx,lnb
   call    System.@FreeMem
   pop     edi
   pop     esi
end;}

function FIntToGCent(Nb: longword): GCent; register;
asm
    push   esi
    push   edi
    push   ebx
    push   edx
    mov    ebx,eax
    mov    eax,edx
    call   System.@LStrClr
    // Initialisation du Buffer
    mov    edi,esp      // pointe un buffer de passage sur la pile
    sub    edi,$100
    // conversion
    mov    ecx,$64       // diviseur par 100
    mov    eax,ebx        // Nb à convertir
    xor    ebx,ebx      // compteur octets convertis
    @RDiv:
    xor    edx,edx
    div    ecx          // divise par cent
    dec    edi
    mov    byte ptr[edi],dl // place le reste en buffer
    inc    ebx
    cmp    eax,$64      // terminé ?
    jae    @RDiv        // non
    test   eax,eax      // un reste supplémentaire ?
    jz     @fin         // non
    dec    edi          // oui
    mov    byte ptr[edi],al
    inc    ebx
    // former Result
    @fin:
    mov    eax,ebx
    call   System.@NewAnsiString
    pop    edx
    mov    [edx],eax    // Placer Adr Result
    mov    esi,edi
    mov    edi,eax
    mov    ecx,ebx
    rep    movsb
    // retour
    pop    ebx
    pop    edi
    pop    esi
end;

function FGCentToInt(Nb: GCent): longword; register;
var
  buffer, lb, ls: longInt;
asm
    push   edi
    push   esi
    mov    esi,eax
    mov    eax,[esi]-$04              // ecx := length(Nb)
    add    esi,eax                    // esi : pointe fin StrNb +1
    cmp    eax,$5                     // pas plus de 5 octets
    jbe    @buff
    mov    eax,$5
    @Buff: // obtenir un buffer de n+1 octets valides
    mov    ls,eax
    inc    eax
    mov    lb,eax                    // ln buffer
    call   System.@GetMem
    mov    buffer,eax
    mov    edi,eax
    add    edi,lb                  // edi : pointe fin buffer +1
    mov    ecx,ls
    @Cpy:  // recopier les octets valides en base 100 en fin de buffer
    dec    esi
    mov    al,[esi]
    dec    edi
    mov    [edi],al
    dec    ecx
    jnz    @Cpy
    dec    edi     // edi pointe debut nombre-1
    @AscHexa: // conversion en base 256
    mov    esi,ls
    mov    ls,ecx               // compteurs à 0
    mov    byte ptr[edi],0
    @2:
    xor    edx,edx
    mov    al,[edi]+edx
    @1:
    mov    ah,$64
    mul    ah
    mov    cl,[edi]+edx+1
    add    ax,cx
    mov    [edi]+edx,ah
    inc    edx
    cmp    esi,edx
    jne    @1
    mov    [edi]+edx,al
    inc    ls
    dec    esi
    jnz    @2
    mov    ecx,ls
    xor    edx,edx
    @RR:
    inc    edi
    mov    dl,[edi]
    dec    ecx
    jz     @fin
    shl    edx,8
    jmp    @RR
    @fin:
    mov    esi,edx
    mov    eax,buffer            //libérer le buffer
    mov    edx,lb
    call   System.@FreeMem
    mov    eax,esi               //Result longword
    pop    esi
    pop    edi
end;

function FGCentToInt64(Nb: GCent): Int64; register;
var
  buffer, lb, ls: longInt;
asm
    push   edi
    push   esi
    mov    esi,eax
    mov    eax,[esi]-$04              // ecx := length(Nb)
    add    esi,eax                    // esi : pointe fin StrNb +1
    cmp    eax,$A                     // pas plus de 10 octets
    jbe    @buff
    mov    eax,$A
    @Buff: // obtenir un buffer de n+1 octets valides
    mov    ls,eax
    inc    eax
    mov    lb,eax                    // ln buffer
    call   System.@GetMem
    mov    buffer,eax
    mov    edi,eax
    add    edi,lb                  // edi : pointe fin buffer +1
    mov    ecx,ls
    @Cpy:  // recopier les octets valides en base 100 en fin de buffer
    dec    esi
    mov    al,[esi]
    dec    edi
    mov    [edi],al
    dec    ecx
    jnz    @Cpy
    dec    edi     // edi pointe debut nombre-1
    @AscHexa: // conversion en base 256
    mov    esi,ls
    mov    ls,ecx               // compteurs à 0
    mov    byte ptr[edi],0
    @2:
    xor    edx,edx
    mov    al,[edi]+edx
    @1:
    mov    ah,$64
    mul    ah
    mov    cl,[edi]+edx+1
    add    ax,cx
    mov    [edi]+edx,ah
    inc    edx
    cmp    esi,edx
    jne    @1
    mov    [edi]+edx,al
    inc    ls
    dec    esi
    jnz    @2
    xor    edx,edx
    xor    eax,eax
    mov    ecx,ls
    cmp    ecx,$4
    jbe    @RRLow
    @RRHig: // formation  partie haute du Int64
    inc    edi
    mov    dl,[edi]
    dec    ecx
    cmp    ecx,$4
    je     @RRLow
    shl    edx,8
    jmp    @RRHig
    @RRLow: // formation partie basse du Int64
    inc    edi
    mov    al,[edi]
    dec    ecx
    jz     @fin
    shl    eax,8
    jmp    @RRLow
    @fin:
    mov    esi,eax
    mov    edi,edx
    mov    eax,buffer            //libérer le buffer
    mov    edx,lb
    call   System.@FreeMem
    mov    eax,esi               //Result Int64 en edx:eax
    mov    edx,edi
    pop    esi
    pop    edi
end;

function FInt64ToGCent(Nb: Int64): GCent;
begin
  Result := FStrToGCent(IntToStr(Nb));
    // Delphi fait très bien la conversion du Nb
end;

// ROUTINES DE GENERATIONS RAPIDES *********************************************

function FGCentNul: GCent; register;
asm
  push   ebx
  push   eax
  mov    eax,$1
  call   System.@NewAnsiString
  mov    byte ptr[eax],$0
  mov    ebx,eax
  pop    eax
  call   System.@LStrClr
  mov    [eax],ebx
  pop    ebx
end;

// Renvoie un GCent représentant une valeur décimale de NbDigits chiffres
// Si Odd=true , le GCent est obligatoirement impair sinon parité aléatoire

function FRandomGCent(NbDigits: longword; const Odd: boolean): GCent; register;
var
  lnb: longword;
  P: byte;
asm
   push   ebx
   mov    lnb,eax              // Réserve la longueur
   mov    P,dl                 // sauve parité
   push   ecx
   mov    eax,ecx
   call   System.@LStrClr      // réinitialiser Result
   // calcul de la longueur du futur GCent
   mov    eax,lnb
   shr    eax,1               // NbDigits/2
   adc    eax,0               // arrondi unité supérieure si reste 1
   jnz    @Str
   inc    eax                 // il faut au moins un octet
   // demander la chaîne
   @Str:
   mov    edx,eax
   call   System.@NewAnsiString
   mov    ecx,edx
   pop    edx
   mov    [edx],eax           // affecter son adresse à Result
   mov    byte ptr[eax],0     // init au moins un octet 0
   mov    ebx,eax             // ebx pointeur sur Result
   add    ebx,ecx             // pointeur fin Nb+1
   mov    ecx,lnb             // compteur digit
   test   ecx,ecx
   jz     @fin                // cas où NbDigits=0
   // constituer les octets du GCent
   @RBytes:
   cmp    ecx,1               // Denier octet à un seul digit ?
   je     @DerOctet
   mov    eax,$64             // non alors fourniture aléatoire [0..99]
   call   RndDW
   dec    ebx
   cmp    ecx,lnb             // 1er octet de la fin ?
   jne    @SBytes
   or     al,P                // oui, ajuster la parité
   @SBytes:
   mov    byte ptr[ebx],al
   sub    ecx,2
   jz     @fin
   jmp    @RBytes
   @DerOctet:
   mov    eax,9                // un seul digit  [1..9]
   call   RndDW
   inc    eax
   dec    ebx
   mov    byte ptr[ebx],al
   @fin:
   pop    ebx
end;

procedure PRndGCentMize;
begin
  Randomize;
  RndGCent := RandSeed;
end;

// ROUTINES DE TESTS ***********************************************************

function IsCompGCent(Nv1, Nv2: string): shortInt; register;
asm
   push  esi
   mov   esi,eax
   push  edi
   mov   edi,edx
   mov   eax,[esi]-$4
   mov   edx,[edi]-$4
   call  compare
   mov   al,-1
   js    @fin
   mov   al,1
   jnz   @fin
   mov   al,0
   @fin:
   pop   edi
   pop   esi
end;

function IsGCentPair(Nv: GCent): boolean; register;
asm
   mov   ecx,[eax]-4
   mov   al,byte ptr[eax]+ecx-1
   bt    eax,0
   setnc al
end;

function IsGCentNul(Nv: GCent): boolean; register;
asm
   mov   ecx,[eax]-4
   cmp   ecx,$1
   jne   @fin
   cmp   byte ptr[eax],$0
   @fin:
   setz  al
end;

function IsGCentFull(Nv: GCent): boolean; register;
asm
   push  esi
   mov   esi,eax
   mov   eax,1
   mov   ecx,[esi]-$4
   mov   dl,$63
   @RCmp:
   dec   ecx
   jl    @fin
   cmp   dl,byte ptr[esi]+ecx
   je    @RCmp
   xor   eax,eax
   @Fin:
   pop   esi
end;

function IsGCentMult3(Nv: GCent): boolean;
asm
   push   esi
   mov    esi,eax
   mov    ecx,[esi]-$4
   mov    dx,$0A00
   @Radd:
   dec    ecx
   mov    al, byte ptr[esi]+ecx
   aam
   add    al,ah
   cmp    al,dh
   jb     @DixAl
   sub    al,dh
   inc    al
   @DixAl:
   add    dl,al
   cmp    dl,dh
   jb     @DixDl
   sub    dl,dh
   inc    dl
   @DixDl:
   test   ecx,ecx
   jnz    @RAdd
   xor    ah,ah
   mov    cl,$3
   mov    al,dl
   div    cl
   test   ah,ah
   setz   al
   pop    esi
end;

function IsGCentMult5(Nv: GCent): boolean;
asm
  mov     edx,eax
  xor     eax,eax
  mov     ecx,[edx]-$4
  mov     al,byte ptr[edx]+ecx-1
  aam
  xor     ah,ah
  mov     cl,$5
  div     cl
  test    ah,ah
  setz    al
end;

// CALCULS SUR GCent ***********************************************************

function FShlNGCent(Nv: GCent; N: longword): Gcent; register
var
  lnv, lN: longword;
asm
   push    esi
   push    edi
   push    ecx           // garder Result
   mov     lN,edx        // garder multiplicateur
   mov     esi,eax       // esi pointe Nv
   mov     eax,[esi]-$04 // eax = len(Nv)
   mov     lnv,eax
   add     eax,edx       // longueur nouvelle string
   call    System.@NewAnsiString
   mov     edi,eax       // edi pointe nouvelle string
   pop     eax           // remise result
   call    System.@LStrClr
   mov     [eax],edi
   mov     ecx,Lnv       // recopier le nombre
   call    Recopie
   mov     ecx,Ln        // ajouter les 0
   xor     eax,eax
   rep     stosb
   pop     edi
   pop     esi
end;

function FShrNGCent(Nv: GCent; N: longword): GCent; register
var
  lnv: longword;
asm
   push    esi
   push    edi
   push    ecx           // garder Result
   mov     esi,eax       // esi pointe Nv
   mov     eax,[esi]-$04 // eax = len(Nv)
   sub     eax,edx       // longueur nouvelle string
   mov     lnv,eax
   jg      @SShr
   mov     eax,1        // si <= 0, retour 0
   @SShr:
   call    System.@NewAnsiString
   mov     edi,eax       // edi pointe nouvelle string
   mov     byte ptr[edi],$0
   pop     eax           // remise result
   call    System.@LStrClr
   mov     [eax],edi
   mov     ecx,Lnv       // recopier le nombre
   test    ecx,ecx
   jl      @fin
   call    Recopie
   @fin:
   pop     edi
   pop     esi
end;

function FGCentMulN10(Nv: GCent; N: longword): GCent; register;
var
  Buf, lb, ln, lad, Nn: longword;
asm
   push  esi
   mov   esi,eax      // esi pointe Nv
   push  edi
   push  ecx          // garder Result
   mov   Nn,edx       // garder multiplicateur
   mov   eax,[esi]-4
   mov   ln,eax       // garder longueur Nv
   shr   edx,1        // calculer Nb byte 0
   mov   lad,edx
   add   eax,lad
   inc   eax          // Plus 1 pour éventuel impair
   mov   lb,eax
   call  GetBuffer
   mov   Buf,eax
   mov   edi,Buf
   inc   edi
   mov   ecx,ln
   call  Recopie
   mov   esi,Buf
   inc   esi
   bt    Nn,0         // exposant impair ?
   jnc   @fin          // non
   mov   eax,ln       // oui donc fois dix
   call  Fois10
   @fin:
   mov   esi,Buf
   mov   eax,lb
   call  Restring
   mov   esi,eax
   pop   eax
   call  System.@LStrClr
   mov   [eax],esi    // Result
   pop   edi
   pop   esi
   mov   eax,Buf      // libérer mémoire
   mov   edx,lb
   call  System.@FreeMem
end;

function FGCentDivN10(Nv: GCent; N: longword): GCent; register;
var
  Buf, lb, ln, Nn: longword;
asm
   push    esi
   mov     esi,eax
   mov     Nn,edx
   push    edi
   push    ecx             // Clear Result
   mov     eax,[esi]-4
   mov     ln,eax
   mov     ecx,eax
   shl     ecx,1           // nombre de chiffres suffisants ?
   cmp     edx,ecx
   jl      @PlusGrand      // oui
   @RetZero:               // non retour #0
   mov     eax,1
   mov     lb,eax
   call    GetBuffer
   mov     Buf,eax
   mov     esi,Buf
   mov     eax,1
   jmp     @fin
   @PlusGrand:            // oui, retour tronqué de N chiffres
   shr     edx,1
   sub     eax,edx
   mov     lb,eax
   call    GetBuffer
   mov     Buf,eax
   mov     edi,eax
   mov     ecx,lb
   call    Recopie
   mov     esi,Buf
   mov     eax,lb
   bt      Nn,0
   jnc     @fin
   call    Div10
   @fin:
   call    Restring
   mov     esi,eax
   pop     eax
   call    System.@LStrClr
   mov     [eax],esi    // Result
   pop     edi
   pop     esi
   mov     eax,Buf      // libérer mémoire
   mov     edx,lb
   call    System.@FreeMem
end;

function IsDiv10GCent(Nv: GCent; var P10: boolean): longword; register;
var
  AdP10: longword;
asm
   push  esi
   mov   esi,[edx]
   mov   AdP10,esi
   mov   esi,eax
   mov   ecx,[eax]-4
   add   esi,ecx
   xor   edx,edx      // compteur 0
   @Rbytes0:
   dec   esi
   cmp   byte ptr[esi],0
   jnz   @DerZero
   add   edx,$2
   dec   ecx
   jz    @fin
   jmp   @Rbytes0
   @DerZero: // test du byte non nul pour voir si ses unités=0
   mov   al,byte ptr[esi]
   aam
   test  al,al
   jnz   @fin
   inc   edx
   @fin:
   pop   esi
   mov   eax,edx
end;

// Renvoie une GCent Nv augmentée de 1

function FIncGCent(Nv: GCent): GCent; register;
var
  buffer, lnb: longword;
asm
   push   edi
   push   esi
   mov    esi,eax          //esi pointe Nv
   push   edx              // RAZ Result
   mov    eax,[esi]-4
   mov    lnb,eax
   inc    eax             // buffer de len(Nv) + 1
   call   GetBuffer
   mov    buffer,eax
   mov    edi,eax         // edi pointe buffer
   inc    edi
   mov    ecx,lnb
   call   Recopie
   mov    esi,buffer
   inc    esi
   mov    eax,lnb
   call   Plus1
   call   Restring
   mov    esi,eax
   pop    eax
   call   System.@LStrClr
   mov    [eax],esi      // Result
   pop    esi
   pop    edi
   mov    eax,buffer
   mov    edx,lnb
   inc    edx
   call   System.@FreeMem
end;

// Incrémente directement un GCent

procedure PIncGCent(var Nv: GCent);
begin
  if IsGCentFull(Nv) then
    Nv := FIncGCent(Nv)
  else
    asm
      push   esi
      mov    esi,Nv
      mov    esi,[esi]
      mov    eax,[esi]-4
      call   Plus1
      pop    esi
    end;
end;

// Incrémente directement un GCent de 2

procedure PIncGCent2(var Nv: GCent);
begin
  if IsGCentFull(Nv) or (Nv[1] > #97) then
    Nv := FAddGCent(Nv, #2)
  else
    asm
      push   esi
      mov    esi,Nv
      mov    esi,[esi]
      mov    eax,[esi]-4
      call   Plus1
      call   Plus1
      pop    esi
    end;
end;

// Renvoie un GCent Nv Diminuée de 1

function FDecGCent(Nv: GCent): GCent; register;
var
  buffer, lnb: longword;
asm
   push   edi
   push   esi
   mov    esi,eax          // esi pointe Nv
   push   edx              // Raz Result
   mov    eax,[esi]-4
   mov    lnb,eax         // buffer de len(Nv)
   call   GetBuffer
   mov    buffer,eax
   mov    edi,eax         // edi pointe buffer
   mov    ecx,lnb
   call   Recopie
   mov    esi,buffer
   mov    eax,lnb
   call   Moins1
   call   Restring
   mov    esi,eax
   pop    eax
   call   System.@LStrClr
   mov   [eax],esi
   pop    esi
   pop    edi
   mov    eax,buffer
   mov    edx,lnb
   call   System.@FreeMem
end;

// Décrémente directement un GCent

procedure PDecGCent(var Nv: GCent);
begin
  asm
      push   esi
      mov    esi,[eax]
      mov    eax,[esi]-$4
      call   Moins1
      pop    esi
  end;
  while (ord(Nv[1]) = 0) and (length(Nv) > 1) do
    delete(Nv, 1, 1);
end;

// Renvoie un GCent moitié de l'entrée

function FDemiGCent(Nv: GCent): GCent; register;
var
  buffer, lnb: longword;
asm
    push    esi
    mov     esi,eax      // edi pointe Nv
    push    edi
    push    edx
    mov     eax,[esi]-$4 // demander un buffer de len(Nv)
    mov     lnb,eax
    call    GetBuffer
    mov     edi,eax      // edi pointe buffer
    mov     buffer,eax
    mov     ecx,lnb
    call    Recopie
    mov     esi,buffer
    mov     eax,lnb
    call    Div2
    call    Restring
    mov     esi,eax
    pop     eax
    call    System.@LStrClr
    mov    [eax],esi   // Result
    mov     eax,buffer
    mov     edx,lnb
    call    System.@FreeMem
    pop     edi
    pop     esi
end;

// Divise directement un GCent par 2

procedure PDemiGCent(var Nv: GCent);
begin
  asm
      push    esi
      mov     esi,[eax]
      mov     eax,[esi]-$4
      call    Div2
      pop     esi
  end;
  while (ord(Nv[1]) = 0) and (length(Nv) > 1) do
    delete(Nv, 1, 1);
end;

// Renvoie un GCent double de l'entrée

function FDoubleGCent(Nv: GCent): GCent; register;
var
  buffer, lnb: longword;
asm
    push    esi
    mov     esi,eax      // esi pointe Nv
    push    edi
    push    edx
    mov     eax,[esi]-$4 // demander un buffer de len(Nv)+1
    inc     eax
    mov     lnb,eax
    call    GetBuffer
    mov     edi,eax
    mov     buffer,eax
    mov     ecx,lnb
    dec     ecx
    inc     edi          // edi pointe buffer+1
    call    Recopie
    mov     esi,buffer
    inc     esi
    mov     eax,lnb
    dec     eax
    call    Fois2
    call    Restring
    mov     esi,eax
    pop     eax
    call    System.@LStrClr
    mov    [eax],esi   // Result
    mov     eax,buffer
    mov     edx,lnb
    call    System.@FreeMem
    pop     edi
    pop     esi
end;

// Double Directement un GCent

procedure PDoubleGCent(var Nv: GCent);
begin
  if Ord(Nv[1]) > 49 then
  begin
    Nv := FDoubleGCent(Nv);
    exit;
  end;
  asm
      push    esi
      mov     eax,Nv
      mov     esi,[eax]
      mov     eax,[esi]-$4
      call    Fois2
      pop     esi
  end;
end;

// Renvoie la Chaîne de NV1 + NV2 avec NV1>=NV2 obligatoire

function FAdditionne(Nv1, Nv2: GCent): GCent; register;
var
  buffer, lnb: longword;
asm
   push   esi
   mov    esi,eax        // esi pointe Nv1
   push   edi
   mov    edi,edx
   push   ecx            // Réserve adresse pour Result
   push   edi            // Réserve adresse Nv2
   mov    eax,[esi]-4
   inc    eax            // buffer de len(Nv1)+1
   mov    lnb,eax
   call   GetBuffer
   mov    buffer,eax
   mov    edi,eax
   inc    edi           // edi pointe buffer + 1
   mov    ecx,lnb
   dec    ecx
   call   Recopie       // Copie Nv1 en buffer
   pop    edi           // edi pointe Nv2
   mov    edx,[edi]-4   // edx, len(edi)
   mov    esi,buffer
   mov    eax,lnb
   call   Ajoute
   call   ReString
   mov    esi,eax
   pop    eax
   call   System.@LStrClr
   mov   [eax],esi
   pop    edi
   pop    esi
   mov    edx,lnb       // Libérer buffer
   mov    eax,buffer
   call   System.@FreeMem
end;

// Renvoie la chaîne  Nv1-Nv2 avec Nv1 >= Nv2 obligatoire

function FSoustrait(Nv1, Nv2: GCent): GCent; register;
var
  buffer, lnb: longword;
asm
   push   esi
   mov    esi,eax        // esi pointe Nv1
   push   edi
   mov    edi,edx
   push   ecx            // Réserve adresse pour Result
   push   edi            // Réserve adresse Nv2
   mov    eax,[esi]-4
   mov    lnb,eax
   call   GetBuffer      // buffer de len(Nv1)
   mov    buffer,eax
   mov    edi,eax        // edi pointe buffer
   mov    ecx,lnb
   call   Recopie       // Copie Nv1 en buffer
   pop    edi           // edi pointe Nv2
   mov    edx,[edi]-4   // edx, len(edi)
   mov    esi,buffer
   mov    eax,lnb
   call   Retire
   call   ReString
   mov    esi,eax
   pop    eax
   call   System.@LStrClr
   mov   [eax],esi      // Result
   mov    edx,lnb       // Libérer buffer
   mov    eax,buffer
   call   System.@FreeMem
   pop    edi
   pop    esi
end;

// Renvoie le produit de deux chaîne ASCII  Nv1,Nv2

function FMultiplie(Nv1, Nv2: GCent): GCent; register;
var
  buffer, lnb: longword;
asm
   push   edi
   mov    edi,eax        // placements pointeurs
   push   esi
   push   ebx
   mov    ebx,edx
   push   ecx            // retenue Result
   mov    eax,[edi]-4
   add    eax,[ebx]-4
   inc    eax            // buffer de lnb1+lnb2+1
   mov    lnb,eax
   call   GetBuffer
   mov    buffer,eax
   mov    esi,eax
   mov    eax,[edi]-4
   mov    edx,[ebx]-4
   mov    ecx,lnb
   call   Produit
   call   Restring
   mov    esi,eax
   pop    eax
   call   System.@LStrClr
   mov   [eax],esi        // Result
   pop    ebx
   pop    esi
   pop    edi
   mov    eax,buffer      // libérer buffer
   mov    edx,lnb
   call   System.@FreeMem
end;

// Renvoie le quotient en Q et le reste en R de Nv1/nv2

procedure PDivMod(Nv1, Nv2: GCent; var Q, R: GCent); register;
var
  Buf, lnb, lb, AdrDe, AdrDr, AdrQ, AdrR, Pr, lr, Paux, laux: longword;
asm
  // sauvegardes
  push   esi
  push   edi
  mov    AdrDe,eax      // adresse Dividende
  mov    AdrDr,edx      // adresse Diviseur
  mov    AdrQ,ecx       // adresse du retour quotient
  mov    eax,ecx
  call   System.@LStrClr
  mov    eax,[ebp+$8]
  mov    AdrR,eax       // adresse du retour reste
  call   System.@LStrClr
  // demander un buffer de 3 fois len(dividende)*2
  mov    edi,AdrDe
  mov    ecx,3
  mov    eax,[edi]-4
  shl    eax,1
  mov    lb,eax         // lb = capacité d'un buffer
  mul    ecx
  mov    lnb,eax        // lnb = capacité totale
  call   GetBuffer
  mov    Buf,eax
  // recopier Dividende en fin buf1
  mov    esi,AdrDe
  mov    ecx,[esi]-4
  mov    edi,Buf
  add    edi,lb
  sub    edi,ecx
  mov    Pr,edi         // Pr;lr buffer reste
  mov    lr,ecx
  call   Recopie
  // recopier Diviseur en fin de buf2
  mov    esi,AdrDr
  mov    ecx,[esi]-4
  mov    edi,Buf
  add    edi,lb
  add    edi,lb
  sub    edi,ecx
  mov    Paux,edi
  mov    laux,ecx       // Paux;laux buffer auxilliaire
  call   Recopie
  // appeler la routine de division binaire
  mov    ecx,Buf        // ecx adresse du buffer quotient
  add    ecx,lnb
  dec    ecx
  mov    esi,Pr
  mov    eax,lr
  mov    edi,Paux
  mov    edx,laux
  call   Divise
  // Renvoyer les strings
  call   Restring        // Reste
  mov    esi,AdrR
  mov    [esi],eax
  mov    esi,edi         // Quotient
  mov    eax,edx
  call   Restring
  mov    esi,AdrQ
  mov    [esi],eax
  // libérer la mémoire
  mov    eax,Buf
  mov    edx,lnb
  call   System.@FreeMem
  pop    edi
  pop    esi
end;

function FCarreGCent(Nb: GCent): GCent;
//N² = H²+ M² + B² + 2.(H.M + H.B + M.B)   "N.100^a = ShlNGCent(N,a)"
var
  DecH, DecM: longword;
  H, M, B, H2, M2, HxM, HxB, MxB, SP: GCent;
  function CarrePoly(N: GCent): GCent; register;
    //N² = MH².100^(2.lg) + MB² + 2.(MH.100^lg).MB
  var
    lb, lh: longword;
    MH, MB, D: GCent;
  begin
    if length(N) < 10 then
    begin
      Result := FMulGCent(N, N);
      exit;
    end;
    asm
                 mov  eax,N
                 mov  eax,[eax]-4
                 shr  eax,1
                 mov  lh,eax
                 adc  eax,0
                 mov  lb,eax
    end;
    MH := FCopyLGCent(N, 1, Lh);
    MB := FCopyLGCent(N, lh + 1, Lb);
    Result := FShlNGCent(FMultiplie(MH, MH), lb shl 1);
    if not IsGCentNul(MB) then
    begin
      PAddGCent(Result, FMultiplie(Mb, Mb));
      D := FShlNGCent(FMulGCent(MH, MB), lb);
      PDoubleGCent(D);
      PAddGCent(Result, D);
    end;
  end;
begin
  if length(Nb) > 24 then
  begin
    asm
          xor   edx,edx
          mov   ecx,3
          div   ecx
          mov   DecH,eax
          add   eax,edx
          mov   DecM,eax
    end;
    H := FCopyLGCent(Nb, 1, DecH);
    M := FCopyLGCent(Nb, DecH + 1, DecH);
    B := FCopyLGCent(Nb, 2 * decH + 1, DecM);
    DecH := DecM + DecH;
    // Les carrés :
    H2 := FShlNGCent(CarrePoly(H), DecH shl 1);
    if IsGCentNul(M) then
      M2 := FGCentNul
    else
      M2 := FShlNGCent(CarrePoly(M), DecM shl 1);
    Result := FAddGCent(H2, M2);
    if not IsGCentNul(B) then
      PAddGCent(Result, CarrePoly(B));
    // Les produits :
    if IsGCentNul(M) then
      HxM := FGcentNul
    else
      HxM := FShlNGCent(FMulGCent(H, M), DecH + DecM);
    if IsGCentNul(B) then
      HxB := FGCentNul
    else
      HxB := FShlNGCent(FMulGCent(H, B), DecH);
    if IsGCentNul(M) or IsGCentNul(B) then
      MxB := FGCentNul
    else
      MxB := FShlNGCent(FMulGCent(M, B), DecM);
    // Double somme des produits
    SP := FAddGCent(HxM, HxB);
    PAddGCent(SP, MxB);
    PDoubleGCent(SP);
    PAddGCent(Result, SP);
  end
  else
    Result := FMultiplie(Nb, Nb);
end;

function FAddGCent(Nv1, Nv2: GCent): GCent;
begin
  if IsCompGCent(Nv1, Nv2) >= 0 then
    Result := FAdditionne(Nv1, Nv2)
  else
    Result := FAdditionne(Nv2, Nv1);
end;

// Augmente directement Nb de Delta
// Ne fonctionne que si Nb  est déclaré unique sur le tas

procedure PAddGCent(var Nb: GCent; Delta: GCent);
begin
  if (length(Nb) < length(Delta)) or (ord(Nb[1]) = 99)
    or ((length(Nb) = length(Delta)) and ((ord(Nb[1]) + Ord(Delta[1])) > 98))
      then
    Nb := FAddGCent(Nb, Delta)
  else
    asm
      push    esi
      push    edi
      mov     eax,Nb
      mov     esi,[eax]
      mov     eax,[esi]-$4
      mov     edi,Delta
      mov     edx,[edi]-$4
      call    Ajoute
      pop     edi
      pop     esi
    end;
end;

// Calcule la différence entre deux GCent;

function FDifGCent(Nv1, Nv2: GCent): GCent;
begin
  if IsCompGCent(Nv1, Nv2) >= 0 then
    Result := FSoustrait(Nv1, Nv2)
  else
    Result := FSoustrait(Nv2, Nv1);
end;

function FSubGCent(Nv1, Nv2: GCent): GCent;
begin
  if IsCompGCent(Nv1, Nv2) <= 0 then
    Result := FGCentNul
  else
    Result := FSoustrait(Nv1, Nv2);
end;

// Diminue directement Nb de Delta
// Ne fonctionne que si Nb est déclaré unique sur le tas
// ne peut fonctionner que si Nb>Delta

procedure PSubGCent(var Nb: GCent; Delta: GCent); register;
var
  Transit: GCent;
  B: boolean;
begin
  asm
      mov     B,0
      push    esi
      push    edi
      mov     eax,Nb
      mov     esi,[eax]
      mov     eax,[esi]-$4
      push    eax              // garder ancienne longueur
      mov     edi,Delta
      mov     edx,[edi]-$4
      call    Retire
      pop     ecx              // remise longueur
      cmp     eax,ecx          // nouvelle = ancienne ?
      je      @fin             // adresse inchangée
      call    Restring         // nouvelle string
      mov     Transit,eax
      mov     B,1
      @fin:
      pop     edi
      pop     esi
  end;
  if B then
    Nb := Transit; // Partie rajoutée pour éviter les fuites de mémoire
end;

// Div et Mod avec message d'erreur sur div 0

procedure PDivModGCent(Nv1, Nv2: GCent; var Q, R: GCent);
begin
  Q := FGCentNul;
  R := FCopyGCent(Nv1);
  if IsGCentNul(Nv2) then
  begin
    ShowMessage('Tentative de division par zéro');
    Exit;
  end;
  if IsCompGCent(Nv1, Nv2) < 1 then
    exit;
  PDivMod(Nv1, Nv2, Q, R);
end;

function FMulGCent(Nv1, Nv2: GCent): GCent;
begin
  if IsGCentNul(Nv1) or IsGcentNul(Nv2) then
    Result := FGCentNul
  else
    Result := FMultiplie(Nv1, Nv2);
end;

// Calcule Nb^Exp et redonne un GCent

function FExpGCent(Nv: GCent; Exp: longword): GCent;
var
  sousProd: GCent;
  i, nK, DeuxPN: longword;
  function NDiv2(ExpoReduit: longword): longword;
  asm
            mov   edx,eax    // edx = ExpoReduit
            xor   eax,eax    // eax = ndiv
            @NotOdd:         // tant que exp pair
            bt    edx,0
            jc    @fin
            shr   edx,1     // ExpoReduit div 2
            inc   eax       // Inc NDiv
            jmp   @NotOdd
            @fin:
            mov   ecx,eax
            xor   edx,edx   // Calcul DeuxPN
            bts   edx,ecx
            mov   DWord ptr[DeuxPN],edx
  end;
begin
  if Exp = 1 then
  begin
    Result := Nv;
    exit;
  end;
  Result := #1;
  if Exp = 0 then
    exit;
  DeuxPN := 0;
  while Exp - DeuxPN <> 0 do
  begin
    sousProd := Nv;
    Exp := Exp - DeuxPN;
    nk := NDiv2(Exp);
    for i := 1 to nK do
      sousProd := FMultiplie(sousProd, sousProd);
    Result := FMultiplie(Result, sousProd);
  end;
end;

function FPuissanceGCent(Nv: GCent; Exp: longword): GCent;
//       Récursive : Renvoie Nb^Exp avec Exp >= 1
var
  tmp: GCent;
  ModExp: byte;
begin
  Result := #1;
  if Exp = 0 then
    Exit
  else if Exp = 1 then
  begin
    Result := Nv;
    Exit;
  end;
  asm
            shr   Exp,1
            setC  al
            mov   ModExp,al
  end;
  tmp := FPuissanceGCent(Nv, Exp);
  Result := FMultiplie(tmp, tmp);
  if ModExp = 1 then
    Result := FMultiplie(Result, Nv);
end;

function FDixPowerN(Exp: longword): GCent; register;
var
  Buf, LBuf: longword;
asm
  push    esi
  mov     ecx,1         // 1er octet
  shr     eax,1         // calcul Nb octets retour
  jnc     @S1
  mov     ecx,$A
  @S1:
  push    edx          // garde result
  push    ecx          // garde 1er octet
  inc     eax          // longueur de la chaîne
  mov     LBuf,eax
  call    GetBuffer    // buffer plein de 0
  mov     Buf,eax
  mov     esi,eax
  pop     eax          // Rappel 1er octet
  mov     byte ptr[esi],al
  mov     eax,LBuf
  call    Restring
  mov     esi,eax     // Chaîne retour en esi
  pop     eax         // Rappel Result
  call    System.@LStrClr // Raz Result
  mov     [eax],esi   // Nouvelle chaîne en Result
  pop     esi
  mov     eax,Buf     // libérer le Buffer
  mov     edx,LBuf
  call    System.@FreeMem
end;

function FRacineGCent(Nb: GCent): GCent;
var
  i, j, imax: longword;
  sTranche, vTranche, DernImpair: GCent;
  cmp, nbSoust, dOctet: ShortInt;
  T: boolean;
begin // Exit sur cas particuliers :
  Result := #0;
  if (Nb = '') or (Nb = #0) then
    Exit;
  Result := #1;
  if Nb = #1 then
    Exit;
  asm
            xor   eax,eax
            mov   j,eax
            mov   dOctet,al
            mov   eax,Nb
            mov   eax,[eax]-$4
            mov   imax,eax
            mov   edx,eax
            shr   edx,$1
            setc  T
            adc   edx,0
            mov   eax,Result
            call  System.@LStrSetLength
  end;
  DernImpair := FIntToGCent(1);
  VTranche := '';
  for i := 1 to imax do
  begin
    vTranche := vTranche + Nb[i];
    sTranche := FCopyGCent(vTranche);
    nbSoust := 0;
    cmp := isCompGCent(sTranche, DernImpair);
    while cmp >= 0 do
    begin
      PSubGCEnt(vTranche, DernImpair);
      Inc(nbSoust);
      PIncGCent(DernImpair);
      PIncGCent(DernImpair);
      cmp := isCompGCent(vTranche, DernImpair);
    end;
    if cmp < 0 then
    begin
      PDecGCent(DernImpair);
      PDecGCent(DernImpair);
    end;
    PIncGCent(DernImpair);
    DernImpair := FGCentMulN10(DernImpair, 1);
    PIncGCent(DernImpair);
    asm
                    cmp   T,0
                    jne   @Plein
                    mov   al,nbSoust
                    mov   dOctet,al
                    jmp   @Retour
                    @Plein:
                    mov   eax,Result
                    call  System.UniqueString
                    mov   edx,eax
                    mov   ecx,j
                    mov   al,nbSoust
                    mov   ah,dOctet
                    aad
                    mov   [edx]+ecx,al
                    inc   j
                    @Retour:
                    xor   T,$1
    end;
  end;
end; // FRacineGCent

//******************************************************************************

initialization

  PRndGCentMize;

end. // end of unit

