User Function exerc3()

local nValSal,nQtdHor,nSalRec
local nMeta := 180


nValSal := VAL(FwInputBox("Diga seu salário"))
nQtdHor := VAL(FwInputBox("Diga suas quantidade de horas"))

if (nQtdHor>nMeta)
    nSalrec := (nValSal+2)*nQtdHor
else
    nSalrec := nValSal * nQtdHor
    
endif
MsgInfo( nSalrec,)



Return
