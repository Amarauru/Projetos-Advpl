User Function exercArray()

	local aArray1 := Array(1,5)
	local lSai := .T.
	local nPos:= 0
	local nCont:= 0
	Local cLista := ""
	local cA1 := ""
	local nN1 := 0
	local nN2 := 0
	local nMa := 0
	

	DbSelectArea('SB1')
	DbSetOrder(1)
	While SB1->(!EoF())
			cCod := SB1->B1_COD
		SB1->(DbSkip())
	END

	aArray1 [1,1] := "ZO Aluno"
	aArray1 [1,2] := "Insira a Nota 1"
	aArray1 [1,3] := "Insira a Nota 2"
	aArray1 [1,4] := "Sua Média foi: "
	aArray1 [1,5] := "Situação"

	While lSai
		 
		cA1 := UPPER( FwInputBox(aArray1 [1,1]))
		nN1 := Val(FwInputBox( aArray1[1,2]))
		nN2 := Val(FwInputBox( aArray1[1,3]))
		nMa:= (nN1 + nN2) / 2
		AADD(aArray1,{ cA1, nN1, nN2,nMa})

		lSai := MsgYESNO("Deseja adicionar mais?",)

	End

	//ASORT( any, numeric, numeric, block )
	aOrdem := ASORT(aArray1,2,LEN(aArray1), {|x,y|x[1] <y[1]})

	For nCont := 2 to LEN(aOrdem)
		cLista += aOrdem[nCont,1]+CHR( 13 )
	Next

	MSGINFO(cLista,"Lista de alunos")

	cbusca := UPPER(FwInputBox("Procure um aluno"))
	nPos := aScan(aArray1, {|x| UPPER(AllTrim(x[1])) = cbusca})
	If nPos > 0												//lembrar do c antes do ValToChar (para caractere)
		MsgInfo(cbusca +  " Aluno Encontrado, média:  " + cValToChar(aArray1[nPos,4]),  "Atenção" )
	Else
		MsgAlert(cbusca + "não foi encontrado!", "Atenção")
	EndIf

	//(aArray1[nCont,1]+ cpula+; aArray1[1,4]  + cVALTOCHAR(aArray1[nCont,4]),)
Return
