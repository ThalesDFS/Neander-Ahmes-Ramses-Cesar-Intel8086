;Nome: Thales Duarte Flores Santos / Cartao: 00288563

		 assume cs:codigo,ds:dados,es:dados,ss:pilha

CR       EQU    0DH ; constante - codigo ASCII do caractere "carriage return"
LF       EQU    0AH ; constante - codigo ASCII do caractere "line feed"

;COLINHA
;db =8bit ;DW - Define Word. Generally 2 bytes on a typical x86 32-bit system;DD - Define double word. Generally 4 bytes on a typical x86 32-bit system
;AH, AL, BH, BL, CH, CL, DH e DL =8bit
;AX, BX, CX e DX =16bit
; EAX, EBX, ECX, EDX.=32bit

;db   'ABCDE'     ; 0x41 0x42 0x43 0x44 0x45                (5 bytes)
;dw   'ABCDE'     ; 0x41 0x42 0x43 0x44 0x45 0x00           (6 bytes, 3 words)
;dd   'ABCDE'     ; 0x41 0x42 0x43 0x44 0x45 0x00 0x00 0x00 (8 bytes, 2 doublewords)
;dq   'ABCDE'     ; 0x41 0x42 0x43 0x44 0x45 0x00 0x00 0x00 (8 bytes, 1 quadword)

; definicao do segmento de dados do programa
dados    segment
mensagem db     'teste $'
nome      db 64 dup (?)
coluna      db 64 dup (?)
linha      db 64 dup (?)

trocou   db     1           ; indicador de troca no "bubble sort"
AchouInicio   db     0           ; indicador de troca no "bubble sort"
AchouIgual   db     0           ; indicador de troca no "bubble sort"
AchouSinal   db     0           ; indicador de troca no "bubble sort"
AchouSinal1  db     0           ; indicador de troca no "bubble sort"
AchouNumero  db     0           ; indicador de troca no "bubble sort"
movimentolongo db     0           ; indicador de troca no "bubble sort"
AchouVirgula  db     0           ; indicador de troca no "bubble sort"
AchouMOVE  db     0           ; indicador de troca no "bubble sort"
erroInicialX  db     0           ; indicador de troca no "bubble sort"
erroInicialY  db     0           ; indicador de troca no "bubble sort"
achoufim  db     0           ; indicador de troca no "bubble sort"
quantidadeDeNumeros  db     0           ; indicador de troca no "bubble sort"
Digito1  db     0           ; indicador de troca no "bubble sort"
Digito2  db     0           ; indicador de troca no "bubble sort"
Digito3  db     0           ; indicador de troca no "bubble sort"
Digito4  db     0           ; indicador de troca no "bubble sort"
Digito5  db     0           ; indicador de troca no "bubble sort"


endl   DB  0Dh,0Ah          ; CR & LF (DOS)

Ver01  db     0           ; indicador de troca no "bubble sort"
Escrever02  dw     ?,0           ; indicador de troca no "bubble sort"

Ponto  dw    0           ; indicador de troca no "bubble sort"
nomeSaida db ?,'.','r','e','l'
NegativoX  db     0           ; indicador de troca no "bubble sort"
NegativoY  db     0           ; indicador de troca no "bubble sort"
Y db 0
Jogando db 0
SomaX dw 0
SomaY dw 0
SomaParaFazer dw 0
CoordX   dd     0           ; indicador de troca no "bubble sort"
CoordY   dd     0           ; indicador de troca no "bubble sort"
mynumber1 db ?
string   db     79 dup(' ') ; string a ser ordenado e exibido
NomeMeu db     'Nome: Thales Duarte Flores Santos / Cartao: 00288563$'
acabouSemfim db     'Erro: O programa terminou sem encontrar FIM$'
Comparar db     'Nome: Thales Duarte Flores Santos / Cartao: 00288563$'
acabouSemInicio  db     'O Programa acabou sem encontrar o INICIO$'
acabouSemIgual  db     'Erro: O Programa acabou devido a falta de algum "="$'
FimPeloEnter db     'O programa foi encerrado .-. (Porque Voce nao digitou nada)$'
erroiniciox db     'Erro: O valor Inicial X esta fora da faixa -32768 e +32767',CR,LF,'$'
erroinicioY db     'Erro: O valor Inicial Y esta fora da faixa -32768 e +32767',CR,LF,'$'
valornnomov db     'Erro: Existe uma distancia de movimento negativa',CR,LF,'$'
movimentomuitolongo db 'Erro: existe uma distancia do movimento maior do que 32767',CR,LF,'$'
mensagemDespedida db 'O programa foi finalizado com sucesso. Tenha um otimo fim de dia!',CR,LF,'$'
 filename db "sera.txt", 0
pede_nome db 'Nome do arquivo: ','$'

buffer    db 128 dup (?)
erro      db 'Erro! Repita.',CR,LF,'$'
handler   dw ?
handlerSaida   dw ?
variavel  db ?,'$'
dados    ends


pilha    segment stack 
         dw     128 dup(?)
pilha    ends
         

codigo   segment
.386
inicio:  
         mov    ax,dados 
         mov    ds,ax    
         mov    es,ax   
		 
	      ;APRESENTA NOME
		  call apagaTela
		  
		  lea    dx,nomeMeu 	
          mov    ah,9      
          int    21h          
		  
		  mov   dh,1       
          mov   dl,0       
		  mov    ah,2       
          mov    bh,0       
          int    10h 
		  ;APRESENTA NOME
		  
		  ;RECEBE O NOME DO ARQUIVO (O arquivo base para esse trecho eh o 'learquivo')====================================
 de_novo: 
 mov trocou,1
 mov Ponto,0
 lea    dx,pede_nome 
          mov    ah,9     
          int    21h      
		  
		  lea    di, nome
		  
entrada:  
		  mov ah,03h ;sempre que chegar aqui, vai ver em que linha que esta (Isso eh para limitar caracteres que o usuario pode digitar e para o backspace nao sobrepor o "Nome Do Arquivo:")
		  mov bh,0
		  INT 10h
		  mov linha,dh
		 
	
		  mov    ah,1
          int    21h	
		  cmp    al,CR   
          je     continua
		  
		  cmp 	al, 08h
		  backs:
		  je  	backspace
		   
			
		 mov ah,03h
		 mov bh,0
		 INT 10h
		 cmp dl,39
		 ja  naovolta2
		  
		  
		 
		  cmp 	al,2EH
		  jne  voltaaqui
		  add Ponto,1
		  
		 
		  
voltaaqui:
		  mov     trocou,0
          mov    [di],al ; 
          inc    di
          jmp    entrada
		  
		  naovolta2: 
			mov    dl, 08h          
			mov    ah,2              
			int    21h  
			mov    dl, ' '         
			mov    ah,2             
			int    21h  
			mov    dl, 08h        
			mov    ah,2             
			int    21h   
             
			mov dh, linha
			mov dl, 39
			mov bh, 0
			mov ah, 2
			int 10h 
			jmp entrada
		

		 
	
		  
		  
continua: 

		 
		  
		  cmp trocou,1
		  
		  jnz foi
		  lea    dx,fimPeloEnter 
          mov    ah,9    
          int    21h       
	      
		  mov    ax,4c00h          
          int    21h                  
foi:
		  mov   byte ptr [di],0  
          mov    dl,LF  
          mov    ah,2
          int    21h
		  
		  
; abre arquivo para leitura 
		

cmp Ponto,0
jna jsud
	     mov    ah,3dh ;funcao arquivo
         mov    al,0 ;ler
         lea    dx,nome
         int    21h
         jnc    abriu_ok
		 lea    dx,erro  
         mov    ah,9     
         int    21h     
         jmp    de_novo
jsud:
mov Ponto,0

         mov    ah,3dh ;funcao arquivo
         mov    al,0 ;ler
         lea    dx,nome
         int    21h
         jnc    abriu_ok
		 mov 	al, '.'
		 mov    [di],al
		 inc    di
		 mov 	al,'m'
		  mov    [di],al
		 inc    di
		 mov 	al,'o'
		  mov    [di],al
		 inc    di
		 mov 	al,'v'
		  mov    [di],al
		 inc    di
		 mov   byte ptr [di],0 
          mov    dl,LF   
          mov    ah,2
          int    21h
		   mov    ah,3dh ;funcao arquivo
         mov    al,0 ;ler
         lea    dx,nome
         int    21h
         jnc    abriu_ok
         lea    dx,erro  
         mov    ah,9     
         int    21h      
         jmp    de_novo
		 
		 abriu_ok: 
		 
	    
		 
		 mov handler,ax
		 ;RECEBE O NOME DO ARQUIVO (O arquivo base para esse trecho eh o 'learquivo')====================================
		 
		 ;CRIA ARQUIVO DE SAIDA COM BASE NO NOME DO ARQUIVO DE ENTRADA======================================
		 dec di
		 mov al,'l'
		 mov    [di],al
		 dec    di
		 mov 	al,'e'
		 mov    [di],al
		 dec    di
		 mov al,'r'
		 mov    [di],al
		 add di,3
		 mov   byte ptr [di],0
		 
		 mov ah, 3ch         
		 lea dx, nome       
         mov cx, 0         
         int 21h            
         jc fim
		mov handlerSaida, ax   
		 
		 call apagaTela
		
		 ;CRIA ARQUIVO DE SAIDA COM BASE NO NOME DO ARQUIVO DE ENTRADA======================================
		 
		 ;PROCURA "INICIO" no arquivo==============================================
laco:    
		call podeser
		
		call procuraInicio
		
		cmp AchouInicio,1
		je 	comecou
	
         mov dl, buffer	 ; escreve na tela até encontrar um LF (fim de linha)
         cmp dl, LF
         jne laco
		 

        
         jmp laco
	 
		 jmp fim
		
		;PROCURA "INICIO" no arquivo==============================================
		
		;PROCURA o "=" logo depois do INICIO ====================================
comecou: 
    
         call podeser
		 call procuraIgual
		 cmp AchouIgual,1
		 je  comecou2
		 cmp buffer,LF
		 jne comecou
		 mov AchouIgual,0
		 jmp fim
		;PROCURA o "=" logo depois do INICIO ====================================
		 
		 ;PROCURA SINAL DE NEGATIVO NAS COORDS INICIAIS (OU APENAS O NUMERO), ATE ENCONTRAR UMA VIRGULA ====================================
		 comecou2:
		 call podeser
		 call procuraSinal
		 call procuraNumero
		 call procuraVirgula
		 
		 
		 cmp AchouNumero,1
		 jne NaotratarNumero
		 call tratarNumero
		 jmp comecou2
		 
		 NaotratarNumero:
		 cmp AchouVirgula,1
		 jne naoAchouVirgula
		 call comecou3
		 jmp comecou4
		 
		 naoAchouVirgula:
		 jmp comecou2

			 ;PROCURA SINAL DE NEGATIVO NAS COORDS INICIAIS (OU APENAS O NUMERO), ATE ENCONTRAR UMA VIRGULA ====================================
			 
			 ;FAZ A MESMA COISA PARA A COORD Y (MAS DESSA VEZ NAO ESPERA VIRGULA)=====================================================================
		comecou4:
		
		mov Y,1
		cmp AchouSinal,0
		je positivotest;negativo 
		mov NegativoX,1
		;===========
		cmp SomaX,32768
		jna positivo;valor ok
		mov erroInicialX,1
		jmp fim
		;========
		
		positivotest:
		cmp SomaX,32767
		jna positivo;valor ok
		mov erroInicialX,1
		jmp fim
		
		positivo:
		mov AchouSinal,0
		mov quantidadeDeNumeros,0
		mov Digito1,0
		mov Digito2,0
		mov Digito3,0
		mov Digito4,0
		mov Digito5,0
		
		comecou4laco:
		call podeser
		call procuraSinal
		call procuraNumero
		
		 cmp AchouNumero,1
		 jne NaotratarNumeroY
		 call tratarNumero;precisoColocarNoY
		 jmp comecou4laco
		 
		 NaotratarNumeroY:
		 
		 mov dl, buffer	 ; escreve na tela até encontrar um LF (fim de linha)
         cmp dl, LF
         je fimInicio
		 jmp comecou4laco
		 
		 fimInicio:
		 call comecou3
		 cmp AchouSinal,0
		 je positivoTestY ;negativoy
		 mov NegativoY,1
		 cmp SomaY,32767
		jna positivoY;valor ok
		mov erroInicialY,1
		jmp fim
		
		 positivoTestY:
		 
		mov ax,SomaY
	
		cmp SomaY,32768
		jb positivoY;valor ok
		mov erroInicialY,1
		jmp fim
		 
		  ;FAZ A MESMA COISA PARA A COORD Y (MAS DESSA VEZ NAO ESPERA VIRGULA)=====================================================================
		 
		 positivoY:
		mov AchouSinal1,0
		 call EscreverAtual
		 
		 ;LOOP PRINCIPAL, FAZ COMPARACOES DE "FIM" "MOVE" "=" "COORD DE MOVE" etc...
		 DENOVOATEOFIM:
		 mov SomaParaFazer,0
		 mov Digito1,0
		 mov Digito2,0
		 mov Digito3,0
		 mov Digito4,0
		 mov Digito5,0
		 mov quantidadeDeNumeros,0
		 mov AchouVirgula,0
		 mov AchouIgual,0
		 mov achouMOVE,0
		 
		 COMECOUPRAVALER:
		   
		 call podeser
		 call procuraIgual
		 call procuraNumero
		 call procuraVirgula
		 call procurafim
		 
		 call procuraMOVE
		 
		 cmp achoufim,1
		 jne aindacontinua
		 jmp faznada
aindacontinua:		 
		 cmp achouMOVE,1
		 je vamosUsarALinha
		 ignoralinha:
		 call podeser
		 cmp buffer,LF
		 jne ignoralinha
		 jmp DENOVOATEOFIM
		 
		 vamosUsarALinha:
		 
	     cmp buffer,3DH
		 jne semigual
		 mov AchouIgual,1
		 semigual:
	   
		 cmp buffer,2DH
		 jne movSemSinal
		 mov AchouSinal1,1
		 jmp fim
		 movSemSinal:
		 
		 cmp AchouNumero,1
		 jne NaotratarNumeroValer
		 
		 call tratarNumero
		 jmp COMECOUPRAVALER
		 
		 NaotratarNumeroValer:
		 cmp AchouVirgula,1
		 jne naoAchouVirgulaJogo

		 call praOnde
		 
		 jmp DENOVOATEOFIM
		 
		 naoAchouVirgulaJogo:
		 jmp COMECOUPRAVALER
		 
		 
		 jmp fim
		 
		  
         mov ah,8	 
         int 21h
		 jmp comecou4laco
		
		 jmp fim
		 
	;LOOP PRINCIPAL, FAZ COMPARACOES DE "FIM" "MOVE" "=" "COORD DE MOVE" etc...
	
	;'FUNCAO' BACKSPACE (SEMELHANTE AO EXEMPLO QUE CONTEM BACKSPACE)========================
backspace:
		 mov ah,03h
		 mov bh,0
		 INT 10h
		 cmp dl,17
		 jb  naovolta
		 mov trocou,0
		
   		mov    al,' '
		 mov    [di],al 
         inc    di
		  
		 mov    dl,' '           
         mov    ah,2              
         int    21h   
		 
		 mov    dl,08h          
         mov    ah,2              
         int    21h
         dec    di                
		 
		 mov    dl,' '           
         mov    ah,2             
         int    21h     
         mov    dl,08h          
         mov    ah,2             
         int    21h
         dec    di                
		lodsb
		cmp byte ptr [di],2EH
		jne naoapagaponto
		
		sub Ponto,1
		
		naoapagaponto:
		
         mov    byte ptr [di],' ' 
         inc    cx                
         jmp    entrada           


naovolta:
 mov    trocou,1
 mov    dl,' '            ; escreve um espaco na posicao
 mov    ah,2              ; em que esta o cursor na tela
 int    21h  
 mov dh, linha
 mov dl, 17
 mov bh, 0
 mov ah, 2
 int 10h 
 
 jmp entrada
 
 
 ;'FUNCAO' BACKSPACE (SEMELHANTE AO EXEMPLO QUE CONTEM BACKSPACE)========================
 
apagaTela PROC
mov ax, 1003h
mov bx, 0 ; disable blinking.
int 10h

		mov   al,0        
          mov   bh,0F9h     
          mov   ch,0        
          mov   cl,0        
          mov   dh,24       
          mov   dl,79       
          mov   ah,6        
          int   10h         
			
		  mov   dh,0        
          mov   dl,0       
		  
		  mov   ah,2       
          mov   bh,0       
          int   10h        
			ret
			apagaTela endp
			
praOnde PROC
 
;FUNCAO VER TECLA (a,w,s,d), A "MAIN", SEMPRE QUE ENCONTRAR UMA VIRGULA, VAI PROCURAR UM CARACTERE============================================
mov Jogando,1
call comecou3
 cmp SomaParaFazer,32767
		 jna verdigito
		 mov movimentolongo,1
		 jmp fim
	 
		 
verdigito:
cmp AchouIgual,1
je linhaok
jmp fim
linhaok:

call podeser
cmp buffer,61H ;a
je aok
cmp buffer,41H;A
je aok
jmp naoEha
aok:
mov ax,SomaX
cmp NegativoX,0
je apositivo

mov cx,SomaParaFazer
loopamais:
add ax,1
cmp ax,32769
jne naotroucou
mov ax,32767
mov NegativoX,0
jmp loopa
naotroucou:
loop loopamais
mov SomaX,ax
 mov    dx,LF        
		 mov    ah,2 
		 int 21h
call EscreverAtual
ret

apositivo:
mov cx,SomaParaFazer

loopa:
sub ax,1
cmp ax,65535
jne naotrocou2
mov ax,0
mov NegativoX,1
jmp loopamais
naotrocou2:
loop loopa


mov SomaX,ax
 mov    dx,LF         
		 mov    ah,2 
		 int 21h
call EscreverAtual
ret

naoEha:
cmp buffer,73H;s
je sok
cmp buffer,53H;S
je sok
jmp naoEhb

sok:
mov ax,SomaY
cmp NegativoY,0
je spositivo

mov cx,SomaParaFazer
loopamaissi:
add ax,1
cmp ax,32769
jne naotroucous
mov ax,32767
mov NegativoY,0
jmp naotrocous
naotroucous:
loop loopamaissi
mov SomaY,ax
 mov    dx,LF         
		 mov    ah,2 
		 int 21h
call EscreverAtual
ret

spositivo:
mov cx,SomaParaFazer

loopas:
sub ax,1
cmp ax,65535
jne naotrocous
mov ax,0
mov NegativoY,1
jmp loopamaissi
naotrocous:
loop loopas


mov SomaY,ax
 mov    dx,LF         
		 mov    ah,2 
		 int 21h
call EscreverAtual
ret
;==========================

naoEhb:
cmp buffer,64H;d
je dok
cmp buffer,44H;D
je dok
jmp naoEhd
;===========================================

dok:
mov ax,SomaX
cmp NegativoX,0
jne dpositivo

mov cx,SomaParaFazer
loopamaisd:
add ax,1
cmp ax,32768
jne naotroucoud
mov ax,32768
mov NegativoX,1
jmp naotrocoud
naotroucoud:
loop loopamaisd
mov SomaX,ax
 mov    dx,LF         
		 mov    ah,2 
		 int 21h
call EscreverAtual
ret

dpositivo:
mov cx,SomaParaFazer

loopared:
sub ax,1
cmp ax,65535
jne naotrocoud
mov ax,0
mov NegativoX,0
jmp loopamaisd
naotrocoud:
loop loopared


mov SomaX,ax
 mov    dx,LF         
		 mov    ah,2 
		 int 21h
call EscreverAtual
ret


naoEhd:
cmp buffer,77H;w
je wok
cmp buffer,57H;W
je wok
jmp naoEhw
;==========================================
wok:
mov ax,SomaY
cmp NegativoY,0
jne wpositivo

mov cx,SomaParaFazer
loopamaisw:
add ax,1
cmp ax,32768
jne naotroucouw
mov ax,32768
mov NegativoY,1
jmp naotrocouw
naotroucouw:
loop loopamaisw
mov SomaY,ax
 mov    dx,LF        
		 mov    ah,2 
		 int 21h
call EscreverAtual
ret

wpositivo:
mov cx,SomaParaFazer

loopablue:
sub ax,1
cmp ax,65535
jne naotrocouw
mov ax,0
mov NegativoY,0
jmp loopamaisw
naotrocouw:
loop loopablue


mov SomaY,ax
 mov    dx,LF         
		 mov    ah,2 
		 int 21h
call EscreverAtual
ret

naoEhw:
jmp verdigito
;VER TECLA ======================
praOnde endp


;FUNCAO VER TECLA (a,w,s,d), A "MAIN", SEMPRE QUE ENCONTRAR UMA VIRGULA, VAI PROCURAR UM CARACTERE============================================			

;ESTA FUNCAO PEGA AS COORDS DE MOVE, E AS COLOCA NA VARIAVEL "SOMAPARAFAZER", ESSA VARIAVEL EH UTILIZADA PELA FUNCAO VER TECLA (PARA SUBTRAIR DO TOTAL OU SOMAR...)
comecou3 proc
		
		cmp quantidadeDeNumeros,1
		jne maisdeumdigito
		movzx ax,Digito1

		cmp Jogando,1
		jne continuaNormal
		add SomaParaFazer,ax
		ret

		continuaNormal:
		cmp Y,1
		jne X
		add SomaY,ax
		ret
		X: 
		add SomaX,ax
		ret
			
		maisdeumdigito:
		cmp quantidadeDeNumeros,2
		jne maisdedoisdigitos
		movzx ax,Digito1
		mov bx,10
		imul bx
		movzx cx,Digito2
		add ax,cx
		cmp Jogando,1
		jne continuaNormal1
		add SomaParaFazer,ax
		ret
		
		continuaNormal1:
		cmp Y,1
		jne X1
		add SomaY,ax
		ret
		X1:
		add SomaX,ax;
		ret
		
		maisdedoisdigitos:
		cmp quantidadeDeNumeros,3
		jne maisdetresdigitos
		movzx ax,Digito1
		mov bx,100
		imul bx
		cmp Jogando,1
		jne continuaNormal2
		add SomaParaFazer,ax 
        jmp nextD		
		continuaNormal2:
		cmp Y,1
		jne X2
		add SomaY,ax
		jmp nextD
		X2:
		add SomaX,ax
		nextD:
		movzx ax,Digito2
		mov bx,10
		imul bx
		movzx cx,Digito3
		add ax,cx
		cmp Jogando,1
		jne continuaNormal3
		add SomaParaFazer,ax
		ret
		continuaNormal3:
		cmp Y,1
		jne X3
		add SomaY,ax
		ret
		X3:
		add SomaX,ax
		ret
		
		maisdetresdigitos:
		cmp quantidadeDeNumeros,4
		jne maisdequatrodigitos
		movzx ax,Digito1
		mov bx,1000
		imul bx
		cmp Jogando,1
		jne continuaNormal4
		add SomaParaFazer,ax
		jmp nextD1
		continuaNormal4:
		cmp Y,1
		jne X4
		add SomaY,ax
		jmp nextD1
		X4:
		add SomaX,ax
		nextD1:
		movzx ax,Digito2
		mov bx,100
		imul bx
		cmp Jogando,1
		jne continuaNormal5
		add SomaParaFazer,ax
		jmp nextD2
		continuaNormal5:
		cmp Y,1
		jne X5
		add SomaY,ax
		jmp nextD2
		X5:
		add SomaX,ax
		nextD2:
		movzx ax,Digito3
		mov bx,10
		imul bx
		movzx cx,Digito4
		add ax,cx
		cmp Jogando,1
		jne continuaNormal6
		add SomaParaFazer,ax
		ret
		continuaNormal6:
		cmp Y,1
		jne X6
		add SomaY,ax
		ret
		X6:
		add SomaX,ax
		ret
		
		maisdequatrodigitos:
		movzx ax,Digito1
		mov bx,10000
		imul bx
		cmp Jogando,1
		jne continuaNormal7
		add SomaParaFazer,ax
		jmp nextD3
		continuaNormal7:
		cmp Y,1
		jne X7
		add Somay,ax
		jmp nextD3
		X7:
		add SomaX,ax
		nextD3:
		movzx ax,Digito2
		mov bx,1000
		imul bx
		cmp Jogando,1
		jne continuaNormal8
		add SomaParaFazer,ax
		jmp nextD4
		continuaNormal8:
		cmp Y,1
		jne X8
		add SomaY,ax
		jmp nextD4
		X8:
		add SomaX,ax
		nextD4:
		movzx ax,Digito3
		mov bx,100
		imul bx
		cmp Jogando,1
		jne continuaNormal9
		add SomaParaFazer,ax
		jmp nextD5
		continuaNormal9:
		cmp Y,1
		jne X9
		add SomaY,ax
		jmp nextD5
		X9:
		add SomaX,ax
		nextD5:
		movzx ax,Digito4
		mov bx,10
		imul bx
		movzx cx,Digito5
		add ax,cx
		cmp Jogando,1
		jne continuaNormal10
		add SomaParaFazer,ax
		ret
		
		continuaNormal10:
		cmp Y,1
		jne X10
		add SomaY,ax
		ret
		
		X10:
		add SomaX,ax
		ret
comecou3 endp	
		
;ESTA FUNCAO PEGA AS COORDS DE MOVE, E AS COLOCA NA VARIAVEL "SOMAPARAFAZER", ESSA VARIAVEL EH UTILIZADA PELA FUNCAO VER TECLA (PARA SUBTRAIR DO TOTAL OU SOMAR...)

;FUNCAO MUITO IMPORTANTE, TODO CODIGO EH BASEADO NELA, ELA LE UM CARACTERE DO ARQUIVO ATE O FINAL
podeser PROC
		 mov ah,3fh      ; le um caracter do arquivo
         mov bx,handler
         mov cx,1
         lea dx,buffer
         int 21h
         cmp ax,cx
         je retornar
		 mov achouigual,1
		 jmp fim
		 retornar:
		 ret
podeser endp
;FUNCAO MUITO IMPORTANTE, TODO CODIGO EH BASEADO NELA, ELA LE UM CARACTERE DO ARQUIVO ATE O FINAL
		 
		 ;PROCURA FIM======================
		procurafim PROC
	     cmp buffer,66H
		 je fok
		 cmp buffer,46H;F
		 jne naoEhInicio
		 
		 fok:
		 call podeser
		 cmp buffer,69H;i
		 je ifimok
		 cmp buffer,49H;I
		 jne naoEhInicio
		 
		 ifimok:
		 call podeser
		 cmp buffer,6DH;m
		 je mok
		 cmp buffer,4DH;M
		 jne naoEhInicio	
		mok:
		mov achoufim,1
		ret
		naoehfim:
		ret
		procurafim endp
		 ;PROCURA FIM======================
		
		procuraMOVE PROC
		 cmp buffer,6DH;m
		 je mok2
		 cmp buffer,4DH;M
		 jne naoEhMOVE
		mok2:
		 call podeser
		 cmp buffer,6FH;o
		 je ook2
		 cmp buffer,4FH;O
		 jne naoEhMOVE
		ook2:
		call podeser
		 cmp buffer,76H;v
		 je vok2
		 cmp buffer,56H;V
		 jne naoEhMOVE
		vok2:
		call podeser
		 cmp buffer,65H;e
		 je eok2
		 cmp buffer,45H;E
		 jne naoEhMOVE
		eok2:
		mov achouMOVE,1
		ret
		naoEhMOVE:
		ret
		procuraMOVE endp

		procuraInicio PROC
         
		 ;--PROCURA INICIO
		 cmp buffer,69H
		 je Iok
		 cmp buffer,49H;I
		 jne naoEhInicio
		 
		 Iok:
		 call podeser
		 cmp buffer,6EH;n
		 je Nok
		 cmp buffer,4EH;N
		 jne naoEhInicio
		 
		 Nok:
		 call podeser
		 cmp buffer,69H;i
		 je I2ok
		 cmp buffer,49H;I
		 jne naoEhInicio
		 
		 I2ok:
		 call podeser
		 cmp buffer,63H;c
		 je Cok
		 cmp buffer,43H;C
		 jne naoEhInicio
		 
		 Cok:
		 call podeser
		 cmp buffer,69H;i
		 je I3ok
		 cmp buffer,49H;I
		 jne naoEhInicio
		 
		 I3ok:
		 call podeser
		 cmp buffer,6FH;o
		 je Ook
		 cmp buffer,4FH;O
		 jne naoEhInicio
		 
		 Ook:
		 mov AchouInicio,1
		 ret
		 
		 naoEhInicio:
		 ret
		 ;-PROCURA INICIO
procuraInicio endp

;TRATA OS DIGITOS DOS NUMEROS, SEPARA CARA UM EM UMA VARIAVEL, DEPOIS TODOS SAO SOMADOS EM UMA VARIAVEL SOH NA FUNCAO QUE PEGA AS COORDS DO MOVE
tratarNumero PROC
		 ;TRATAR NUMEROS
		 add quantidadeDeNumeros,1
		 
		 cmp quantidadeDeNumeros,1
		 jne segundoNumero
		 mov dl,buffer
		 sub dl,48
		 mov Digito1,dl
		 mov AchouNumero,0
		 ret
		 
		 segundoNumero:
		 cmp quantidadeDeNumeros,2
		 
		 jne terceiroNumero
		 mov dl,buffer
		 sub dl,48
		 mov Digito2,dl
		 		 mov AchouNumero,0
		 ret
		 
		 terceiroNumero:
		 cmp quantidadeDeNumeros,3
		 jne quartoNumero
		 mov dl,buffer
		 sub dl,48
		 mov Digito3,dl
		 		 mov AchouNumero,0
		 ret
		 
		 quartoNumero:
		 cmp quantidadeDeNumeros,4
		 jne quintoNumero
		 mov dl,buffer
		 sub dl,48
		 mov Digito4,dl
		 		 mov AchouNumero,0
		 ret
		 
		 quintoNumero:
		 mov dl,buffer
		 sub dl,48
		 mov Digito5,dl
		 		 mov AchouNumero,0
		 ret
		 ;TRATAR NUMEROS
tratarNumero endp
;TRATA OS DIGITOS DOS NUMEROS, SEPARA CARA UM EM UMA VARIAVEL, DEPOIS TODOS SAO SOMADOS EM UMA VARIAVEL SOH NA FUNCAO QUE PEGA AS COORDS DO MOVE

;FUNCAO PARA PROCURAR UM NUMERO
procuraNumero PROC
 ;-procura numero
  
cmp buffer,30H ;0
jb naoEhnumero

cmp buffer,39H
ja naoEhnumero
 
mov AchouNumero,1
ret
naoEhnumero:
ret
 ;-procura numero
procuraNumero endp
;FUNCAO PARA PROCURAR UM NUMERO

;FUNCAO PARA PROCURAR UM SINAL NEGATIVO
procuraSinal PROC
 ;-procura Sinal
 cmp buffer,2DH ;-
 jne naoEhSinal
 mov AchouSinal,1
 mov AchouSinal1,1
 ret
 naoEhSinal:
 ret
 
 ;-Procura Sinal
 procuraSinal endp
;FUNCAO PARA PROCURAR UM SINAL NEGATIVO
 
;FUNCAO PARA PROCURAR UMA VIRGULA
procuraVirgula PROC
	;-ProcuraVirgula
	cmp buffer,2CH ;,
	jne NaoVirgula
	
	mov AchouVirgula,1
	ret
	NaoVirgula:
	ret
	;-procuravirgula
procuraVirgula endp
;FUNCAO PARA PROCURAR UMA VIRGULA
	
;FUNCAO PARA PROCURAR UM SINAL DE "IGUAL"
procuraIgual PROC

	;======PROCURA IGUAL
	
	cmp buffer,3DH
	je  IgualOk
	ret
	IgualOk:
	mov AchouIgual,1
	ret
	;======PROCURA IGUAL
	
procuraIgual endp
;FUNCAO PARA PROCURAR UM SINAL DE "IGUAL"

;FIM DO CODIGO, VERIFICA SE TEM ALGUM ERRO, SE SIM, INFORMA QUAL
fim:  

		cmp     erroInicialX,1
		jne FaixaXOk
		 lea    dx,erroiniciox 	
         mov    ah,9     
         int    21h         
		 
		 jmp faznada
		 FaixaXOk:
		 
		 cmp     erroInicialY,1
		 jne FaixaYOk
		 lea    dx,erroinicioY 	
         mov    ah,9      
         int    21h          
		 jmp faznada
		 FaixaYOk:

		cmp AchouInicio,0
		jne EncontrouInicioEacabou
		 lea    dx,acabouSemInicio 	
         mov    ah,9      
         int    21h          
		 jmp faznada
		EncontrouInicioEacabou:
		
		
		
		cmp movimentolongo,1
		jne MovimentookEAcabou
		
		 lea    dx,movimentomuitolongo 	
         mov    ah,9      
         int    21h          
		 jmp faznada
		MovimentookEAcabou:
		
		cmp AchouIgual,0
		jne EncontrouIgualEacabou
		
		 lea    dx,acabouSemIgual 	
         mov    ah,9      
         int    21h          
		 jmp faznada
		EncontrouIgualEacabou:
		
		cmp AchouSinal1,1
		jne EncontrouSinalEacabou
		
		 lea    dx,valornnomov 	
         mov    ah,9      
         int    21h          
		 jmp faznada
		EncontrouSinalEacabou:
		
		cmp achoufim,0
		jne EncontrouFimEacabou
	
		 lea    dx,acabouSemfim 	
         mov    ah,9      
         int    21h          
		 jmp faznada
		EncontrouFimEacabou:
	
		 jmp faznada
	
 ;FUNCAO PARA ESCREVER NA TELA E NO ARQUIVO DE SAIDA SEMPRE QUE CHAMADA - MUITO IMPORTANTE
 EscreverAtual PROC

 
	
		nossaX:		

        
	
		 mov dx,' '          
		 mov ah,2 
		 int 21h
		 cmp SomaX,0
		 jne colocar
		 mov dx,'0'
		 mov Escrever02,dx
		 mov ah,2 
		 int 21h
		 mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  
		 int  21h
		 jmp EscreverY
		 
		 colocar:
		  cmp NegativoX,1
		 jne naocolocar 
		 mov dx,'-'
		 mov Escrever02,dx
		  mov ah,2 
		 int 21h
		 mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  
		 int  21h
naocolocar:		 
		 
		 mov cx, SomaX
		 sub cx,10000
		 jb NaoEscreveDigito1
		 
		 mov dx,0
		 mov ax,SomaX
		 mov bx,10000
		 div bx
		 mov dx,0
		 mov bx,10
		 div bx
		 add dx,48           
		mov Escrever02,dx
   		mov ah,2 
		 int 21h
		 mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  
		 int  21h  
		
		 
		 
		 
		 naoEscreveDigito1:
		 mov cx, SomaX
		 sub cx,1000
		 jb NaoEscreveDigito2
		 
		 mov dx,0
		 mov ax,SomaX
		 mov bx,1000
		 div bx
		 mov dx,0
		 mov bx,10
		 div bx
		
		 add dx,48
		 mov Escrever02,dx
		 mov ah,2 
		 int 21h
		 
		 mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  
		 int  21h  
		 
		 naoEscreveDigito2:
		 mov cx, SomaX
		 sub cx,100
		 jb NaoEscreveDigito3
		 
		 mov dx,0
		 mov ax,SomaX
		 mov bx,100
		 div bx
		 mov dx,0
		 mov bx,10
		 div bx
		 
		 add dx,48         
		 mov Escrever02,dx
		 mov ah,2 
		 int 21h
		 mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  
		 int  21h  
		 
		 naoEscreveDigito3:
		  mov cx, SomaX
		 sub cx,10
		 jb NaoEscreveDigito4
		 mov dx,0
		 mov ax,SomaX
		 mov bx,10
		 div bx
		 mov dx,0
		 mov bx,10
		 div bx
		
		 add dx,48
		 mov Escrever02,dx
		           
		 mov ah,2 
		 int 21h
		  mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1 
		 int  21h  
		
		 naoEscreveDigito4:
		 mov dx,0
		 mov ax,SomaX
		 mov bx,10
		 div bx
		 add dx,48
		 mov Escrever02,dx
		         
		 mov ah,2 
		 int 21h
		  mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  
		 int  21h  
		 
		 
		;===================================
		EscreverY: 
		
		 mov dx,','         
		 mov ah,2 
		 int 21h
		 mov Escrever02,dx
		 mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  
		 int  21h  
		
		 cmp SomaY,0
		 jne colocarY
		 mov dx,'0'
		 mov Escrever02,dx
		 mov ah,2 
		 int 21h
		 mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  
		 int  21h
		 	jmp finalEscreve 
		
		 
		 colocarY:
		 cmp NegativoY,1
		 jne naocolocarY
		 mov dx,'-'
		 mov Escrever02,dx
		  mov ah,2 
		 int 21h
		   mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  
		 int  21h
		naocolocarY:		 
		
		
		nossa:
		  mov cx, SomaY
		 sub cx,10000
		 jb NaoEscreveDigito2Y
		 
		 mov dx,0
		 mov ax,SomaY
		 mov bx,10000
		 div bx
		 mov dx,0
		 mov bx,10
		 div bx
		 add dx,48
		 mov Escrever02,dx
		 mov ah,2 
		 int 21h
		 mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  
		 int  21h
		 
		 NaoEscreveDigito2Y:
		 mov cx, SomaY
		 sub cx,1000
		 jb NaoEscreveDigito3Y
		 
		 mov dx,0
		 mov ax,SomaY
		 mov bx,1000
		 div bx
		 mov dx,0
		 mov bx,10
		 div bx
		 add dx,48
		 mov Escrever02,dx           
		 mov ah,2 
		 int 21h
		   mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  ;STRING LENGTH.
		 int  21h
		 
		 NaoEscreveDigito3Y:
		  mov cx, SomaY
		 sub cx,100
		 jb NaoEscreveDigito4Y
		 mov dx,0
		 mov ax,SomaY
		 mov bx,100
		 div bx
		 mov dx,0
		 mov bx,10
		 div bx
		 add dx,48
		mov Escrever02,dx
		 mov ah,2 
		 int 21h
		   mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  ;STRING LENGTH.
		 int  21h
		
		 NaoEscreveDigito4Y:
		 mov cx, SomaY
		 sub cx,10
		 jb NaoEscreveDigito5Y
		 mov dx,0
		 mov ax,SomaY
		 mov bx,10
		 div bx
		 mov dx,0
		 mov bx,10
		 div bx
		 add dx,48
		mov Escrever02,dx
		 mov ah,2 
		 int 21h
		   mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  ;STRING LENGTH.
		 int  21h
		
		 NaoEscreveDigito5Y:
		 mov dx,0
		 mov ax,SomaY
		 mov bx,10
		 div bx
		 add dx,48
		 mov Escrever02,dx
		 mov ah,2 
		 int 21h
		 mov  ah, 40h
		 mov  bx, handlerSaida
		 lea dx,Escrever02
		 mov  cx, 1  
		 int  21h
		 finalEscreve:
		 	 lea dx, endl        
        mov bx, handlerSaida      
        mov cx, 2           
        mov ah, 40h         
       int 21h   
		ret
		
EscreverAtual endp
;FUNCAO PARA ESCREVER NA TELA E NO ARQUIVO DE SAIDA SEMPRE QUE CHAMADA - MUITO IMPORTANTE
		 
		 
;FINAL DO CODIGO, SE DESPEDE DO USUARIO E FECHA OS ARQUIVOS
faznada:

         mov dx,LF          
		 mov ah,2 
		 int 21h
		 
		  mov dx,LF         
		 mov ah,2 
		 int 21h
		 
		 lea    dx,mensagemDespedida 	
         mov    ah,9      
         int    21h        

		MOV handler,AX
		mov ah,3eh	 ; fecha arquivo
         mov bx,handler
         int 21h
		 
		 MOV handlerSaida,AX
		mov ah,3eh	 ; fecha arquivo
         mov bx,handlerSaida
         int 21h
		 
		
		 
         mov    ax,4c00h           ; funcao retornar ao DOS no AH
         int    21h                ; chamada do DOS
		
codigo   ends


         end    inicio 
		 

