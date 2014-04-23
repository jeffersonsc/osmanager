class ClientesController < ApplicationController

	def index
		redirect_to action: 'listar'
	end
	def novo
		@cliente_novo = Cliente.new
		@endereco = Logradouro.where("status = 'true'")
	end

	def create

		query = "INSERT INTO clientes
			(endereco_id , endereco_n , telefone1 , telefone2 , telefone3 , celular , tp_cliente_id, dt_cadastro , 
			"
		if params[:cliente][:tp_cliente_id] == "1"
			query	<< " nome, rg , cpf )"
			query_data = "'#{params[:cliente][:nome]}' , '#{params[:cliente][:rg]}' , '#{params[:cliente][:cpf]}'"
		else
			query	<< " raz_social, cnpj )"
			query_data = "'#{params[:cliente][:raz_social]}' , '#{params[:cliente][:cnpj]}'"
		end
			query << "VALUES
			('#{params[:cliente][:endereco_id]}', '#{params[:cliente][:endereco_n]}', '#{params[:cliente][:telefone1]}',
			'#{params[:cliente][:telefone2]}', '#{params[:cliente][:telefone3]}', '#{params[:cliente][:celular]}',
			'#{params[:cliente][:tp_cliente_id]}' , '#{Time.now}' , #{query_data})"

		@criar_cliente = Cliente.find_by_sql(query)
			flash[:notice] = "Cliente slavo com sucesso!"
			redirect_to action: 'listar' 
			
	end
	def listar
		@lista_clientes = Cliente.find_by_sql("
				SELECT
					clientes.id,
					clientes.nome,
					clientes.raz_social,				
					tipos_cliente.nome tp_cliente,
					clientes.status,
					clientes.dt_cadastro,
					clientes.ultima_alteracao
				FROM
					clientes
					INNER JOIN tipos_cliente ON tipos_cliente.id = clientes.tp_cliente_id

				ORDER BY
					clientes.id ;
		")	
	end
	def exibir			
			@exibir_clientes = Cliente.find_by_sql("
				SELECT
					clientes.id,
					clientes.nome,
					clientes.raz_social,
					logradouros.endereco,
					clientes.endereco_n,
					logradouros.bairro,
					logradouros.cidade,
					logradouros.uf,
					clientes.telefone1,
					clientes.telefone2,
					clientes.telefone3,
					clientes.celular,
					clientes.rg,
					clientes.cpf,
					clientes.cnpj,
					tipos_cliente.nome tp_cliente,
					clientes.tp_cliente_id,
					clientes.status,
					clientes.dt_cadastro,
					clientes.ultima_alteracao
				FROM
					clientes
					INNER JOIN logradouros ON logradouros.id = clientes.endereco_id
					INNER JOIN tipos_cliente ON tipos_cliente.id = clientes.tp_cliente_id

				WHERE
					clientes.id = #{params[:id]}
			")
		

	end
	def  editar
		@endereco = Logradouro.find_by_sql("
			SELECT
				id,	endereco,	bairro,	cidade,	uf
			FROM
				logradouros
		")
		
		@editar_cliente = Cliente.find_by_sql ("SELECT * FROM clientes WHERE id = #{params[:id]}")
	end

	def update
		@editar_cliente = Cliente.find_by_sql("
			UPDATE 
				clientes
			SET
				nome = '#{params[:cliente][:nome]}', endereco_id = '#{params[:cliente][:endereco_id]}', endereco_n = '#{params[:cliente][:endereco_n]}', telefone1 = '#{params[:cliente][:telefone1]}',
					telefone2 = '#{params[:cliente][:telefone2]}', telefone3 = '#{params[:cliente][:telefone3]}', celular = '#{params[:cliente][:celular]}', rg = '#{params[:cliente][:rg]}' ,
					 tp_cliente_id = '#{params[:cliente][:tp_cliente_id]}' , status = '#{params[:cliente][:status]}', ultima_alteracao = '#{Time.now}'
			WHERE 
				clientes.id = #{params[:id]}

		")
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