USER FUNCTION fparametros()

 /*
FWInputBox(cMensagem, cCampoTexto)

cMensagem: A mensagem que ir� aparecer logo acima do campo texto
cCampoTexto: � o campo que ir� receber o conte�do, este pode j� vir preenchido ou em branco.

 GETMV( <nome do par�metro>)

 PUTMV( <nome do par�metro>, <conte�do>, <retorna erro> )
*/

//Definir vari�vel que recebe o parametro de usu�rio no GETMV
	local cNovoUsuario := GETMV("AZ_USER")
//Definir Vari�vel que recebe o parametro de administrador no GETMV
	local cNovoUsuarioADM := GETMV("AZ_ADM")
//Condi��o que verifica se o usu�rio logado est� com o codigo no parametro
	if !__cUserId $ cNovoUsuarioADM
		Alert("Usu�rio n�o � Adm.")
		RETURN
	ENDIF
//Vari�vel sendo atualizada com os valores do InputBox
	cNovoUsuario := FwInputBox("Informe o usu�rio autorizado", cNovoUsuario)
//Vari�vel recebendo o valor posto no parametro atrav�s do PUTMV
	cNovoUsuario := PUTMV("AZ_USER",cNovoUsuario)


//cnovousu�rio vai receber o parametro que se encontra no de usu�rio
//usuario admin a mesma coisa
//verifica��o se o codigo do user logado se encontra no usuario adm
// caso sim, pode executar a caixa para informar um usu�rio autorizado
// coloca o novo usu�rio com o PUTMV no parametro de usu�rio
RETURN
