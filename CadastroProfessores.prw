#include "protheus.ch"

User Function cZPR()

//definição de variáveis e chamada da função GETMV, que busca um parametro especifico
	local cUsuario := GETMV("AZ_USER")
	local cAlias := "ZPR"

	Private cCadastro := "MANUTENÇÃO DE PROFESSORES"
	Private aRotina := {}

//condição que verifica se contém ou não o userId(usuário logado) no usuário logado
	if !__cUserId $ cUsuario
		Alert("Usuário não Autorizado.")
		RETURN
	ENDIF
	//Interface para o Browser
	AADD(aRotina,{"Pesquisar","AxPesqui",0,1})
	AADD(aRotina,{"Visualizar","AxVisual",0,2})
	AADD(aRotina,{"Incluir","AxInclui",0,3})
	AADD(aRotina,{"Alterar","AxAltera",0,4})
	AADD(aRotina,{"Excluir","AxDeleta",0,5})

//DbSelectArea(<nArea ou cArea>)

	//define a area de trabalho de atuação
	DBSELECTAREA(cAlias)

	//definição de ordem de indice, previamente estabelecido na tabela.
	DBSETORDER(1)

	//passagem de parametro do mbrowser na verdade é obsoleta, pdoe usar essa padrão
	mBrowse(6,1,22,75,cAlias)


//getsxenum
RETURN()
