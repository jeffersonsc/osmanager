require 'open-uri'
class ClientesController < ApplicationController

	def index
		redirect_to action: 'listar'
	end

	def novo
		@cliente_novo = Cliente.new
	end

	def create
		@cliente_novo = Cliente.new
		@cliente_novo.tp_cliente = params[:cliente][:tp_cliente] if params[:cliente][:tp_cliente]
		@cliente_novo.nome = params[:cliente][:nome] if params[:cliente][:nome]
		@cliente_novo.sexo = params[:cliente][:sexo] if params[:cliente][:sexo]
		@cliente_novo.dt_nacimento = params[:cliente][:dt_nacimento] if params[:cliente][:dt_nacimento]		
		@cliente_novo.cep = params[:cliente][:cep] if params[:cliente][:cep]
		@cliente_novo.endereco = params[:cliente][:endereco] if params[:cliente][:endereco]
		@cliente_novo.numero = params[:cliente][:numero] if params[:cliente][:numero]
		@cliente_novo.bairro = params[:cliente][:bairro] if params[:cliente][:bairro]
		@cliente_novo.cidade = params[:cliente][:cidade] if params[:cliente][:cidade]
		@cliente_novo.estado = params[:cliente][:estado] if params[:cliente][:estado]
		@cliente_novo.email = params[:cliente][:email] if params[:cliente][:email]
		@cliente_novo.telefone1 = params[:cliente][:telefone1] if params[:cliente][:telefone1]		
		@cliente_novo.telefone2 = params[:cliente][:telefone2] if params[:cliente][:telefone2]
		@cliente_novo.telefone3 = params[:cliente][:telefone3] if params[:cliente][:telefone3]
		@cliente_novo.celular = params[:cliente][:celular] if params[:cliente][:celular]
		@cliente_novo.rg = params[:cliente][:rg] if params[:cliente][:rg]
		@cliente_novo.ssp = params[:cliente][:ssp] if params[:cliente][:ssp]
		@cliente_novo.cpf = params[:cliente][:cpf] if params[:cliente][:cpf]
		@cliente_novo.rz_social = params[:cliente][:rz_social] if params[:cliente][:rz_social]	
		@cliente_novo.ie = params[:cliente][:ie] if params[:cliente][:ie]		
		@cliente_novo.cnpj = params[:cliente][:cnpj] if params[:cliente][:cnpj]
		@cliente_novo.updated_at = ""

		if @cliente_novo.save
			flash[:notice] = "Cliente Salvo com sucesso"
			redirect_to(:action => "listar")
		else
			render :action => "novo"
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
	end

	def update
		@editar_cliente = Cliente.find(params[:cliente][:id])
			
		flash[:notice] = "Cliente alterado com sucesso"
		redirect_to action: 'editar' , id: params[:id]
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