class ClientesController < ApplicationController

	def index
		redirect_to action: 'listar'
	end

	def novo
		@cliente = Cliente.new
		@ssp = ["AC","AL", "AP", "AM", "BA", "CE", "DF" , "ES" , "GO" ,
						"MA" , "MT" , "MS" , "MG" , "PA" , "PB" , "PR" , "PE" ,
						"PI", "RJ" , "RN" , "RS" , "RO" , "RR" , "SC" , "SP" ,
						"SE" , "TO"]
	end

	def create
		@cliente_novo = Cliente.new
		if params[:cliente][:tp_cliente] == true
			@cliente_novo.tp_cliente = params[:cliente][:tp_cliente] if params[:cliente][:tp_cliente]
			@cliente_novo.nome = params[:cliente][:nome] if params[:cliente][:nome]
			@cliente_novo.nome_mae = params[:cliente][:nome_mae] if params[:cliente][:nome_mae]
			@cliente_novo.nome_pai = params[:cliente][:nome_pai] if params[:cliente][:nome_pai]		
			@cliente_novo.sexo = params[:cliente][:sexo] if params[:cliente][:sexo]
			@cliente_novo.dt_nacimento = params[:cliente][:dt_nacimento] if params[:cliente][:dt_nacimento]		
			@cliente_novo.rg = params[:cliente][:rg] if params[:cliente][:rg]
			@cliente_novo.ssp = params[:cliente][:ssp] if params[:cliente][:ssp]
			@cliente_novo.cpf = params[:cliente][:cpf] if params[:cliente][:cpf]

		else
			@cliente_novo.nome_responsavel = params[:cliente][:nome_responsavel] if params[:cliente][:nome_responsavel]
			@cliente_novo.rz_social = params[:cliente][:rz_social] if params[:cliente][:rz_social]	
			@cliente_novo.ie = params[:cliente][:ie] if params[:cliente][:ie]		
			@cliente_novo.cnpj = params[:cliente][:cnpj] if params[:cliente][:cnpj]
		end

		@cliente_novo.cep = params[:cliente][:cep].to_s if params[:cliente][:cep].to_s
		@cliente_novo.endereco = params[:cliente][:endereco] if params[:cliente][:endereco]
		@cliente_novo.complemento = params[:cliente][:complemento] if params[:cliente][:complemento]
		@cliente_novo.numero = params[:cliente][:numero] if params[:cliente][:numero]
		@cliente_novo.bairro = params[:cliente][:bairro] if params[:cliente][:bairro]
		@cliente_novo.cidade = params[:cliente][:cidade] if params[:cliente][:cidade]
		@cliente_novo.estado = params[:cliente][:estado] if params[:cliente][:estado]
		@cliente_novo.email = params[:cliente][:email] if params[:cliente][:email]
		@cliente_novo.telefone1 = params[:cliente][:telefone1] if params[:cliente][:telefone1]		
		@cliente_novo.telefone2 = params[:cliente][:telefone2] if params[:cliente][:telefone2]
		@cliente_novo.telefone3 = params[:cliente][:telefone3] if params[:cliente][:telefone3]
		@cliente_novo.celular = params[:cliente][:celular] if params[:cliente][:celular]		
		
		@cliente_novo.created_at = Time.now

		if @cliente_novo.save
			flash[:notice] = "Cliente Salvo com sucesso"
			redirect_to(:action => "listar")
		else
			render 'novo'
		end
	end
	def listar
		@lista_clientes = Cliente.all
	end
	def exibir			
			@clientes = Cliente.where(:id => params[:id])
	end
	def  editar
		@clientes = Cliente.find(params[:id])
		@ssp = ["AC","AL", "AP", "AM", "BA", "CE", "DF" , "ES" , "GO" ,
						"MA" , "MT" , "MS" , "MG" , "PA" , "PB" , "PR" , "PE" ,
						"PI", "RJ" , "RN" , "RS" , "RO" , "RR" , "SC" , "SP" ,
						"SE" , "TO"]	
	end

	def update
		@editar_cliente = Cliente.find(params[:cliente][:id])
		if @editar_cliente == true
			@editar_cliente.tp_cliente = params[:cliente][:tp_cliente] if params[:cliente][:tp_cliente]
			@editar_cliente.nome = params[:cliente][:nome] if params[:cliente][:nome]
			@editar_cliente.nome_mae = params[:cliente][:nome_mae] if params[:cliente][:nome_mae]
			@editar_cliente.nome_pai = params[:cliente][:nome_pai] if params[:cliente][:nome_pai]		
			@editar_cliente.sexo = params[:cliente][:sexo] if params[:cliente][:sexo]
			@editar_cliente.dt_nacimento = params[:cliente][:dt_nacimento] if params[:cliente][:dt_nacimento]		
			@editar_cliente.rg = params[:cliente][:rg] if params[:cliente][:rg]
			@editar_cliente.ssp = params[:cliente][:ssp] if params[:cliente][:ssp]
			@editar_cliente.cpf = params[:cliente][:cpf] if params[:cliente][:cpf]

		else
			@editar_cliente.nome_responsavel = params[:cliente][:nome_responsavel] if params[:cliente][:nome_responsavel]
			@editar_cliente.rz_social = params[:cliente][:rz_social] if params[:cliente][:rz_social]	
			@editar_cliente.ie = params[:cliente][:ie] if params[:cliente][:ie]		
			@editar_cliente.cnpj = params[:cliente][:cnpj] if params[:cliente][:cnpj]
		end

		@editar_cliente.cep = params[:cliente][:cep] if params[:cliente][:cep]
		@editar_cliente.endereco = params[:cliente][:endereco] if params[:cliente][:endereco]
		@editar_cliente.complemento = params[:cliente][:complemento] if params[:cliente][:complemento]
		@editar_cliente.numero = params[:cliente][:numero] if params[:cliente][:numero]
		@editar_cliente.bairro = params[:cliente][:bairro] if params[:cliente][:bairro]
		@editar_cliente.cidade = params[:cliente][:cidade] if params[:cliente][:cidade]
		@editar_cliente.estado = params[:cliente][:estado] if params[:cliente][:estado]
		@editar_cliente.email = params[:cliente][:email] if params[:cliente][:email]
		@editar_cliente.telefone1 = params[:cliente][:telefone1] if params[:cliente][:telefone1]		
		@editar_cliente.telefone2 = params[:cliente][:telefone2] if params[:cliente][:telefone2]
		@editar_cliente.telefone3 = params[:cliente][:telefone3] if params[:cliente][:telefone3]
		@editar_cliente.celular = params[:cliente][:celular] if params[:cliente][:celular]		
		
		@editar_cliente.updated_at = Time.now

		if @editar_cliente.save
			flash[:notice] = "Cliente Salvo com sucesso"
			redirect_to action: 'editar' , id: params[:id]
		else
			render 'edit'
		end			
	end

	def bloquear
		@deleta_cliente = Cliente.find_by_sql("
			UPDATE clientes
			SET status='false' , ultima_alteracao='#{Time.now}'
			WHERE id = #{params[:cliente_id]}
		")
		flash[:alert] = "Você bloqueou o cliente"
		redirect_to action: 'listar'
	end
	def desbloquear
		@deleta_cliente = Cliente.find_by_sql("
			UPDATE clientes
			SET status='true' , ultima_alteracao='#{Time.now}'
			WHERE id = #{params[:cliente_id]}
		")
		flash[:alert] = "Você liberou o cliente"
		redirect_to action: 'listar'
	end
end