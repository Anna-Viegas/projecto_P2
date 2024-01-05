ddata data<- dActual()
inteiro dia, mes, ano, anoA<-dano(), erro
fficheiro file
literal caminho
logico existe
procedimento header ()
	limpatela
	mostre "========================================================================================================\n"
	mostre "                                          SIG / BAI - "+demtexto(data,0)+"                       \n"
	mostre "========================================================================================================\n\n"
fimprocedimento
procedimento continuar()
    literal qualquertecla
    mostre "\n\tClique qualquer tecla para voltar ao menu:"
    leia qualquertecla
    limpatela
fimprocedimento
registo pessoa
	inteiro codCli, telefone, tipoCli, idade
 	literal nome, dataN, di
fimregisto
registo conta
	inteiro codCli, tipoConta
	real saldo
	literal estado, numConta
	ddata dataA
fimregisto
funcao inteiro contar()
	inteiro total
	caminho <- fPastaUtilizador() + "\\documents\\projecto\\BaseD.txt"
	Existe <- fExiste(caminho)
	se nao Existe entao
		fcriar(caminho)
	fimse
	fAbrir(file , caminho, FALSO)	
		limpatela			
		total<-0
		enquanto ftemlinha(file) faca
		fLerLinha(file)
		total<- total+ 1
		fimenquanto
	retorne total
fimfuncao
inteiro clicad <-contar()

funcao logico valTel(inteiro telefone)
	se telefone <900000000 ou telefone >999999999 entao
		retorne falso
	fimse
	retorne verdadeiro
fimfuncao
funcao logico valDi(literal di, inteiro cli)
	inteiro n, verif<-0
	strTamanho(di)
	se cli=0 entao
		se strTamanho (di)=14 entao
			caracter bi[]<-strParaArray(di)
			para n de 0 ate 8
				se carIsNumero (bi[n]) entao
					verif<-verif+1
				fimse
			fimpara
			se verif=9 entao
				para n de 9 ate 10
					se carIsAlfabeto (bi[n]) entao
						verif<-verif+1
					fimse
				fimpara
				se verif=11 entao
					para n de 11 ate 13
					se carIsNumero (bi[n]) entao
						verif<-verif+1
					fimse
					fimpara
					se verif=14 entao 
						retorne verdadeiro
					senao	
						retorne falso
					fimse
				senao
				retorne falso
				fimse
			senao
				retorne falso
			fimse		
		senao
			retorne falso
		fimse
		
	senao
		se strTamanho (di)=10 entao
			caracter nif[]<-strParaArray(di)
			para n de 0 ate 9
				se carIsNumero (nif[n]) entao
					verif<-verif+1
				fimse
			fimpara
			se verif=10 entao
				retorne verdadeiro
			senao
				retorne falso	
			fimse	
		senao
			RETORNE FALSO
		fimse
	fimse
	retorne verdadeiro
fimfuncao
procedimento MostrarDados( pessoa p, inteiro tipo)
			
			limpatela
			header()
			se tipo=0 entao
				mostre "------------------ Preencha os dados do Cliente ---------------------\n\n"
			mostre "\tCódigo do Cliente: ", p.codCli,"\n", "\tTipo de Cliente: ", p.tipoCli,"\n", "\tNome do Cliente: ", p.nome, "\n","\tContacto Telefónico: ", p.telefone, "\n", "\tBilhete de Identidade: ", p.di, "\n"
			senao
				mostre "\tCódigo do Cliente: ", p.codCli,"\n", "\tTipo de Cliente: ", p.tipoCli,"\n", "\tDesignação da Empresa: ", p.nome, "\n","\tContacto Telefónico: ", p.telefone, "\n", "\tNIF: ", p.di, "\n"
			fimse		
fimprocedimento
procedimento valData(inteiro dia, inteiro mes, inteiro ano)
erro<-0
se ano>1910 e ano<2024  entao 
	se mes=2 entao
		se dia>28  ou  dia<1 entao	
			mostre "\n\tDia inserido é inválido, digite novamente\n"
					erro<-2
		fimse
	senao
		se mes=4 ou mes=6 ou mes=9 ou mes=11 entao
			se dia<1 ou dia>30  entao
				mostre "\n\tDia inserido é inválido, digite novamente\n"
				erro<-2
			fimse
		senao
			se mes=1 ou mes=3 ou mes=5 ou mes=7 ou mes=8 ou mes=10 ou mes=12 entao
				se dia>31  e dia<1 entao
					erro<-2
				fimse
			senao
				mostre "\n\tMes inserido é inválido, digite novamente\n"
				erro<-2
			fimse
		fimse	
	fimse
senao
		mostre "\n\tO ano de nascimento/Criação desta entidade, torna-o ilegível a ser um cliente, impossivel cadastrar"
		erro<-3
fimse
fimprocedimento

pessoa cliente[clicad+10]
conta contas[clicad+10]
funcao literal limparVirgula (literal texto_com_virgula)
	retorne strTrocar(texto_com_virgula, ",", "")
fim funcao
procedimento restaurarFicheiro()
	fAbrir(file , caminho, falso)
	inteiro encher
	enquanto ftemlinha(file) faca
	 	para encher de 0 ate clicad-1	
	 		literal client 
			client<- fLerlinha(file)
			literal dadosRep[]<- strRepartir(client, "-")
				cliente[encher].codCli<-strValorInt(dadosRep[0])
				cliente[encher].tipoCli <- strValorInt(dadosRep[1])
				cliente[encher].nome <- dadosRep[2]
				cliente[encher].di <- dadosRep[3]
				cliente[encher].telefone <- strValorInt(dadosRep[4])
				cliente[encher].dataN   <- dadosRep[5]
				cliente[encher].idade <- strValorInt(dadosRep[6])
				contas[encher].codCli <- strValorInt(dadosRep[7])
				contas[encher].tipoConta<- strValorInt(dadosRep[8])
				contas[encher].numConta<- dadosRep[9]
				contas[encher].estado  <- dadosRep[10]
				contas[encher].saldo<- strValorReal(limparVirgula(dadosRep[11]))
				contas[encher].dataA <- dActual()		
	 		fimpara	  	
	fimenquanto
	ffechar(file)
fimprocedimento
procedimento backup()
	fAbrir(file, caminho, verdadeiro)
	literal dadoCliente
	inteiro encher
	para encher de 0 ate clicad-1 	
	se contas[encher].codCli=cliente[encher].codCli entao			
		dadoCliente <- strintparastr(cliente[encher].codCli) +"-"+ strintparastr(cliente[encher].tipoCli) +"-" + cliente[encher].nome +"-"+cliente[encher].di +"-" + strintparastr(cliente[encher].telefone) +"-"+cliente[encher].dataN +"-" + strintparastr(cliente[encher].idade)+ "-"+  strintparastr(contas[encher].codCli) +"-"+ strintparastr(contas[encher].tipoConta) + "-"+ contas[encher].numConta +"-" + contas[encher].estado +"-" + strRealParaStr(contas[encher].saldo)+"-"+ demtexto(contas[encher].dataA , 1) 		
	    fescrever( file ,  dadoCliente)
	    fNovaLinha(file) //Mudança de Linha 
	fimse
	fimpara
	  ffechar(file)
fimprocedimento

funcao logico cadastro (pessoa p)
		conta c
		cliente[clicad].codCli<-p.codCli
		cliente[cliCad].tipoCli<- p.tipoCli
		cliente[cliCad].nome<- p.nome
		cliente[cliCad].di<- p.di
		cliente[cliCad].telefone<- p.telefone
		cliente[cliCad].dataN<- p.dataN
		cliente[cliCad].idade<- p.idade
		contas[clicad].codCli<- p.codCli
		contas[clicad].numConta<-" Nenhuma conta associada"	
		contas[clicad].estado<-"1"
		contas[clicad].dataA<- dActual()
		cliCad<- cliCad+1
		backup()
	retorne verdadeiro
fimfuncao
procedimento listarClientes()
		inteiro n,codCli, ce<-0
		para n de 0 ate cliCad-1
			se cliente[n].tipoCli=0 entao
				mostre "\tCódigo do Cliente: ", cliente[n].codCli, "\n"	
				mostre "\tTipo de Cliente: Particular(", cliente[n].tipoCli, ")\n"
				mostre "\tNome do Cliente: ", cliente[n].nome, "\n"
				mostre "\tBilhete de Identidade: ", cliente[n].di, "\n"
				mostre "\tContacto Telefónico: ", cliente[n].telefone, "\n"
				mostre "\tData de Nascimento: ", cliente[n].dataN, "\n"
				mostre "\tIdade: ", cliente[n].idade , " anos\n"
				se contas[n].codCli=cliente[n].codCli entao
					se  contas[n].numConta=" Nenhuma conta associada"  entao 
						mostre "\tNúmero Conta: ", contas[n].numConta,"\n"
					senao
						mostre "\tNúmero Conta: ", contas[n].numConta,"\n"
						mostre "\tSaldo: ", contas[n].saldo,"\n"
						mostre "\tEstado: ", contas[n].estado,"\n"
						mostre "\tData de Abertura: ", demtexto(contas[n].dataA, 0), "\n"
						 
							
					fimse
				fimse
				mostre "---------------------------------------------------------------------\n\n"
			senao 
				mostre "\tCódigo do Cliente: ", cliente[n].codCli, "\n"	
				mostre "\tTipo de Cliente: Empresarial(", cliente[n].tipoCli, ")\n"
				mostre "\tDesignação da Empresa: ", cliente[n].nome, "\n"
				mostre "\tNIF: ", cliente[n].di, "\n"
				mostre "\tContacto Telefónico: ", cliente[n].telefone, "\n"
				mostre "\tData de criação: ", cliente[n].dataN, " anos\n"
				mostre "\tTempo no mercado: ", cliente[n].idade , "\n"
				se contas[n].codCli=cliente[n].codCli entao
					se  contas[n].numConta=" Nenhuma conta associada"  entao 
						mostre "\tNúmero Conta: ", contas[n].numConta,"\n"
					senao
						mostre "\tNúmero Conta: ", contas[n].numConta,"\n"
						mostre "\tSaldo: ", contas[n].saldo,"\n"
						mostre "\tEstado: ", contas[n].estado,"\n"
						mostre "\tData de Abertura: ", demtexto(contas[n].dataA, 0), "\n"				
					fimse
				fimse
				mostre "---------------------------------------------------------------------\n\n"
			fimse
		fimpara
fimprocedimento
funcao inteiro buscarCliente(inteiro codigo)
	 inteiro contador
	  para contador de 0 ate clicad-1
		pessoa c <- cliente[contador]
		se c.codCli = codigo entao
			retorne contador
		fim se
	  fim para
	retorne -1
fimfuncao
funcao logico aberturaConta(pessoa p, inteiro TipoConta)
	conta c <- contas[buscarCliente(p.codCli)]	
		se p.tipoCli=tipoConta entao
			c.numConta<- "1000."+ strintparastr(p.codCli)
			c.tipoConta<-p.tipoCli
			faca
				header()
				mostre "----------------------------Abertura de conta--------------------------------\n"
				mostre "\tCódigo do Cliente: ", p.codCli, "\n\tNome: ", p.nome , "\n\tNúmero de conta atribuido: ", c.numConta, "\n"
				mostre "-----------------------------------------------------------------------------\n\n"	
				mostre "\tEstado da Conta (Activa/Bloqueada): "
				leia c.estado
				se c.estado="Activa" ou c.estado="Bloqueada" entao	
					retorne verdadeiro
				fimse
				mostre "Digite uma opção Válida"
				tpause(1500)
			enquanto c.estado<>"Activa" ou c.estado<>"Bloqueada"
		senao
			mostre "\tO Tipo de conta selecionado não é compativel ao tipo de cliente"
			tpause(1500)
			erro<-1
			retorne falso
		fimse
	erro<-0
	retorne verdadeiro
fimfuncao
funcao inteiro buscarConta (literal Nconta)
	  inteiro posicao, nenhuma<-0
	  para posicao de 0 ate Clicad - 1
		conta c <- contas[posicao]
		se c.numConta = nconta entao
			retorne posicao
		senao 
			se c.numConta =" Nenhuma conta associada" entao
				nenhuma<- nenhuma+1
			fimse
			se nenhuma=clicad entao
				retorne -2
			fimse
		fimse
		
			
	  fimpara

	retorne -1
fimfuncao
funcao logico depositar(literal n,real s)
	inteiro i<- buscarConta (n)
			contas[i].saldo<-contas[i].saldo + s
			escreva "\n---------------------------------------------------------\n"
			mostre "\N\tOBS: Depósito feito com sucesso!\N"
	retorne verdadeiro
fimfuncao
funcao logico levantar(literal n,real s)
	inteiro i<- buscarConta (n)
	se contas[i].saldo>=s entao
		contas[i].saldo<-contas[i].saldo - s
		escreva "\n---------------------------------------------------------\n"
		mostre "\N\tOBS: Levantamento feito com sucesso!\N"
	senao
		escreva "\n---------------------------------------------------------\n"
		mostre "\N\tOBS: Impossivel levantar, saldo insuficiente!\N"
	fimse

	retorne verdadeiro
fimfuncao
funcao logico transferencia(literal n1,literal n2,real s)
	inteiro i<- buscarConta(n1)
	inteiro j<-buscarConta(n2)
	
	se contas[i].saldo>=s entao
		contas[i].saldo<-contas[i].saldo - s
	    contas[j].saldo<-contas[j].saldo + s
		escreva "\n---------------------------------------------------------\n"
		mostre "\N\tOBS: Levantamento feito com sucesso!\N"
	senao
		escreva "\n---------------------------------------------------------\n"
		mostre "\N\tOBS: Impossivel levantar, saldo insuficiente!\N"
	fimse

	retorne verdadeiro
fimfuncao

funcao real consultar(literal n)
	inteiro i<- buscarConta (n)
	retorne contas[i].saldo
fimfuncao
inicio
	restaurarFicheiro()
	pessoa p
	conta c
	inteiro opcao
	faca
	header()
	mostre "\t1-Cadastrar Cliente\n\t2-Listar Clientes\n\t3-Abertura de Conta\n\t4-Depositar dinheiro\n\t5-Levantar dinheiro\n\t6-Consultar Saldo\n\t7-Transferir Dinheiro\n\t8-Actualizar dados do Cliente\n\t9-Sair\n\n"
	mostre "\tOpção: "
	leia opcao
	escolha opcao
	caso 1:
		
		p.codCli<-clicad+1
		faca
		limpatela
		header()
		mostre "------------------ Preencha os dados do Cliente ---------------------\n\n"
		mostre "\tSelecione o tipo de cliente com base nas opções abaixo: \n\n\t0-Particular\n\t1-Empresarial\n\n\tOpção: "
		leia p.tipoCli
		escolha p.tipoCli
		caso 0:
			limpatela
			header()
			mostre "------------------ Preencha os dados do Cliente ---------------------\n\n"
			mostre "\tCódigo do Cliente: ", p.codCli,"\n"
			mostre "\tTipo de Cliente: ", p.tipoCli,"\n"
			mostre "\tNome do Cliente: "
			leia p.nome
			faca
			limpatela
			header()
			mostre "------------------ Preencha os dados do Cliente ---------------------\n\n"
			mostre "\tCódigo do Cliente: ", p.codCli,"\n", "\tTipo de Cliente: ", p.tipoCli,"\n", "\tNome do Cliente: ", p.nome, "\n"
			mostre "\tContacto Telefónico: "

			leia p.telefone
			valTel(p.telefone)
			se valTel(p.telefone)=falso entao
				mostre "\n\tOBS: Digite um número de telefone válido.\n"
				tpause(2000)
			fimse
			enquanto valTel(p.telefone)=falso
			faca
			limpatela
			header()
			mostre "------------------ Preencha os dados do Cliente ---------------------\n\n"
			mostre "\tCódigo do Cliente: ", p.codCli,"\n", "\tTipo de Cliente: ", p.tipoCli,"\n", "\tNome do Cliente: ", p.nome, "\n","\tContacto Telefónico: ", p.telefone, "\n"
			mostre "\tBilhete de Identidade: "
			leia p.di
			valDi(p.di, p.tipoCli)
			se valDi(p.di, p.tipoCli)=falso entao
				mostre "\n\tOBS: Numero de BI inválido, digite novamente\n"
				tpause(2000)
			fimse
			enquanto valDi(p.di, p.tipoCli)=falso
			faca
			faca
			MostrarDados(p, p.tipoCli)
			mostre "\tData de Nascimento (dd/mm/aaaa): "
			leia dia
			MostrarDados(p,  p.tipoCli)
			mostre "\tData de Nascimento (dd/mm/aaaa): ",  dia, "/"
			leia mes 
			MostrarDados(p,  p.tipoCli)
			mostre "\tData de Nascimento (dd/mm/aaaa): ",  dia, "/", mes, "/"
			leia ano
			erro<-0
			se dia>99 ou dia<1 ou mes>99 ou mes<1 ou ano>9999 ou ano<1000 entao
				erro<-1
				mostre "\n\tformato iválido, digite corretamente a data de nascimento"
				tpause (1500)
				limpatela
			fimse
			enquanto erro=1
			valData(dia, mes, ano)
			se erro=2 entao
			tpause (2000)
			fimse
			enquanto erro=2
			se erro<>2 e erro<>3 entao
			p.dataN<- strintparastr(dia)+ "/"+ strintparastr(mes) +"/"+strintparastr(ano)
			p.idade<-anoA-ano
			fimse
		caso 1:
			limpatela
			header()
			mostre "------------------ Preencha os dados do Cliente ---------------------\n\n"
			mostre "\tCódigo do Cliente: ", p.codCli,"\n", "\tTipo de Cliente: ", p.tipoCli,"\n"
			mostre "\tDesignação da Empresa: "
			leia p.nome
			faca
			limpatela
			header()
			mostre "------------------ Preencha os dados do Cliente ---------------------\n\n"
			mostre "\tCódigo do Cliente: ", p.codCli,"\n", "\tTipo de Cliente: ", p.tipoCli,"\n", "\tDesignação da Empresa: ", p.nome, "\n"
			mostre "\tContacto Telefónico: "
			leia p.telefone
			valTel(p.telefone)
			se valTel(p.telefone)=falso entao
				mostre "\n\tOBS: Digite um número de telefone válido.\n"
				tpause(2000)
			fimse
			enquanto valTel(p.telefone)=falso
			faca
			limpatela
			header()
			mostre "------------------ Preencha os dados do Cliente ---------------------\n\n"
			mostre "\tCódigo do Cliente: ", p.codCli,"\n", "\tTipo de Cliente: ", p.tipoCli,"\n", "\tDesignação da Empresa: ", p.nome, "\n", "\tContacto Telefónico: ",  p.telefone, "\n"
			mostre "\tNIF: "
			leia p.di
			valDi(p.di, p.tipoCli)
			se valDi(p.di, p.tipoCli)=falso entao
				mostre "\n\tOBS: NIF inválido, digite novamente\n"
				tpause(2000)
			fimse
			enquanto valDi(p.di, p.tipoCli)=falso
			faca
			faca
			MostrarDados(p,  p.tipoCli)
			mostre "\tData de Criação (dd/mm/aaaa): "
			leia dia
			MostrarDados(p,  p.tipoCli)
			mostre "\tData de criação (dd/mm/aaaa): ",  dia, "/"
			leia mes 
			MostrarDados(p,  p.tipoCli)
			mostre "\tData de criação (dd/mm/aaaa): ",  dia, "/", mes, "/"
			leia ano
			erro<-0
			se dia>99 ou dia<1 ou mes>99 ou mes<1 ou ano>9999 ou ano<1000 entao
				erro<-1
				mostre "\n\tformato iválido, digite corretamente a data de criação"
				tpause (1500)
				limpatela
			fimse
			enquanto erro=1
			valData(dia, mes, ano)
			se erro=2 entao
			tpause (2000)
			fimse
			enquanto erro=2
			se erro<>2 e erro<>3 entao
			p.dataN<- strintparastr(dia)+ "/"+ strintparastr(mes) +"/"+strintparastr(ano)
			p.idade<-anoA-ano
			fimse		
		defeito: 
			mostre "\tOpção Inválida\n"
			tpause(1500)
		fimescolha
		enquanto p.tipoCli<>0 e p.tipoCli<>1  
		cadastro(p)
		mostre "-----------------------------------------------------------------------------\n\n"	
		mostre "\tOBS: Cliente cadastrado com Sucesso!\n"	
		continuar()	
	caso 2: 
		header()
		mostre "---------------------------- Lista dos Clientes--------------------------------\n\n"
		listarClientes()
		continuar()
	caso 3:
		inteiro codCli, tipoConta
		faca
		header()
		mostre "----------------------------Abertura de conta--------------------------------\n"
		mostre "\n\tSegue abaixo a lista dos clientes Cadastrados, selecione o código do cliente à adicionar a conta: \n\n"
		listarClientes()
		mostre "\tCódigo do Cliente: "
		leia codCli
		inteiro retorno <- buscarCliente(codCli)
		se  retorno=-1 entao
			mostre "\n\tOBS: Cliente não encontrado, digite novamente"
			tpause(1500)
		senao
			p<- cliente[retorno]
			se contas[retorno].numConta<>" Nenhuma conta associada" entao
				header()
				mostre "----------------------------Abertura de conta--------------------------------\n"
				mostre "\tCódigo do Cliente: ", codCli, "\n\tNome: ", cliente[retorno].nome , "\n"
				mostre "-----------------------------------------------------------------------------\n\n"
				mostre"\tOBS: O Cliente Selecionado já possui uma conta."
			senao
				faca
				erro<-0
				header()
				mostre "----------------------------Abertura de conta--------------------------------\n"
				mostre "\tCódigo do Cliente: ", codCli, "\n\tNome: ", cliente[retorno].nome , "\n"
				mostre "-----------------------------------------------------------------------------\n\n"
				mostre "\tSelecione o tipo de Conta: \n\t0-Particular\n\t1-Empresarial: \n\tOpção: "
				leia tipoConta
				aberturaConta(p, tipoConta)
				enquanto erro=1
				se aberturaConta(p, tipoConta)= verdadeiro entao
					header()
					mostre "----------------------------Abertura de conta--------------------------------\n"
					mostre "\tCódigo do Cliente: ", p.codCli, "\n\tNome: ", p.nome , "\n\tNúmero de conta atribuido: ", contas[retorno].numConta, "\n",  "\tEstado da Conta: ", contas[retorno].estado, "\n"
					mostre "-----------------------------------------------------------------------------\n\n"	
					mostre "\tOBS: Conta Criada com Sucesso!\n"		
				fimse	 
			fimse
		fimse	
		enquanto retorno=-1 
		backup()
		restaurarFicheiro()
		continuar()	
	caso 4:
		faca 
		header()
		mostre "---------------------------- Depositar Dinheiro --------------------------------------\n"	
		mostre "\n\tNúmero da Conta a depositar: "
		literal num
		leia num
		inteiro retorno <- buscarConta(num)
		se retorno =-2 entao
			mostre "\n\tOBS: Nenhuma Conta Criada"
			tpause(2000)
		senao
			se  retorno=-1 entao
				mostre "\n\tOBS: Conta não encontrada, digite novamente"
				tpause(1500)
			senao
				real saldo
				mostre "\tDigite o valor a depositar: "
				leia saldo
				depositar (num,saldo)	
			fimse
		fimse
		enquanto retorno=-1	
		backup()
		restaurarFicheiro()
		continuar()
	caso 5: 
		faca
		header()
		mostre "---------------------------- Levantar Dinheiro --------------------------------------\n"	
		mostre "\n\tNúmero da Conta a retirar valores: "
		literal num
		leia num
		inteiro retorno <- buscarConta(num)
		se retorno =-2 entao
			mostre "\n\tOBS: Nenhuma Conta Criada"
			tpause(2000)
		senao
			se  retorno=-1 entao
				mostre "\n\tOBS: Conta não encontrada, digite novamente"
				tpause(1500)
			senao
			   faca
				real saldo
				mostre "\tDigite o valor a retirar: "
				leia saldo
				se saldo>0 entao
					levantar (num,saldo)
					tpause(2000)
				senao
					mostre "\n\tOBS: Valor Inválido, digite novamente"
				tpause(1500)
				fimse
				enquanto saldo<0	
			fimse
		fimse
		enquanto retorno=-1	
		backup()
		restaurarFicheiro()
		continuar()
	caso 6:
		faca 
		header()
		mostre "---------------------------- Consultar Saldo --------------------------------------\n"	
		mostre "\n\tNúmero da Conta a Consultar: "
		literal num
		leia num
		inteiro retorno <- buscarConta(num)
		se retorno =-2 entao
			mostre "\n\tOBS: Nenhuma Conta Criada"
			tpause(2000)
		senao
			se  retorno=-1 entao
				mostre "\n\tOBS: Conta não encontrada, digite novamente"
				tpause(1500)
			senao
				consultar (num)
				real saldo<- consultar (num)
				mostre "\tSaldo Disponível: ",saldo, "\n"
				tpause(2000)	
			fimse
		fimse
		enquanto retorno=-1	
		backup()
		restaurarFicheiro()
		continuar()
	caso 7:
		faca 
		
			header()
			mostre "---------------------------- Transferencia --------------------------------------\n"	
			literal cReceber,cRetirar
			mostre "\n\tNúmero da Conta a Retirar: "
			leia cRetirar
			inteiro retorno<-buscarConta(cRetirar)
			se retorno =-2 entao
				mostre "\n\tOBS: Nenhuma Conta Criada"
				tpause(2000)
			senao
				se  retorno=-1 entao
					mostre "\n\tOBS: Conta não encontrada, digite novamente"
					tpause(1500)
				senao
				  faca
				    mostre "\n\tNúmero da Conta a Receber: "
				    leia cReceber
					inteiro retorno2<-buscarConta(cReceber)
					se  retorno2=-1 entao
						mostre "\n\tOBS: Conta não encontrada, digite novamente"
						tpause(1500)
					senao
					   faca
							real saldo
							mostre "\tDigite o valor a retirar: "
							leia saldo
							se saldo>0 entao
							
								transferencia(cRetirar,cReceber,saldo)
								tpause(2000)
							senao
								mostre "\n\tOBS: Valor Inválido, digite novamente"
								tpause(1500)
							fimse
					   enquanto saldo<0	
					fimse
				enquanto retorno2=-1
				fimse
			fimse
		enquanto retorno=-1	
		backup()
		restaurarFicheiro()
		continuar()
	caso 8:
		inteiro opc
		faca
		header()
		mostre "------------------------ Actualizar dados do Cliente ---------------------------------\n"
		mostre "\tDigite o codigo do cliente que pretende actualizar: "	
		inteiro cod
		leia cod
		inteiro n <- buscarCliente(cod)
		se  n=-1 entao
			mostre "\n\tOBS: Cliente não encontrado, digite novamente"
			tpause(1500)
		senao
			inteiro ce<-0
			se cliente[n].tipoCli=0 entao
				mostre "\tCódigo do Cliente: ", cliente[n].codCli, "\n"	
				mostre "\tTipo de Cliente: ", cliente[n].tipoCli, "\n"
				mostre "\tNome do Cliente: ", cliente[n].nome, "\n"
				mostre "\tBilhete de Identidade: ", cliente[n].di, "\n"
				mostre "\tContacto Telefónico: ", cliente[n].telefone, "\n"
				mostre "\tData de Nascimento: ", cliente[n].dataN, "\n"
				mostre "\tIdade: ", cliente[n].idade , "\n"
				se contas[n].codCli=cliente[n].codCli entao
					se  contas[n].numConta=" Nenhuma conta associada"  entao 
						mostre "\tNúmero Conta: ", contas[n].numConta,"\n"
					senao
						mostre "\tNúmero Conta: ", contas[n].numConta,"\n"
						mostre "\tSaldo: ", contas[n].saldo,"\n"
						mostre "\tEstado: ", contas[n].estado,"\n"
						mostre "\tData de Criação: ", demtexto(contas[n].dataA, 0), "\n"
						 
							
					fimse
				fimse
				mostre "---------------------------------------------------------------------\n\n"
			senao 
				ce<-ce+1
			fimse
			se ce>0 e cliente[n].tipoCli=1 entao
				mostre "\tCódigo do Cliente: ", cliente[n].codCli, "\n"	
				mostre "\tTipo de Cliente: ", cliente[n].tipoCli, "\n"
				mostre "\tDesignação da Empresa: ", cliente[n].nome, "\n"
				mostre "\tNIF: ", cliente[n].di, "\n"
				mostre "\tContacto Telefónico: ", cliente[n].telefone, "\n"
				mostre "\tData de criação: ", cliente[n].dataN, "\n"
				mostre "\tTempo no mercado: ", cliente[n].idade , "\n"
				mostre "\tNúmero de conta: ", contas[n].numConta, "\n"
				se contas[n].codCli=cliente[n].codCli entao
					se  contas[n].numConta="Nenhuma conta associada"  entao 
						mostre "\tNúmero Conta: ", contas[n].numConta,"\n"
					senao
						mostre "\tNúmero Conta: ", contas[n].numConta,"\n"
						mostre "\tSaldo: ", contas[n].saldo,"\n"
						mostre "\tEstado: ", contas[n].estado,"\n"
						mostre "\tData de Criação: ", demtexto(contas[n].dataA, 0), "\n"				
					fimse
				fimse
				mostre "---------------------------------------------------------------------\n\n"
			fimse
			mostre "\tEscolha o campo que deseja editar:\n\n\t1-Nome/Designação\n\t2-NIF/BI\n\t3-Contacto Telefónico\n\t4-Data de Criação/Nascimento\n\t5-Voltar ao menu"
			
			literal repete
			leia opc
				escolha opc 
					caso 1: 
						header()
						mostre "------------------------ Actualizar dados do Cliente ---------------------------------\n"
						mostre "\tNome Actual: ",cliente[n].nome, "\n" 
						literal nome	
						mostre "\tNovo Nome: " 
						leia nome
						cliente[n].nome<- nome
						mostre "-----------------------------------------------------------------------------\n\n"	
						mostre "\tOBS: Informação Editada com sucesso com Sucesso, deseja editar mais alguma coisa? (S/N)\n"
						leia repete
						escolha repete
							caso "N":
									opc<-5
							caso "S":
								defeito:
									mostre "\tDigite uma opção Valida"
						fimescolha
				caso 2:
					header()
						mostre "------------------------ Actualizar dados do Cliente ---------------------------------\n"
						mostre "\tBI/NIF Actual: ",cliente[n].di, "\n" 
						literal editado	
						faca
							mostre "\tNovo BI/NIF: " 
							leia editado
							valDi(editado, cliente[n].tipoCli)
							se valDi(editado, cliente[n].tipoCli)=falso entao
								mostre "\n\tOBS: BI/NIF inválido, digite novamente\n"
								tpause(2000)
							fimse
						enquanto valDi(editado, cliente[n].tipoCli)=falso
						cliente[n].di<- editado
						mostre "---------------------------------------------------------------------------------------\n\n"	
						mostre "\tOBS: Informação Editada com sucesso com Sucesso, deseja editar mais alguma coisa? (S/N)\n"
						leia repete
						escolha repete
							caso "N":
									opc<-5
							caso "S":
								defeito:
									mostre "\tDigite uma opção Valida"
						fimescolha
				caso 3:
					header()
						mostre "------------------------ Actualizar dados do Cliente ---------------------------------\n"
						mostre "\tTelefone Actual: ",cliente[n].telefone, "\n" 
						inteiro	t
						faca
						mostre "\tNovo Telefone: " 
						leia t 
						valTel(t)
						se valTel(t)=falso entao
							mostre "\n\tOBS: Digite um número de telefone válido.\n"
							tpause(2000)
						fimse
						enquanto valTel(t)=falso
						cliente[n].telefone<- t
						mostre "-------------------------------------------------------------------------------------\n\n"	
						mostre "\tOBS: Informação Editada com sucesso com Sucesso, deseja editar mais alguma coisa? (S/N)\n"
						leia repete
						escolha repete
							caso "N":
									opc<-5
							caso "S":
								defeito:
									mostre "\tDigite uma opção Valida"
						fimescolha
					caso 4:
			inteiro dia, mes, ano
			faca
			header()
			mostre "------------------------ Actualizar dados do Cliente ---------------------------------\n"
			mostre "\tData Actual: ",cliente[n].dataN, "\n" 
			faca 
			mostre "\tNova Data (dd/mm/aaaa): "
			leia dia
			header()
			mostre "------------------------ Actualizar dados do Cliente ---------------------------------\n"
			mostre "\tData Actual: ",cliente[n].dataN, "\n" 
			mostre "\tNova Data (dd/mm/aaaa): ",  dia, "/"
			leia mes 
			header()
			mostre "------------------------ Actualizar dados do Cliente ---------------------------------\n"
			mostre "\tData Actual: ",cliente[n].dataN, "\n" 
			mostre "\tNova Data (dd/mm/aaaa): ",  dia, "/", mes, "/"
			leia ano
			erro<-0
			se dia>99 ou dia<1 ou mes>99 ou mes<1 ou ano>9999 ou ano<1000 entao
				erro<-1
				mostre "\n\tformato iválido, digite corretamente a data de nascimento"
				tpause (1500)
				limpatela
			fimse
			enquanto erro=1
			valData(dia, mes, ano)
			se erro=2 entao
			tpause (2000)
			fimse
			enquanto erro=2
			se erro<>2 e erro<>3 entao
			cliente[n].dataN<- strintparastr(dia)+ "/"+ strintparastr(mes) +"/"+strintparastr(ano)
						mostre "-----------------------------------------------------------------------------\n\n"	
						mostre "\tOBS: Informação Editada com sucesso com Sucesso, deseja editar mais alguma coisa? (S/N)\n"
						leia repete
						escolha repete
							caso "N":
									opc<-5
							caso "S":
								defeito:
									mostre "\tDigite uma opção Valida"
						fimescolha
			fimse
			defeito:	
				fimescolha
				fimse
		enquanto opc<>5
		backup()
		restaurarFicheiro()
		caso 9: 
		header()
		mostre "------------------------ Programa Terminado ---------------------------------\n"
		backup()	
	defeito: 
	fimescolha
	
	enquanto opcao<>9
	backup()
fimalgoritmo