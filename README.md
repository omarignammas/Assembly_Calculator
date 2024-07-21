# Assembly_Calculator

Explication du Code Assembly :

    ;verification de l'operation choisi cad la cle que va l'utilisateur va tapez

    cmp bl, '+'  
    je addition       ;l'addition de deux chiffres  => a + b
    
    cmp bl, '-'
    je soustraction   ;la soustraction de deux chiffres => a - b
    
    cmp bl, '*'
    je multiplication ; multiplcation de deux chiffres =>  a * b
    
    cmp bl, '/'
    je division     ;division al/bl  je traite aussi le cas de la division par 0
    
    cmp bl, '!'
    je factoreil    ; calcul factoreil /5! = 1*2*3*4*5
    
    cmp bl, '^'     ;produit du meme chiffre n fois
    je puissance 
    
    cmp bl, 'A'     ; A(n,p) = n !/(n-p) !
    je arrangement 
    
    cmp bl, 'C'     ; C(n,p) = n !/(p ! *(n-p) !)
    je combinaison
    
    cmp bl, 'p'     ; PGCD : le plus grand commun diviseur entre deux nombres
    je p    
    
    jmp error       ;si l'utilisateur entre une autre operation different que  les operations disponibles


chaque procedure, j'ecrit sont script en echangant le valeur entre les differents registres .
l'utilisation de differents operation de l'assembleur comme mul , add et div  .
j'utilise aussi d'autres procedure qui utilise des interruptions aidants comme:
etq:           
    ;lire l'operation saisi
    mov al,0h
    mov dx,offset op1    ; message d'operation
    mov ah,09h           ; interruption d'affichege d'un message
    int 21h
 comme l'affichage du message de menu qui introduit les operations disponibles

;recupuration d'un variable d'un interruption et la stocker dans num1  
mov dx,offset mssge1
    mov ah, 09        ;interruption d'affichage
    int 21H
    mov ah, 01        ;interruption de recupuration du key d'entre et la stocker sous code ASCUI dans le registre al
    int 21H
    sub al, 30h       ;convertir le code ASCUI a un nombre ,par soustraction de 30h cad 48 en decimal
    mov num1, al      ;stocker le nombre entrer dans une variable

;procedure d'affichage d'un resultat calculee  
affiche:
mov al,0h
mov al,res    ;stocker le resultat calculer dans al
add al,30h    ; apres l'affichage du resultat du calcul,on doit d'abord le convertir en ASCUI apres l'afficher.
mov dl,al     ; stocker le resultat dans dl pour l'afficher par une interruption
mov ah,02h    ;afficher le resultat de deux chiffres, chiffre par chiffre
int 21h
jmp etq
;La procédure Convertir a pour objectif de convertir un nombre représenté 
par une valeur ASCII en son équivalent en chaîne de caractères ASCII 
représentant les chiffres du nombre. Cette procédure utilise la division 
et la conversion ASCII pour accomplir cette tâche,
c'ect pour cela j'ai l'introduire dans presque tous mes procedures d'operations.
Convertir:     
push cx        ; Sauvegarde la valeur du registre CX sur la pile. CX est utilisé comme compteur dans la division ultérieure.
mov cl,10      ;initialisation du registre par 10 , Cela représente la base décimale dans laquelle le nombre doit être converti.
xor ah,        ;Initialise le registre AH à zéro. Il sera utilisé comme le quotient de la division.
div cl         ;Divise le contenu des registres AX par CL. AX contient les chiffres ASCII du nombre, et CL représente la base décimale (10). Le résultat de la division est stocké dans AX (quotient) et AH (reste).
add ax, 3030h  ;Ajoute la valeur ASCII de '0' (30h) à chaque chiffre du quotient pour obtenir le chiffre ASCII correspondant. 
pop cx          ; Restaure la valeur précédemment sauvegardée du registre CX à partir de la pile.
mov bl,ah
mov dl,al
mov ah,02h      ; Configure le registre AH avec la fonction d'affichage de caractère DOS.
int 21h         ;affiche le caractère représenté par la valeur ASCII de DL
mov al,bl 
mov dl,al
mov ah,02h      ;configure a nouveau le registre pour afficher le douxieme chiffre
int 21h 
==> en resumee cette proc utilise une division répétée par la base 10 pour extraire chaque chiffre ,et affiche chaque chiffre convertit tout seule. 
---------------------------------------------------------------------------------------------------------------------------------------------------

Les difficultés que j'ai face durant l'implementation de ce programme :

1- D'abord Les opérations de manipulation des registres, y compris les opérations arithmétiques et logiques,
 peuvent être délicates. Il est essentiel de comprendre comment utiliser correctement les registres pour effectuer des calculs et stocker des données,et parfoit je suive le processus de mon programme  steps by steps  
,soudaineemnet je perdu ma valeur sois a cause d'une autre operation comme cmp ou int 21h ,ou j'oublie d'initialiser le registre que je veut utiliser , et j'essay de  biSen bricoler mon code  pour que 
je protege la valeur que j'aurai besoin a utiliser  dans une autre operation .

2- La gestion des erreurs, telle que la division par zéro ou la saisie d'une opération incorrecte, peut être complexe en assembleur.mais doit mettre en place des mécanismes pour détecter et gérer ces situations 
et parfoits vous trouver tres difficiles a introduire ces mecanismes qui peut impacter sur les performance de votre code generalement et le passage  enter les registres cad l'enchainement logiaue de votre code .

3- En général, la programmation en assembleur exige une attention particulière aux détails cad on utilise single steps pour bienn comprender ou vous allez et est ce que le passage de votre entre les differentes registre et variable  et correcte pour atteindre un resultat  correcte a la fin , une compréhension approfondie des concepts bas niveau et une patience lors du débogage. 
Mais reste  ce programme une bonne oppoertunitee pour bien familiariser avec ce type de language de bas niveau et de bien comprendre combien la machine est bete devant les capacitees humain ,Alhamdoli'Allah.
