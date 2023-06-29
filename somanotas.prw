user function somanotas()

    //Val serve para converter string em numérico

local cN1 := Val(FwInputBox("Insira a primeira nota"))
local cN2 := Val(FwInputBox("Insira a segunda nota"))
local cN3 := Val(FwInputBox("Insira a terceira nota"))



local nSoma := (nN1 + nN2 + nN3)/3

if nSoma >= 7
    MSGINFO( "Sua média foi: " + ALLTRIM(cValToChar(nSoma)) + " Você foi Aprovado.",)
    else 
    Alert( "Sua média foi: " + ALLTRIM(cValToChar(nSoma)) + " Você foi reprovado.",)  
ENDIF

                     //Altrim serve para retirar o espaço e str para converter em string
RETURN


