#Include "protheus.ch"
#Include "rwmake.ch"
#Include "tbiconn.ch"

User Function fSolMat()

	local aArea := GetArea()
	Local aCab := {}
	Local aAuto := {}
	local cItens := GETMV("AZ_SOLMAT") //Pode usar SuperGETMV
	local aProd := {}
	local aLinha:= {}
	Private lMsErroAuto := .F.
/*
For nX := 1 to 2
aItem:= {}
aadd(aItem,{"CP_ITEM",'1',Nil})
aadd(aItem,{"CP_PRODUTO", '04', Nil})
aadd(aItem,{"CP_UM", 'G', Nil})
aadd(aItem,{"CP_QUANT", '5', Nil})
aadd(acItens,aItem)
NEXT nX
MSExecAuto({|x,y| MATA105(x,y)},acItens,3)
if lMsErroAuto
MostraErro()
else 
MSGINFO( "Solicita��o Realizada com Sucesso" )
EndIf
*/

aadd(aCab,{GetSxeNum("SCP","CP_NUM"),,dtoc(dDataBase)}) //Cabecalho

//Selecionando a �rea e posicionando os indices
	Dbselectarea("SB1")
	Dbsetorder(1)
	//quebrando a strings  em array
	//array recebendo os itens quebrados
	aProd := StrTokArr(cItens, ';') //pode se usar separa()
	
	///procurando e setando a tabela sb1, o produto e retirando os espa�os
	If SB1->(DbSeek(xFilial("SB1")+PadR("04", tamsx3('CP_PRODUTO') [1])))
	//alimentando os campos necess�rios para o execauto
		aadd(aLinha,{"CP_PRODUTO",aProd[1], Nil})
		aadd(aLinha,{"CP_QUANT",Val(aProd[2]), Nil})
		aadd(aLinha,{"CP_OBS", ALLTRIM(ZPP->ZPP_ALUNOS), Nil})
		//aauto recebe aLinha
		aAdd(aAuto,aLinha)
	EndIf
	//passando os parametros, o cabe�alho, informa��es e o numero para inclus�o
	MSExecAuto({|x,y,z,a| mata105(x,y,z,a)},aCab,aAuto,3,)

	//criando vari�vel para receber o c�digo da solicita��o
    CodSoli := SCP-> CP_NUM 
	if lMsErroAutos
		MostraErro()
	else //recklock para altera��o de registros/campos
		RecLock('ZPP', .F.)
		ZPP->ZPP_STSMAT  := "SOLICITADO"
        ZPP-> ZPP_CODSOL := CodSoli
		ZPP->(MsUnlock())
	EndIf
	RestArea(aArea)
Return

/*Desafio AdvPL:
* MsExecAuto
* Ponto de entrada

1. No menu do Browser do cadastro de alunos dever� conter um bot�o para solicita��o de material (Solicita��o ao armaz�m), Ao clicar nesse bot�o dever� ser criada automaticamente uma solicita��o ao armaz�m no m�dulo de estoque para o aluno posicionado no browser. ??

- A informa��o com o c�digo da solicita��o criada deve ser armazenado em um novo campo no cadastro do aluno.??

- Dever� existir um campo no cadastro de aluno com o status da solicita��o??

- Os materiais solicitados dever�o ser obtidos via par�metro ou consulta gen�rica.??

2. No momento da baixa dessa requisi��o, o sistema dever� atualizar o campo de situa��o da solicita��o de material, no cadastro do aluno.??

Sugest�es:

MsExecAuto: https://tdn.totvs.com/pages/releaseview.action?pageId=500292112 *N�o usar rateio

Ponto de entrada: https://tdn.totvs.com/display/public/PROT/M185GRV
*/
