#Include "TopConn.ch"
#Include "Protheus.ch"

User Function frelatexcel()

local cQuery:= ""
local aDados:= {}
local cAlias:= getNextAlias()
Local oExcel := FWMSEXCEL():New()
local cAba:= "Manutenção de Alunos"
local cTabela:= "Manutenção de Alunos"
local cArquivo:= "Manutenção de Alunos" + ".XMS"
local cPath:= "C:\Temp"
local cDefPath:= GETSRVPROFSTRING("StartPath", "\system\"  )
local i

cQuery := "SELECT * FROM ZPP990 WHERE D_E_L_E_T_ <> '*'"

TCQuery cQuery New ALIAS (cAlias)
(cAlias)-> (DBGOTOP())

while !(cAlias) ->(EOF())
    AADD(aDados,{(cAlias)->ZPP_CODALU,;
    (cAlias)->ZPP_ALUNOS,;
    (cAlias)->ZPP_MEDIA,;
    (cAlias)->ZPP_PROF,;
    (cAlias)->ZPP_STSMAT,;
    .F.})

    (cAlias)->(Dbskip())    
end

if len(aDados) > 0
    //função que verifica se algum aplicativo está instalado
    if !ApOleClient("MSExcel")
        MSGINFO( "Excel não instalado", "Atenção!" )
        return
    endif 
    //adicionar aba da tabela
    oExcel:Addworksheet(cAba)
    //adicionar tabela
    oExcel:AddTable(cAba,cTabela)
    //:AddColumnn(< cWorkSheet >, < cTable >, < cColumn >, [< nAlign >], [< nFormat >], [< lTotal >], [ < cPicture >])
    oExcel:AddColumn(cAba,cTabela,"Código do Aluno"           ,1 , 1, .F.)
    oExcel:AddColumn(cAba,cTabela,"Aluno"                     ,1 , 1, .F.)
    oExcel:AddColumn(cAba,cTabela,"Média"                     ,1 , 1, .F.)
    oExcel:AddColumn(cAba,cTabela,"Professor"                 ,1 , 1, .F.)
    oExcel:AddColumn(cAba,cTabela,"Situação"                  ,1 , 1, .F.)


    for i := 1 to len(aDados)
        //adicionando as linhas com informações do array
        oExcel:AddRow(cAba,cTabela,;
                        {aDados [i] [1]   ,;
                         aDados [i] [2]   ,;
                         aDados [i] [3]   ,; 
                         aDados [i] [4]   ,; 
                         aDados [i] [5]   })
    next i 

    //verificando se as informações a aba está vazia
    if !EMPTY( oExcel:aWorkSheet)
            oExcel:ACTIVATE()
            oExcel:GetXMLfile(cArquivo)
            CPYS2T( cDefPath+cArquivo, cPath)
            oExcel:DeActivate()

            oExcelApp:= MsExcel():New()
            oExcelApp:Workbooks:Open(cPath + cArquivo)
             Sleep(2000) 
            oExcelApp:SetVisible(.T.)
    endif


else 
    Alert("Dados incorretos, não é possivel gerar o relatório")
endif

return
