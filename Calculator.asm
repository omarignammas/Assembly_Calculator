org 100h

jmp etq

    op1 db 10,13,"'+':pour l'addition entre 0-9 : $"
    op2 db 10,13,"'-':pour la soustraction entre 0-9 : $"
    op3 db 10,13,"'*':pour la multiplication entre 0-9 : $"
    op4 db 10,13,"'/':pour la division entre 0-9 : $"
    op5 db 10,13,"'!':pour le factoreil entre 0-4 : $"
    op6 db 10,13,"'^':pour la puissance entre 0-5 et chiffre entre 0-9 : $"
    op7 db 10,13,"'A':pour l'arrangement entre 0-5 : $"
    op8 db 10,13,"'C':pour la combinaison entre 0-5 : $"
    op9 db 10,13,"'p':pour le PGCD entre 0-9 : $"
    
    op10 db 10,13,"-----------------------------------------------------------------------$"
    
    
    
    mssge0 db 10,13,"Saisir n : $"       
    mssge1 db 10,13,"Saisir num1 : $"
    mssge2 db 10,13,"Saisir num2 : $" 
    mssge4 db 10,13,"Saisir la puissance : $"
    mssge3 db 10,13,"Tapez une operation('+' - '-' - '*' - '/' - '!' - '^' - 'A' - 'C' - 'p') : $"
    result db 10,13,"Resultat : $"
    prob db 10,13,"error:vous pouvez pas cette operation : $"

    num1 db ?
    num2 db ?
    res  db ?
                
etq:           
    ;lire l'operation saisi
    mov al,0h
    mov dx,offset op1
    mov ah,09
    int 21h
    
    mov al,0h
    mov dx,offset op2
    mov ah,09
    int 21h
    
    mov al,0h
    mov dx,offset op3
    mov ah,09
    int 21h
    
    mov al,0h
    mov dx,offset op4
    mov ah,09
    int 21h 
    
    mov al,0h
    mov dx,offset op5
    mov ah,09
    int 21h
    
    mov al,0h
    mov dx,offset op6
    mov ah,09
    int 21h
    
    mov al,0h
    mov dx,offset op7
    mov ah,09
    int 21h
    
    mov al,0h
    mov dx,offset op8
    mov ah,09
    int 21h
    
    mov al,0h
    mov dx,offset op9
    mov ah,09
    int 21h
    
    mov al,0h
    mov dx,offset op10
    mov ah,09
    int 21h
    
    mov al,0h
    mov dx,offset mssge3
    mov ah,09
    int 21h
    mov ah,01
    int 21h
    mov bl,al ;je convertit de l'ASCUI au numerique par soustracter 48 
    

    
    ;verification de l'operation choisi cad la cle que va l'utilisateur va tapez
    cmp bl, '+'
    je addition 
    
    cmp bl, '-'
    je soustraction
    
    cmp bl, '*'
    je multiplication 
    
    cmp bl, '/'
    je division 
    
    cmp bl, '!'
    je factoreil 
    
    cmp bl, '^'
    je puissance 
    
    cmp bl, 'A'
    je arrangement 
    
    ;cmp bl, 'C'
    ;je combinaison
    
    cmp bl, 'p'
    je p    
    
    jmp error
      
  
addition:

    ;lire num1
    mov dx,offset mssge1
    mov ah, 09
    int 21H
    mov ah, 01
    int 21H
    sub al, 30h
    mov num1, al

    ;lire num2
    mov al,0h
    mov dx, offset mssge2
    mov ah, 09
    int 21H
    mov ah, 01
    int 21H
    sub al, 30h
    mov num2, al
    mov res,al
    mov dx, offset result
    mov ah, 09h  
    int 21h 
    mov al, num1
    add al, num2 
    cmp al,9
    jg convertir   
    jmp affiche

soustraction:
    ;lire num1
    mov dx,offset mssge1
    mov ah, 09
    int 21H
    mov ah, 01
    int 21H
    sub al, 30h
    mov num1, al

    ;lire num2
    mov dx, offset mssge2
    mov ah, 09
    int 21H
    mov ah, 01
    int 21H
    sub al, 30h
    mov num2,al
    cmp num1,al
    jl  affiche_neg
    mov al,num1 
    sub al, num2
    mov res,al
    mov dx, offset result
    mov ah, 09h  
    int 21h
    jmp affiche  
    
affiche_neg:
      sub al,num1
    mov res,al
    mov dx, offset result
    mov ah, 09h  
    int 21h
    mov dl, '-'
    mov ah, 02h
    int 21h
    jmp affiche  
      

multiplication:
    ;lire num1
    mov dx,offset mssge1
    mov ah, 09
    int 21H
    mov ah, 01
    int 21H
    sub al, 30h
    mov num1, al

    ;lire num2
    mov dx, offset mssge2
    mov ah, 09
    int 21H
    mov ah, 01
    int 21H
    sub al, 30h
    mov num2, al
    mov al, num1
    mul num2
    jmp affiche  
    

division:
    ;lire num1
    mov dx,offset mssge1
    mov ah, 09
    int 21H
    mov ah, 01
    int 21H
    sub al, 30h
    mov num1, al

    ;lire num2
    mov dx, offset mssge2
    mov ah, 09
    int 21H
    mov ah, 01
    int 21H
    mov ah,0h
    sub al, 30h
    mov num2, al
    mov al, num1
    mov bl,num2 
    cmp bl,0
    je  error
    div bl 
    mov res,al
    mov dx, offset result
    mov ah, 09h  
    int 21h
    jmp affiche      

factoreil:
    mov dx,offset mssge0
    mov ah, 09
    int 21H
    mov ah, 01
    int 21H
    sub al, 30h
    mov num1, al
    mov cl, num1
    mov al, 01
    facto: 
        mov res,al
        mul cl
        cmp cl,0
        je  et
        loop facto
et:
    mov dx, offset result
    mov ah, 09h  
    int 21h
    mov ax,0h
    mov al,res
    cmp al,09h
    jg convertir
    jmp affiche 
    

puissance:
    ;lire num1
    mov dx,offset mssge1
    mov ah, 09
    int 21H
    mov ah, 01
    int 21H
    sub al, 30h
    mov num1, al

    ;lire num2
    mov dx, offset mssge4
    mov ah, 09
    int 21h
    mov ah, 01
    int 21h
    sub al, 30h
    mov num2, al
    mov cl, num2
    mov al, 01
    puiss:
     mov res,al
     mul num1
     cmp cl,0
     je  aff
     loop puiss 
aff:
    mov dx, offset result
    mov ah, 09h  
    int 21h
    mov al,res
    cmp al,9
    jg convertir
    jmp affiche    

arrangement:
 
    ;Lire num1
    mov dx, offset mssge1
    mov ah, 09
    int 21h
    mov ah, 01
    int 21h
    sub al, 30h
    mov num1, al

    ;Lire num2
    mov dx, offset mssge2
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    sub al, 30h
    mov num2, al

    ;Calculer n!
    mov ah, 0
    mov al, num1
    mov cl, al
    mov al, 01
    facto1: 
        mov res,al
        mul cl
        cmp cl,0
        je  et1
        loop facto1

et1:

    ;Stocker le resultat dans res
    ;mov res, al
    ;Calculer (n - p)!
    mov ah, 0h
    mov al,num1
    sub al, num2
    mov cl, al
    mov al, 01
    facto2:
        mov bl, al 
        mul cl
        cmp cl,0
        ;mov al,res
        je  et2
        loop facto2

et2: 

    ;Diviser n! par (n - p)!
    mov al,res
    mov ah,0h
    div bl
    ;Stocker res
    mov res, al
    mov dx, offset result
    mov ah, 09h  
    int 21h
    mov al,res
    cmp al,9
    jg convertir
    jmp affiche

    
 
p:  

    ;lire num2
    mov dx, offset mssge2
    mov ah, 09
    int 21H
    mov ah, 01
    int 21H
    sub al, 30h
    mov num2, al   
    mov bl, num2
    ;lire num1
    mov al,0h
    mov dx,offset mssge1
    mov ah, 09
    int 21H
    mov ah, 01
    int 21H
    sub al, 30h
    mov num1, al 
    mov al, num1
    pgcd:
        cmp al, bl
        je etq1
        ja etq2
        jb etq3
    etq2:
        sub al, bl
        jmp pgcd
    etq3:
        sub bl, al
        jmp pgcd
    etq1:
    mov res,al
    mov dx, offset result
    mov ah, 09h  
    int 21h
    jmp affiche 
       

error:
    ; Afficher un message d'erreur
    mov dx, offset prob
    mov ah, 09
    int 21h  
    
  
affiche:
mov al,0h
mov al,res
add al,30h
mov dl,al
mov ah,02h
int 21h
jmp etq
   

Convertir:     
push cx
mov cl,10
xor ah, ah
div cl
add ax, 3030h
pop cx 
mov bl,ah
mov dl,al
mov ah,02h     
int 21h
mov al,bl 
mov dl,al
mov ah,02h     
int 21h  
jmp etq  
ret



