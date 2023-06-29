//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

//Posi√ß√µes do Array
Static nPosCodAlu := 1 //Coluna A no Excel
Static nPosNomeAlu := 2 //Coluna B no Excel
Static nPosNasc := 3 //Coluna C no Excel
Static nPosDA := 4 //Coluna D no Excel //trocar
Static nPosNotas1 := 5 //Coluna E no Excel //trocar
Static nPosNotas2 := 6 //Coluna F no Excel //trocar
Static nPosMedia := 7 //Coluna G no Excel //trocar


User Function xImpAlu()
	Local aArea     := GetArea()
	Private cArqOri := ""

	//Mostra o Prompt para selecionar arquivos
	cArqOri := tFileDialog( "CSV files (*.csv) ", 'SeleÁ„o de Arquivos', , , .F., )

	//Se tiver o arquivo de origem
	If ! Empty(cArqOri)

		//Somente se existir o arquivo e for com a extens√£o CSV
		If File(cArqOri) .And. Upper(SubStr(cArqOri, RAt('.', cArqOri) + 1, 3)) == 'CSV'
			Processa({|| fImporta() }, "Importando...")
		Else
			MsgStop("Arquivo e/ou extens„o inv·lida!", "AtenÁ„o")
		EndIf
	EndIf

	RestArea(aArea)
Return

/*-------------------------------------------------------------------------------*
 | Func:  fImporta                                                               |
 | Desc:  FunÁ„o que importa os dados                                            |
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
    Local cCodAlu 
    Local cNomeAlu 
    Local cDA
    Local cNotas1
    Local cNotas2 
    Local cMedia
    Local cNasc
    Private cDirLog    := GetTempPath() + "x_importacao\"
    Private cLog       := ""

     
    //Codigo do produto> B1_COD
    //Descri√ß√£o do produto> B1_DESC
    //Armaz√©m> B1_LOCPAD
    //Unidade de Medida> B1_UM

    //Se a pasta de log n√£o existir, cria ela
    If ! ExistDir(cDirLog)
        MakeDir(cDirLog)
    EndIf
 
    //Definindo o arquivo a ser lido
    oArquivo := FWFileReader():New(cArqOri)
     
    //Se o arquivo pode ser aberto
    If (oArquivo:Open())
 
        //Se n√£o for fim do arquivo
        If ! (oArquivo:EoF())
 
            //Definindo o tamanho da r√©gua
            aLinhas := oArquivo:GetAllLines()
            nTotLinhas := Len(aLinhas)
            ProcRegua(nTotLinhas)
             
            //M√©todo GoTop n√£o funciona (dependendo da vers√£o da LIB), deve fechar e abrir novamente o arquivo
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
                 
                //Se n√£o for o cabe√ßalho (encontrar o texto "C√≥digo" na linha atual)
                If !"codigo" $ Lower(cLinAtu)
                    //Zera as variaveis
                    cCodAlu   := aLinha[nPosCodAlu]
                    cNomeAlu   := aLinha[nPosNomeAlu]
                    cDA   := aLinha[nPosDA]
                    cNasc     := aLinha[nPosNasc]
                    cNotas1  := aLinha[nPosNotas1]
                    cNotas2  := aLinha[nPosNotas2]
                    cMedia  := aLinha[nPosMedia]
                    

                //ImportaÁ„o CSV
                //Realizar um RecLock de Inclus„o de 1 aluno
                //Colocar o fonte como bot„o no browser(pode perguntar que eu guio)
                //ZPP_CODALU; ZPP_Alunos; ZPP_NASCME; ZPP_DA; ZPP_NOTAS1; ZPP_NOTAS2; ZPP_MEDIA
                   /*  DbSelectArea('SB1')
                     (DbSetOrder(1))
                        RecLock('SB1', .T.)
                            SB1->B1_COD  := cCodProd
                            SB1->B1_DESC  := cDescProd
                            SB1->B1_LOCPAD  := cAlu
                            SB1->B1_UM  := cUnidMed*/
            //verificar se o nome do aluno j· existe se j· existir, alterar, se n„o, incluir
                DBSELECTAREA("ZPP")
                DBSETORDER(1)
                //ZPP_CODALU;ZPP_Alunos;ZPP_NASCME;ZPP_DA;ZPP_NOTAS1;ZPP_NOTAS2;ZPP_MEDIA
                //verificaÁ„o se o aluno especifico est· no sistema, se estiver a exclamaÁ„o vai transformar em false e jogar para o else, informando que o aluno j· existe no cadastro
                IF !ZPP->(DbSeek(FWxFilial('ZPP') +PADR(cNomeAlu,TAMSX3("ZPP_ALUNOS")[1])))
                RECLOCK( "ZPP",.T.)
                ZPP->(ZPP_ALUNOS) := cNomeAlu
                ZPP->(ZPP_CODALU):= GetSxEnum("ZPP","ZPP_CODALU")
                ZPP->(ZPP_NASCME):= CTOD(cNasc)
                ZPP->(ZPP_DA):= cDA
                ZPP->(ZPP_NOTAS1):= Val(cNotas1)
                ZPP->(ZPP_NOTAS2):= Val(cNotas2)
                ZPP->(ZPP_MEDIA):= Val(cMedia)
                ZPP->(MsUnlock())
                ELSE
                MSGINFO( "Aluno " + cNomeAlu + " j· est· cadastrado","ATEN«√O!")
                ENDIF
                    cLog += "- Lin" + cValToChar(nLinhaAtu) + ", INCLUS√O CONCLUIDA;" + CRLF
                EndIf
                 
            EndDo
 
            //Se tiver log, mostra ele
            If ! Empty(cLog)
                cLog := "Processamento finalizado, abaixo as mensagens de log: " + CRLF + cLog
                MemoWrite(cDirLog + cArqLog, cLog)
                ShellExecute("OPEN", cArqLog, "", cDirLog, 1)
            EndIf
 
        Else
            MsgStop("Arquivo n√£o tem conte√∫do!", "Aten√ß√£o")
        EndIf
 
        //Fecha o arquivo
        oArquivo:Close()
    Else
        MsgStop("Arquivo n√£o pode ser aberto!", "Aten√ß√£o")
    EndIf
 
    RestArea(aArea)
Return
