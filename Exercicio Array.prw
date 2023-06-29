user function fArray()

	local aArray1
	local nCont

	aArray1 := Array(5,3)

	aArray1 [1] := {"Pedro", "12", "1 ano"}
	aArray1 [2] := {"Joao", "15", "3 ano"}
	aArray1 [3] := {"Rafael", "16", "2 ano"}
	aArray1 [4] := {"Carlos", "20", "1 ano"}
	aArray1 [5] := {"Marcos", "14", "4 ano"}

	
	for nCont := 1 to LEN(aArray1)
         MSGINFO("Nome: " + aArray1[nCont,1] + CHR(13)+; 
        "Idade: " + CVALTOCHAR(aArray1 [nCont,2]) + CHR(13)+ ;
        "Serie: " +( aArray1[nCont,3]),)
         
            
 


	NEXT nCont


	


RETURN
