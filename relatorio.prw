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
//! Rotina para montagem dos dados do relatório. !
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
WHERE ZPP.%notDel%

EndSQL

oSecao1:EndQuery()
oReport:SetMeter((cAlias)->(RecCount()))
oSecao1:Print()
return
//+-----------------------------------------------------------------------------------------------+
//! FunÃ§Ã£o para criação da estrutura do relatório. !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportDef(cAlias, cPerg)

local cTitle := "Relatório de Alunos"
local cHelp := "Gera um Relatório com os cadastros de alunos"
local oReport
local oSection1
//local cPosit := " "
//local cAprovacao
local bbloco1
//local cor 
//local aArray :={}
Pergunte(cPerg, .f.)

oReport := TReport():New('RCOMR02',cTitle,cPerg,{|oReport|ReportPrint(oReport,cAlias)},cHelp)

//Primeira sessão
oSection1 := TRSection():New(oReport,"Cadastro de Alunos",{cAlias})
//as buscas e preenchimentos das celulas podem ser realizadas passando por query ou como bloco de codigo, como segue o exemplo
//Parametros do TRCell: 
//TRCell():New( <oParent> , <cName> , <cAlias> , <cTitle> , <cPicture> , <nSize> , <lPixel> , <bBlock> , <cAlign> , <lLineBreak> , <cHeaderAlign> , <lCellBreak> , <nColSpace> , <lAutoSize> , <nClrBack> , <nClrFore> , <lBold> )
ocell1:= TRCell():New(oSection1,"ZPP_CODALU", cAlias, "Código do Aluno",,,,,"CENTER",,,,,,,,)
ocell:= TRCell():New(oSection1,"ZPP_ALUNOS", cAlias, "Nome do Aluno")
ocell:= TRCell():New(oSection1,"ZPP_MEDIA", cAlias, "Média do Aluno",,,,,"CENTER",,,,,,,,)
ocell:= TRCell():New(oSection1,"ZPP_PROF", cAlias, "Nome do Professor")
ocell:= TRCell():New(oSection1,"ZPP_STSMAT", cAlias, "Situação do Material")

//ocell:= TRCell():New(oSection1,"SITUACAO", cAlias, "Situação")


//bbloco1:= {||IIF(ZPP_MEDIA>=7, 'Aprovado','Reprovado')}

//Alert (Eval(bbloco1))
//ocellSit:= TRCell():New(oSection1,"SITA",,"Situação",,,,bbloco1,"CENTER",,,,,,,CLR_BLUE,.T.)
ocellSit:= TRCell():New(oSection1,"SITUACAO", cAlias, "Situação")
//definindo mais uma array, recebendo SITUACAO como query, e verificando se SITUACAO tem aprov ou reprov e passando o fundo e a cor da fonte

aAdd(oSection1:Cell("SITUACAO"):aFormatCond, {"SITUACAO='Aprovado'" ,,CLR_BLUE})
aAdd(oSection1:Cell("SITUACAO"):aFormatCond, {"SITUACAO='Reprovado'" ,,CLR_RED})


//APROVADO EM NEGRITO COM FONTE AZUL E REPROVADO COM FONTE VERMELHA
//Cor := IIF(bbloco1 == "Aprovado", 'CLR_BLUE','CLR_RED')
//aAdd(oSection1:Cell("ZPP_APROV"):cAprovacao, {"ZPP_MEDIA>=7" , "APROVADO","REPROVADO"})
//cAprovacao:= IIF((ZPP_MEDIA>=7), APROVADO, REPROVADO)

//Criar campo no cadastro de aluno de Situação de Material e um "botão" que faça a solicitação ao armazém, após a baixa do material, deve-se atualizar o campo de material com solicitado
// Utilizar tudo até agora, ponto de entrada e executo, precisa ter um botão no cadastro de aluno que possa justamente fazer a solicitação ao armazém, os produtos devem ser passados por parametro e o campo deve ser preenchido

//ocell:= TRCell():New(oSection1,Cell("Média"):SetBlock(aARRAY[1]))
//as informações já foram percorridas pela query, então é só utilizar os valores com alguma lógica de laço e lançar nas celulas
//aAdd(oSection1:Cell("E1_VALOR"):aFormatCond, {"E1_VALOR > 100 .and. E1_VALOR < 1000" ,,CLR_GREEN})
//aAdd(oSection1:Cell("E1_VALOR"):aFormatCond, {"E1_VALOR >= 1000" ,CLR_HGRAY,CLR_RED})
//aAdd(oSection1:Cell("E1_VALOR"):aFormatCond, {"E1_VALOR >= "+cvaltochar(MV_PAR01) ,,CLR_RED})
Return(oReport)
