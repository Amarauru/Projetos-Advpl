#Include "Protheus.ch"

User  Function dbteste()

	local cLista := " "
	local cFiltro := " "
	


//ESCOLHER A TABELA
	DBSELECTAREA('ZPP')
//Escolher a ordem do indice                                                                                                                                    
	DBSETORDER(1)
	cFiltro := "'J' $ 'ZPP->ZPP_ALUNOS' "
	ZPP->(DBSETFILTER( { || &cFiltro}, cfiltro ))
//ZPP->()
	ZPP->(DBGOTOP())
	while ZPP->(!EOF())
		cLista +=  AllTrim(ZPP->ZPP_ALUNOS) + CHR(13)
		ZPP-> (DBSKIP(1))
	end
    //PADR('João Cleber',TAMSX3("ZPP_ALUNOS")[1])
	//DBSEEK( xFilial('ZPP')+ PADR('João Cleber',TAMSX3("ZPP_ALUNOS")[1]))
	//DBGOTO(2)
	MSGINFO(cLista)
	//MSGINFO(ZPP->ZPP_ALUNOS)


//formato de realização de busca de tabela mais prática do que o setfilter
	cQuery := "SELECT * FROM ZPP990 WHERE D_E_L_E_T_ <> '*' AND ZPP_ALUNOS LIKE 'J%'" //expressão em sql (procurar sobre LIKE)
	cQuery := ChangeQuery(cQuery)
	cAlias  := MPSysOpenQuery(cQuery)
	DBSELECTAREA( cAlias )
	(cAlias)-> (DBGOTOP())
	while (cAlias)->(!EOF())
		cLista +=  AllTrim((cAlias)->ZPP_ALUNOS) + CHR(13)
		(cAlias)-> (DBSKIP(1))
	end
	(cAlias)->(DbCloseArea())
	MSGINFO(cLista)
// ZPP-> DBSetFilter( < bCond >, <cCond >)

Return

