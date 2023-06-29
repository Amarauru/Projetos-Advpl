

User Function EXMPLA1

	Local cSA1 := "SA1"
	Local lInclui := .T.
	Local lAltera := .F.

	DbSelectArea(cSA1)
	DbSetOrder(2) //A1_FILIAL+A1_NOME+A1_LOJA
	If DbSeek("  LL FRUTAS CIA                           22")
		RecLock("SA1",lAltera)
		SA1->A1_NOME := "LL FRUTAS CIA A                         "
		MsUnLock()
	EndIf

	DbSelectArea(cSA1)
	DbSetOrder(2) //A1_FILIAL+A1_NOME+A1_LOJA
	RecLock("SA1",lInclui)
	SA1->A1_COD := "011   "
	MsUnLock()

Return
