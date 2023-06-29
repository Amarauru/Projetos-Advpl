User Function faArray()

	local cpula := chr(13)
	local aArray1 := {}
	local nCont

//Inserir as informações dos alunos
	local cA1 := FwInputBox("Insira o primeiro aluno")
    local nN1 := Val(FwInputBox("Insira a nota do aluno"))
	local nN2 := Val(FwInputBox("Insira a nota do segunda nota aluno"))


	local cA2 := FwInputBox("Insira o segundo aluno")
    local nN1A2 := Val(FwInputBox("Insira a nota do aluno"))
	local nN2A2 := Val(FwInputBox("Insira a nota do segunda nota aluno"))
	
    local MA1 := (nN1 + nN2) / 2
    local MA2 := (nN1A2 + nN2A2) / 2
    
    aArray1 := {{cA1, MA1},{cA2, MA2}}
	
for nCont := 1 to LEN(aArray1)

MSGINFO("ALUNO: " + aArray1[nCont,1] + cpula+;
"Média: " + cVALTOCHAR(aArray1[nCont,2]),)

NEXT nCont


Return
