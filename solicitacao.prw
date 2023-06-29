#Include "protheus.ch"
#Include "rwmake.ch"
#Include "tbiconn.ch"

User Function fSolMat()

	local aArea := GetArea()
	Local aCab := {}
	Local aAuto := {}
	local cItens := GETMV("AZ_SOLMAT")
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
MSGINFO( "Solicitação Realizada com Sucesso" )
EndIf
*/

aadd(aCab,{GetSxeNum("SCP","CP_NUM"),,dtoc(dDataBase)}) //Cabecalho

//Selecionando a área e posicionando os indices
	Dbselectarea("SB1")
	Dbsetorder(1)
//quebrando a strinsg em array
	cItens := StrTokArr(cItens, ';')
	//array recebendo os itens quebrados
	aLinha := {cItens}
	///procurando e setando a tabela sb1, o produto e retirando os espaços
	If SB1->(DbSeek(xFilial("SB1")+PadR("04", tamsx3('CP_PRODUTO') [1])))
	//alimentando os campos necessários para o execauto
		aadd(aLinha,{"CP_PRODUTO",cItens[1], Nil})
		aadd(aLinha,{"CP_QUANT",Val(cItens[2]), Nil})
		aadd(aLinha,{"CP_OBS", ALLTRIM(ZPP->ZPP_ALUNOS), Nil})
		//aauto recebe aLinha
		aAdd(aAuto,aLinha)
	EndIf
	//passando os parametros, o cabeçalho, informações e o numero para inclusão
	MSExecAuto({|x,y,z,a| mata105(x,y,z,a)},aCab,aAuto,3,)

	//criando variável para receber o código da solicitação
    CodSoli := SCP-> CP_NUM 
	if lMsErroAutos
		MostraErro()
	else //recklock para alteração de registros/campos
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

1. No menu do Browser do cadastro de alunos deverá conter um botão para solicitação de material (Solicitação ao armazém), Ao clicar nesse botão deverá ser criada automaticamente uma solicitação ao armazém no módulo de estoque para o aluno posicionado no browser. ??

- A informação com o código da solicitação criada deve ser armazenado em um novo campo no cadastro do aluno.??

- Deverá existir um campo no cadastro de aluno com o status da solicitação??

- Os materiais solicitados deverão ser obtidos via parâmetro ou consulta genérica.??

2. No momento da baixa dessa requisição, o sistema deverá atualizar o campo de situação da solicitação de material, no cadastro do aluno.??


Sugestões:

MsExecAuto: https://tdn.totvs.com/pages/releaseview.action?pageId=500292112 *Não usar rateio

Ponto de entrada: https://tdn.totvs.com/display/public/PROT/M185GRV
*/
