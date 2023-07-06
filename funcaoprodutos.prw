//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

//Posições do Array
Static nPosProdCodigo := 1 //Coluna A no Excel
Static nPosArm := 2 //Coluna B no Excel
Static nPosDescProd := 3 //Coluna C no Excel
Static nPosUnidMed := 4 //Coluna D no Excel //trocar

User Function xImpCSV()
	Local aArea     := GetArea()
	Private cArqOri := ""

	//Mostra o Prompt para selecionar arquivos
	cArqOri := tFileDialog( "CSV files (*.csv) ", 'Sele��o de Arquivos', , , .F., )

	//Se tiver o arquivo de origem
	If ! Empty(cArqOri)

		//Somente se existir o arquivo e for com a extensão CSV
		If File(cArqOri) .And. Upper(SubStr(cArqOri, RAt('.', cArqOri) + 1, 3)) == 'CSV'
			Processa({|| fImporta() }, "Importando...")
		Else
			MsgStop("Arquivo e/ou extens�o inv�lida!", "Aten��o")
		EndIf
	EndIf

	RestArea(aArea)
Return

/*-------------------------------------------------------------------------------*
 | Func:  fImporta                                                               |
 | Desc:  Fun��o que importa os dados                                            |
 *-------------------------------------------------------------------------------*/
 
Static Function fImporta()
    Local aArea      := GetArea()
    Local cArqLog    := "xImpCSV_" + dToS(Date()) + "_" + StrTran(Time(), ':', '-') + ".log"
    Local nTotLinhas := 0
    Local cLinAtu    := ""
    Local nLinhaAtu  := 0
    Local aLinha     := {}
    Local oArquivo
    Local aLinhas
    Local cCodProd   := ""
    Local cArm   := ""
    Local cDescProd    := ""
    Local cUnidMed  := ""
    Private cDirLog    := GetTempPath() + "x_importacao\"
    Private cLog       := ""
     
//Codigo do produto> B1_COD
//Descrição do produto> B1_DESC
//Armazém> B1_LOCPAD
//Unidade de Medida> B1_UM

    //Se a pasta de log não existir, cria ela
    If ! ExistDir(cDirLog)
        MakeDir(cDirLog)
    EndIf
 
    //Definindo o arquivo a ser lido
    oArquivo := FWFileReader():New(cArqOri)
     
    //Se o arquivo pode ser aberto
    If (oArquivo:Open())
 
        //Se não for fim do arquivo
        If ! (oArquivo:EoF())
 
            //Definindo o tamanho da régua
            aLinhas := oArquivo:GetAllLines()
            nTotLinhas := Len(aLinhas)
            ProcRegua(nTotLinhas)
             
            //Método GoTop não funciona (dependendo da versão da LIB), deve fechar e abrir novamente o arquivo
            oArquivo:Close()
            oArquivo := FWFileReader():New(cArqOri)
            oArquivo:Open()
 
            //Enquanto tiver linhas
            While (oArquivo:HasLine())

                //Incrementa na tela a mensagem
                nLinhaAtu++
                IncProc("Analisando linha " + cValToChar(nLinhaAtu) + " de " + cValToChar(nTotLinhas) + "...")
                 
                //Pegando a linha atual e transformando em array
                cLinAtu := oArquivo:GetLine()
                aLinha  := StrTokArr(cLinAtu, ";")
                 
                //Se não for o cabeçalho (encontrar o texto "Código" na linha atual)
                If !"codigo" $ Lower(cLinAtu)
 
                    //Zera as variaveis
                    cCodProd   := aLinha[nPosProdCodigo]
                    cArm   := aLinha[nPosArm]
                    cDescProd    := aLinha[nPosDescProd]
                    cUnidMed  := aLinha[nPosUnidMed]
 
                     DbSelectArea('SB1')
                     (DbSetOrder(1))
                    
                    //Codigo do produto> B1_COD
                    //Descrição do produto> B1_DESC
                    //Armazém> B1_LOCPAD
                    //Unidade de Medida> B1_UM
                
                        RecLock('SB1', .T.)
            
                            SB1->B1_COD  := cCodProd
                            SB1->B1_DESC  := cDescProd
                            SB1->B1_LOCPAD  := cArm
                            SB1->B1_UM  := cUnidMed


            //verificar se o nome do aluno j� existe se j� existir, alterar, se n�o, incluir

                DBSELECTAREA("ZPP")
                DBSETORDER(1)

                        SB1->(MsUnlock())

                        If SB1->(DbSeek(FWxFilial('SB1') + PADR(cCodProd,TAMSX3("B1_COD")[1]) + PADR(cArm,TAMSX3("B1_LOCPAD")[1])))
                        
                        cLog += "+ Lin" + cValToChar(nLinhaAtu) + ", Codigo do produto: [" + PADR(cCodProd,TAMSX3("B1_COD")[1]) + " do Armazém: " + PADR(cArm,TAMSX3("B1_LOCPAD")[1]) + " - " +;
                            "O seguinte produto foi inserido: " + Alltrim(cDescProd) + "];" + CRLF
 
                    Else
                        cLog += "- Lin" + cValToChar(nLinhaAtu) + ", Codigo do produto e Armazem [" + PADR(cCodProd,TAMSX3("B1_COD")[1]) + PADR(cArm,TAMSX3("B1_LOCPAD")[1]) + "] não encontrados no Protheus;" + CRLF
                    EndIf
                     
                Else
                    cLog += "- Lin" + cValToChar(nLinhaAtu) + ", linha não processada - cabeçalho;" + CRLF
                EndIf
                 
            EndDo
 
            //Se tiver log, mostra ele
            If ! Empty(cLog)
                cLog := "Processamento finalizado, abaixo as mensagens de log: " + CRLF + cLog
                MemoWrite(cDirLog + cArqLog, cLog)
                ShellExecute("OPEN", cArqLog, "", cDirLog, 1)
            EndIf
 
        Else
            MsgStop("Arquivo não tem conteúdo!", "Atenção")
        EndIf
 
        //Fecha o arquivo
        oArquivo:Close()
    Else
        MsgStop("Arquivo não pode ser aberto!", "Atenção")
    EndIf
 
    RestArea(aArea)
Return
