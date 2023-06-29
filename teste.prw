user function fSeparaNum()

	local nBI
	local cBIImpares := ""
	local cBIPares := ""
        nHora := 12
	fCalc(nBI, cBIImpares, cBIPares)

return



Static Function fCalc(nBI, cBIImpares, cBIPares)
    for nBI := 1 to 12

		If mod(nBI,2) == 0
			cBIPares += ALLTRIM((STR(nBI))) + " "

		Else
			cBIImpares += ALLTRIM(STR(nBI)) + " "
		EndIf

	NEXT

	MsgInfo( "Pares " + cBIPares + " Impares " + cBIImpares +  cValToChar(nHora),)

Return 
