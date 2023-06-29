#include "protheus.ch"

User Function cZPR()

//defini��o de vari�veis e chamada da fun��o GETMV, que busca um parametro especifico
	local cUsuario := GETMV("AZ_USER")
	local cAlias := "ZPR"

	Private cCadastro := "MANUTEN��O DE PROFESSORES"
	Private aRotina := {}

//condi��o que verifica se cont�m ou n�o o userId(usu�rio logado) no usu�rio logado
	if !__cUserId $ cUsuario
		Alert("Usu�rio n�o Autorizado.")
		RETURN
	ENDIF
	//Interface para o Browser
	AADD(aRotina,{"Pesquisar","AxPesqui",0,1})
	AADD(aRotina,{"Visualizar","AxVisual",0,2})
	AADD(aRotina,{"Incluir","AxInclui",0,3})
	AADD(aRotina,{"Alterar","AxAltera",0,4})
	AADD(aRotina,{"Excluir","AxDeleta",0,5})

//DbSelectArea(<nArea ou cArea>)

	//define a area de trabalho de atua��o
	DBSELECTAREA(cAlias)

	//defini��o de ordem de indice, previamente estabelecido na tabela.
	DBSETORDER(1)

	//passagem de parametro do mbrowser na verdade � obsoleta, pdoe usar essa padr�o
	mBrowse(6,1,22,75,cAlias)


//getsxenum
RETURN()
