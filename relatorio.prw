#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

// Exemplo de relatorio usando tReport com uma Section

User Function RCOMR02()

local oReport
local cPerg := 'RCOMR02'
local cAlias := getNextAlias()

//Pergunte(cPerg, .f.)

oReport := reportDef(cAlias, cPerg)
oReport:printDialog()

return

//+-----------------------------------------------------------------------------------------------+
//! Rotina para montagem dos dados do relat�rio. !
//+-----------------------------------------------------------------------------------------------+

Static Function ReportPrint(oReport,cAlias)

local oSecao1 := oReport:Section(1)

oSecao1:BeginQuery()

BeginSQL Alias cAlias

select ZPP_CODALU,
ZPP_ALUNOS,
ZPP_MEDIA,
ZPP_PROF,
IIF(ZPP_MEDIA>=7, 'Aprovado','Reprovado') AS SITUACAO 
from %table:ZPP% ZPP  
WHERE ZPP.%notDel%s

EndSQL

oSecao1:EndQuery()
oReport:SetMeter((cAlias)->(RecCount()))
oSecao1:Print()
return
//+-----------------------------------------------------------------------------------------------+
//! Função para cria��o da estrutura do relat�rio. !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportDef(cAlias, cPerg)

local cTitle := "Relat�rio de Alunos"
local cHelp := "Gera um Relat�rio com os cadastros de alunos"
local oReport
local oSection1
//local cPosit := " "
//local cAprovacao
//local cor 
//local aArray :={}
Pergunte(cPerg, .f.)

oReport := TReport():New('RCOMR02',cTitle,cPerg,{|oReport|ReportPrint(oReport,cAlias)},cHelp)

//Primeira sess�o
oSection1 := TRSection():New(oReport,"Cadastro de Alunos",{cAlias})

//as buscas e preenchimentos das celulas podem ser realizadas passando por query ou como bloco de codigo, como segue o exemplo
//Parametros do TRCell: 
//TRCell():New( <oParent> , <cName> , <cAlias> , <cTitle> , <cPicture> , <nSize> , <lPixel> , <bBlock> , <cAlign> , <lLineBreak> , <cHeaderAlign> , <lCellBreak> , <nColSpace> , <lAutoSize> , <nClrBack> , <nClrFore> , <lBold> )
ocell1:= TRCell():New(oSection1,"ZPP_CODALU", cAlias, "C�digo do Aluno",,,,,"CENTER",,,,,,,,)
ocell:= TRCell():New(oSection1,"ZPP_ALUNOS", cAlias, "Nome do Aluno")
ocell:= TRCell():New(oSection1,"ZPP_MEDIA", cAlias, "M�dia do Aluno",,,,,"CENTER",,,,,,,,)
ocell:= TRCell():New(oSection1,"ZPP_PROF", cAlias, "Nome do Professor")
ocell:= TRCell():New(oSection1,"ZPP_STSMAT", cAlias, "Situa��o do Material")

//ocell:= TRCell():New(oSection1,"SITUACAO", cAlias, "Situa��o")

//tentar por bloco de c�digo
//bbloco1:= {||IIF(ZPP_MEDIA>=7, 'Aprovado','Reprovado')
//Alert (Eval(bbloco1))
//ocellSit:= TRCell():New(oSection1,"SITA",,"Situa��o",,,,bbloco1,"CENTER",,,,,,,CLR_BLUE,.T.)
ocellSit:= TRCell():New(oSection1,"SITUACAO", cAlias, "Situa��o")
//definindo mais uma array, recebendo SITUACAO como query, e verificando se SITUACAO tem aprov ou reprov e passando o fundo e a cor da fonte
aAdd(oSection1:Cell("SITUACAO"):aFormatCond, {"SITUACAO='Aprovado'" ,,CLR_BLUE})
aAdd(oSection1:Cell("SITUACAO"):aFormatCond, {"SITUACAO='Reprovado'" ,,CLR_RED})


//APROVADO EM NEGRITO COM FONTE AZUL E REPROVADO COM FONTE VERMELHA
//Cor := IIF(bbloco1 == "Aprovado", 'CLR_BLUE','CLR_RED')
//aAdd(oSection1:Cell("ZPP_APROV"):cAprovacao, {"ZPP_MEDIA>=7" , "APROVADO","REPROVADO"})
//cAprovacao:= IIF((ZPP_MEDIA>=7), APROVADO, REPROVADO)

//Criar campo no cadastro de aluno de Situa��o de Material e um "bot�o" que fa�a a solicita��o ao armaz�m, ap�s a baixa do material, deve-se atualizar o campo de material com solicitado
// Utilizar tudo at� agora, ponto de entrada e executo, precisa ter um bot�o no cadastro de aluno que possa justamente fazer a solicita��o ao armaz�m, os produtos devem ser passados por parametro e o campo deve ser preenchido

//ocell:= TRCell():New(oSection1,Cell("M�dia"):SetBlock(aARRAY[1]))
//as informa��es j� foram percorridas pela query, ent�o � s� utilizar os valores com alguma l�gica de la�o e lan�ar nas celulas
//aAdd(oSection1:Cell("E1_VALOR"):aFormatCond, {"E1_VALOR > 100 .and. E1_VALOR < 1000" ,,CLR_GREEN})
//aAdd(oSection1:Cell("E1_VALOR"):aFormatCond, {"E1_VALOR >= 1000" ,CLR_HGRAY,CLR_RED})
//aAdd(oSection1:Cell("E1_VALOR"):aFormatCond, {"E1_VALOR >= "+cvaltochar(MV_PAR01) ,,CLR_RED})
Return(oReport)
