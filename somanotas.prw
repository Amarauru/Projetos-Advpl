user function somanotas()

    //Val serve para converter string em num�rico

local cN1 := Val(FwInputBox("Insira a primeira nota"))
local cN2 := Val(FwInputBox("Insira a segunda nota"))
local cN3 := Val(FwInputBox("Insira a terceira nota"))



local nSoma := (nN1 + nN2 + nN3)/3

if nSoma >= 7
    MSGINFO( "Sua m�dia foi: " + ALLTRIM(cValToChar(nSoma)) + " Voc� foi Aprovado.",)
    else 
    Alert( "Sua m�dia foi: " + ALLTRIM(cValToChar(nSoma)) + " Voc� foi reprovado.",)  
ENDIF

                     //Altrim serve para retirar o espa�o e str para converter em string
RETURN


