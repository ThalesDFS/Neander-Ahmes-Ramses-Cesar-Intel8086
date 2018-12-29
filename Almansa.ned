;ZERAR VARIAVEIS
lda 255 ;lda zero
sta resultMul
sta laco
sta lacoPotencia
sta lacoMul
sta quantidadeDeDivisores
sta somatorioDosDivisores
;ZERAR VARIAVEIS

lda n ;carrega n
add MenosUm
not ;complementa
add um
jz fimPorNser1
sta laco

iniciolaco:
lda n

loop:
add laco
jz divisor
jn naodivisor
jmp loop

naodivisor:
lda laco
add um
sta laco
jz fimlaco
jmp iniciolaco

divisor:
lda laco
not
add um
add somatorioDosdivisores
sta somatorioDosdivisores
lda um
add quantidadeDeDivisores
sta quantidadeDeDivisores
lda laco
add um
jz fimlaco
sta laco
jmp iniciolaco

fimlaco:
lda n
add somatorioDosdivisores
sta somatorioDosdivisores
lda x
add Menosum
jz fimSomatorio
lda x
jz fimQuantidade

lda somatorioDosdivisores
add MenosUm
sta laco
lda x
add menosum
sta lacopotencia

potencia:
lda somatorioDosdivisores
add MenosUm
sta lacoMul
multiplicacao:
lda laco
add resultMul
sta resultMul
lda lacoMul
add menosum
sta lacoMul
jz VePotencia
jmp multiplicacao

VePotencia:
lda lacopotencia
add Menosum
sta lacopotencia
jmp ValoresPadrao

;=============================================
;VALORES DO ENUNCIADO
org 128
n: DB  1 ; VALOR DE n (128)
x: DB 10 ; VALOR DE x (129)
resultado: DB  0 ;RESULTADO FINAL
;=============================================
ValoresPadrao:
jz fimtotal
lda resultMul
sta laco

lda somatorioDosdivisores
add MenosUm
add MenosUm
sta lacoMul
jmp multiplicacao

;=============================================
;VALORES DO ENUNCIADO
;org 128

;n: DB  1 ; VALOR DE n (128)
;x: DB 10 ; VALOR DE x (129)
;resultado: DB  0 ;RESULTADO FINAL
;=============================================

fimtotal:
lda resultMul
add um
sta resultado
hlt



fimSomatorio:
lda somatorioDosdivisores
sta resultado
hlt

fimQuantidade:
lda um
add quantidadeDeDivisores
sta resultado
hlt

fimPorNser1:
lda um
sta resultado
hlt

ORG 190
resultMul: DB 0
Um: DB 1
laco: DB 0
lacoPotencia: DB 0
lacoMul: DB 0
MenosUm: DB 255

quantidadeDeDivisores: DB 0
somatorioDosDivisores: DB 0
