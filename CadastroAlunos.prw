#include "protheus.ch"

User Function MBrwZZP()

//definição de variáveis e chamada da função GETMV, que busca um parametro especifico
	local cUsuario := GETMV("AZ_USER")
	local cAlias := "ZPP"
	local cNovoUsuarioADM := GETMV("AZ_ADM")
	local cPerg := "ZPPP"
	private aRotina := {}
	Private cCadastro := "Cadastro de Alunos"

//condição que verifica se contém ou não o userId(usuário logado) no usuário logado
	if !__cUserId $ cUsuario
		Alert("Usuário não Autorizado.")
		RETURN
	ENDIF

	/*Interface para o Browser, os parametros são: [n][1]-->Título da rotina que será exibido no menu 
	[n][2]  -->  Nome da função que será executada,
	[n][3] --> Parâmetro reservado. Deve ser sempre 0 (zero)
	[n][4]  -->  Número da operação que a função executará. As alternativas são:
	
	1=Pesquisa
	2=Visualização
	3=Inclusão
	4=Alteração
	5=Exclusão
	6=Alteração sem a permissão para incluir novas linhas. É válido apenas para os objetos GetDados e GetDb.
	[n][5]  -->  Parâmetro descontinuado.
	*/

	AADD(aRotina,{"Pesquisar","AxPesqui",0,1})
	AADD(aRotina,{"Visualizar","AxVisual",0,2})
	AADD(aRotina,{"Incluir","AxInclui",0,3})
	AADD(aRotina,{"Alterar","AxAltera",0,4})
	AADD(aRotina,{"Excluir","AxDeleta",0,5})
	AADD(aRotina,{"Relatório de Alunos","U_RCOMR02",0,6})
	AADD(aRotina,{"Solicitação de Material","U_fSolMat",0,7})
	AADD(aRotina,{"importação de Alunos","U_xImpAlu",0,8})
	AADD(aRotina,{"Relatório de Alunos Ex","U_frelatexcel",0,9})

	
//Se o UserId(usuário logado) estiver na variável de usuários adm, o botão irá aparecer
	if __cUserId $ cNovoUsuarioADM
		//Passando no segundo parametro, a user function de autorização de usuário (adicionando nova funcionalidade)
		AADD(aRotina,{"Autorizar Usuário","U_fparametros",0,6})
	ENDIF


//DbSelectArea(<nArea ou cArea>)
//Pergunte( cPergunta , [ lPerg ] , [ cTitulo ] ) -> lógico
//IIF
	if Pergunte(cPerg, .T., "Selecione o Cadastro")
		cAlias    := IIF(  mv_par01 = 1 ,"ZPP", "ZPR" )
		cCadastro := IIF(  mv_par01 = 1 ,"Cadastro de Alunos", "Cadastro de Professores" )
	else
		Alert ("Nenhuma Resposta")
		RETURN

	endif
	//define a area de trabalho de atuação
	DBSELECTAREA(cAlias)

	//definição de ordem de indice, previamente estabelecido na tabela.
	DBSETORDER(1)

	//necessário para geração de telas padrões do protheus, sem isso a rotina não executa.
	//mBrowse( <nLinha1>, <nColuna1>, <nLinha2>, <nColuna2>, <cAlias>, <aFixe>, <cCpo>, <nPar>,
	//<cCorFun>, <nClickDef>, <aColors>, <cTopFun>, <cBotFun>, <nPar14>, <bInitBloc>, <lNoMnuFilter>, <lSeeAll>, <lChgAll>, <cExprFilTop>, <nInterval>, <uPar22>, <uPar23> )

	mBrowse(,,,,cALIAS)

RETURN()

//Criar tabela ZZP, com cadastro de alunos, inserir campos dos alunos, médias
//Pesquisar Interface e Mbrowser


//Arquitetura
//advpl, array,(AADD,Sort,)
