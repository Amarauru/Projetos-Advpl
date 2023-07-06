User Function M185GRV()

	Local aArea:= GetArea()
    //local cNomes:= ""
//ponto de entrada, quando a baixa for realizada, aqui deverá ter a logica de manda as informações da situação da solicitação para o campo de cadastro dos alunos
//eu quero que atualize o status da solicitação ao dar baixa, que os status apareça como concluido
// o programa não sabe de que tabela puxar a informação sobre o aluno que estava posicionado, essa informação é armazenada no CP_OBS, em outra tabela

//DbSelectArea: Define a especifica área de trabalho ativa, todas as proximas operações vão fazer referência a essa area de trabalho, ao menos que especifique outra
//DbSetOrder: Define a ordem do indice que deve-se buscar na tabela ativa
//Dbseek: posiciona o cursor da área de trabalho ativa no registro com as informações especificas passadas

	//DBSELECTAREA("SCP")
	//SCP->(DBSETORDER(5)) //Filial + Campo de Obs
	//if (DbSeek(xFilial("SCP") + ALLTRIM(SCP->CP_OBS))) //(DbSeek(xFilial("SCP") + ''))
	//else
	//	MSGINFO("not found",)
	//endif
	//Não precisa posicionar nem pesquisar o campo cp_obs, pois ele já está aberto pq estava posicionado no browser(o que está posicionado já é armazenado)
	//então é só armazenar justamente uma variávrel com as informações e passar com altrim, retirando os campos e pesquisando parecido.

	DBSELECTAREA('ZPP')
	ZPP->(DBSETORDER(1))
    cObs:= SCP->CP_OBS
	if ZPP->(Dbseek(xFilial('ZPP') + ALLTRIM(cObs)))
		MSGINFO("Registro Encontrado",)

		RecLock('ZPP', .F.)
		ZPP->ZPP_STSMAT := "CONCLUÍDO"
		ZPP->(MsUnlock())
		MSGINFO("Material Entregue, verificar o status no cadastro de alunos",)
	else
		MSGINFO( "Tabela não encontrada",)
	end

//ZPP_CODSOL
//Ao clicar na Solicitação, será criada automáticamente (execauto) uma solicitação de material(passado por parametro) ao armazem
//a situação da solicitação deverá constar em um campo no cadastro de alunos
	RestArea(aArea)
Return
