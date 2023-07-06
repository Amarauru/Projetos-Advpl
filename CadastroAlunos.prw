#include "protheus.ch"

User Function MBrwZZP()

//defini��o de vari�veis e chamada da fun��o GETMV, que busca um parametro especifico
	local cUsuario := GETMV("AZ_USER")
	local cAlias := "ZPP"
	local cNovoUsuarioADM := GETMV("AZ_ADM")
	local cPerg := "ZPPP"
	private aRotina := {}
	Private cCadastro := "Cadastro de Alunos"

//condi��o que verifica se cont�m ou n�o o userId(usu�rio logado) no usu�rio logado
	if !__cUserId $ cUsuario
		Alert("Usu�rio n�o Autorizado.")
		RETURN
	ENDIF

	/*Interface para o Browser, os parametros s�o: [n][1]-->T�tulo da rotina que ser� exibido no menu 
	[n][2]  -->  Nome da fun��o que ser� executada,
	[n][3] --> Par�metro reservado. Deve ser sempre 0 (zero)
	[n][4]  -->  N�mero da opera��o que a fun��o executar�. As alternativas s�o:
	
	1=Pesquisa
	2=Visualiza��o
	3=Inclus�o
	4=Altera��o
	5=Exclus�o
	6=Altera��o sem a permiss�o para incluir novas linhas. � v�lido apenas para os objetos GetDados e GetDb.
	[n][5]  -->  Par�metro descontinuado.
	*/

	AADD(aRotina,{"Pesquisar","AxPesqui",0,1})
	AADD(aRotina,{"Visualizar","AxVisual",0,2})
	//AxInclui( <cAlias>, <nReg>, <nOpc>, <aAcho>, <cFunc>, <aCpos>, <cTudoOk>, <lF3>, <cTransact>, <aButtons>, <aParam>, <aAuto>, <lVirtual>, <lMaximized>)
	AADD(aRotina,{"Incluir","AxInclui(,,,,,,u_fcli,,,,,,,)",0,3})
	AADD(aRotina,{"Alterar","AxAltera",0,4})
	AADD(aRotina,{"Excluir","AxDeleta",0,5})
	AADD(aRotina,{"Relat�rio de Alunos","U_RCOMR02",0,6})
	AADD(aRotina,{"Solicita��o de Material","U_fSolMat",0,7})
	AADD(aRotina,{"importa��o de Alunos","U_xImpAlu",0,8})
	AADD(aRotina,{"Relat�rio de Alunos Ex","U_frelatexcel",0,9})
//Se o UserId(usu�rio logado) estiver na vari�vel de usu�rios adm, o bot�o ir� aparecer
	if __cUserId $ cNovoUsuarioADM
		//Passando no segundo parametro, a user function de autoriza��o de usu�rio (adicionando nova funcionalidade)
		AADD(aRotina,{"Autorizar Usu�rio","U_fparametros",0,6})
	ENDIF
//DbSelectArea(<nArea ou cArea>)
//Pergunte( cPergunta , [ lPerg ] , [ cTitulo ] ) -> l�gico
//IIF
	if Pergunte(cPerg, .T., "Selecione o Cadastro")
		cAlias    := IIF(  mv_par01 = 1 ,"ZPP", "ZPR" )
		cCadastro := IIF(  mv_par01 = 1 ,"Cadastro de Alunos", "Cadastro de Professores" )
	else
		Alert ("Nenhuma Resposta")
		RETURN

	endif
	//define a area de trabalho de atua��o
	DBSELECTAREA(cAlias)
	//defini��o de ordem de indice, previamente estabelecido na tabela.
	DBSETORDER(1)
	//necess�rio para gera��o de telas padr�es do protheus, sem isso a rotina n�o executa.
	//mBrowse( <nLinha1>, <nColuna1>, <nLinha2>, <nColuna2>, <cAlias>, <aFixe>, <cCpo>, <nPar>,
	//<cCorFun>, <nClickDef>, <aColors>, <cTopFun>, <cBotFun>, <nPar14>, <bInitBloc>, <lNoMnuFilter>, <lSeeAll>, <lChgAll>, <cExprFilTop>, <nInterval>, <uPar22>, <uPar23> )
	mBrowse(,,,,cALIAS)

RETURN()

/*
ZPP_CODALU
ZPP_ALUNOS
ZPP_NASCME
ZPP_DA
ZPP_NOTAS1
ZPP_NOTAS2
ZPP_MEDIA
ZPP_CODPF
ZPP_PROF
ZPP_TURNO
ZPP_TURMA
ZPP_STSMAT
ZPP_CODSOL
*/
User Function fcli()

IIF( LEN(M->ZPP_CODALU) < 6, ,MsgINFO("C�digo deve ser menor que 6 digitos",))
IIF( LEN(M->ZPP_ALUNOS) < 16, ,MsgINFO("Nome deve ser menor que 16 digitos",))
IIF( LEN(M->ZPP_NASCME) < 8, ,MsgINFO("Data de Nascimento deve ser menor que 8 digitos",))
IIF( LEN(M->ZPP_DA) < 2, ,MsgINFO("Deve ser menor que 2 digitos",))
IIF( LEN(M->ZPP_NOTAS1) < 3, ,MsgINFO("Nota deve ser menor que 3 digitos",))
IIF( LEN(M->ZPP_NOTAS2 ) < 3, ,MsgINFO("Nota deve ser menor que 3 digitos",))

IIF( LEN(M->ZPP_CODPF) < 10, ,MsgINFO("C�digo deve ser menor que 6 digitos",))
IIF( LEN(M->ZPP_PROF) < 24, ,MsgINFO("Nome deve ser menor que 24 digitos",))
IIF( LEN(M->ZPP_PROF) < 24, ,MsgINFO("Nome deve ser menor que 24 digitos",))

RECLOCK( ZPP, .T. )
ZPP_CODALU := M->ZPP_CODALU
ZPP_ALUNOS := M->ZPP_ALUNOS
ZPP_NASCME := M->ZPP_NASCME
ZPP_DA := M->ZPP_DA
ZPP_NOTAS1 := M->ZPP_NOTAS1
ZPP_NOTAS2 := M->ZPP_NOTAS2 
ZPP_MEDIA := M->ZPP_MEDIA
ZPP_CODPF := M->ZPP_CODPF
ZPP_PROF := M->ZPP_PROF
ZPP_TURNO := M->ZPP_TURNO
ZPP_TURMA := M->ZPP_TURMA 
ZPP_STSMAT := M->ZPP_STSMAT
ZPP_CODSOL := M->ZPP_CODSOL
ZPP->(MsUnlock())

return .T.
//Criar tabela ZZP, com cadastro de alunos, inserir campos dos alunos, m�dias
//Pesquisar Interface e Mbrowser


//Arquitetura
//advpl, array,(AADD,Sort,)
