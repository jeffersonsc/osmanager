class ClientesController < ApplicationController

	def novo
		@cliente_novo = Cliente.new
		@endereco = Logradouro.find_by_sql("
			SELECT
				id,
				endereco,
				bairro,
				cidade,
				uf
			FROM
				logradouros
		")
	end

	def create

		@criar_cliente = Cliente.find_by_sql("
			INSERT INTO
				clientes
				( nome, endereco_id , endereco_n , telefone1 , telefone2 , telefone3 , celular , rg , tp_cliente_id, dt_cadastro)
			VALUES
				('#{params[:cliente][:nome]}', '#{params[:cliente][:endereco_id]}', '#{params[:cliente][:endereco_n]}', '#{params[:cliente][:telefone1]}',
					'#{params[:cliente][:telefone2]}', '#{params[:cliente][:telefone3]}', '#{params[:cliente][:celular]}', '#{params[:cliente][:rg]}' ,
					 '#{params[:cliente][:tp_cliente_id]}' , '#{Time.now}' )

		")
		@teste = Cliente.find( :last )
				flash[:notice] = "Cliente slavo com sucesso!"
				redirect_to action: 'listar' 
			
	end
	def listar
		@lista_clientes = Cliente.find_by_sql("
			SELECT
				clientes.id,
				clientes.nome,				
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
				tipos_cliente.nome tp_cliente,
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
end