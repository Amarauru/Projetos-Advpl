USER FUNCTION fparametros()

 /*
FWInputBox(cMensagem, cCampoTexto)

cMensagem: A mensagem que irá aparecer logo acima do campo texto
cCampoTexto: É o campo que irá receber o conteúdo, este pode já vir preenchido ou em branco.

 GETMV( <nome do parâmetro>)

 PUTMV( <nome do parâmetro>, <conteúdo>, <retorna erro> )
*/

//Definir variável que recebe o parametro de usuário no GETMV
	local cNovoUsuario := GETMV("AZ_USER")
//Definir Variável que recebe o parametro de administrador no GETMV
	local cNovoUsuarioADM := GETMV("AZ_ADM")
//Condição que verifica se o usuário logado está com o codigo no parametro
	if !__cUserId $ cNovoUsuarioADM
		Alert("Usuário não é Adm.")
		RETURN
	ENDIF
//Variável sendo atualizada com os valores do InputBox
	cNovoUsuario := FwInputBox("Informe o usuário autorizado", cNovoUsuario)
//Variável recebendo o valor posto no parametro através do PUTMV
	cNovoUsuario := PUTMV("AZ_USER",cNovoUsuario)


//cnovousuário vai receber o parametro que se encontra no de usuário
//usuario admin a mesma coisa
//verificação se o codigo do user logado se encontra no usuario adm
// caso sim, pode executar a caixa para informar um usuário autorizado
// coloca o novo usuário com o PUTMV no parametro de usuário
RETURN
