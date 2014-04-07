class FuncionariosController < ApplicationController

	def novo
		@funcionario_novo = Funcionario.new
		@endereco = Logradouro.find_by_sql("SELECT	id,	endereco,	bairro,	cidade,	uf	FROM	logradouros	")
	end
	def create
		@criar_funcionario = Funcionario.find_by_sql("
			INSERT INTO
				funcionarios
				( nome, endereco_id , endereco_n , telefone1 , telefone2 , celular , rg , dt_cadastro)
			VALUES
				('#{params[:funcionario][:nome]}', '#{params[:funcionario][:endereco_id]}', '#{params[:funcionario][:endereco_n]}', '#{params[:funcionario][:telefone1]}',
					'#{params[:funcionario][:telefone2]}', '#{params[:funcionario][:celular]}', '#{params[:funcionario][:rg]}' ,
					  '#{Time.now}' )
		")

		flash[:notice] = "Funcionario cadastrado com sucesso"
		redirect_to action: 'listar'
	end
	def listar
		@lista_funcionarios = Funcionario.find_by_sql("SELECT * FROM funcionarios")
	end
	def exibir
		@exibir_funcionarios = Funcionario.find_by_sql("

			SELECT
				funcionarios.id,
				funcionarios.nome,
				logradouros.endereco,
				funcionarios.endereco_n,
				logradouros.bairro,
				logradouros.cidade,
				logradouros.uf,
				funcionarios.telefone1,
				funcionarios.telefone2,					
				funcionarios.celular,
				funcionarios.status,
				funcionarios.rg,					
				funcionarios.dt_cadastro,
				funcionarios.ultima_alteracao
			FROM
				funcionarios
				INNER JOIN logradouros ON logradouros.id = funcionarios.endereco_id				

			WHERE
				funcionarios.id = #{params[:id]}
		")
	end
	def editar
		@endereco = Logradouro.find_by_sql("SELECT	id,	endereco,	bairro,	cidade,	uf	FROM	logradouros	")
		@editar_funcionarios = Funcionario.find_by_sql("SELECT * FROM funcionarios WHERE id = #{params[:id]}")
	end
	def update
		if params[:status] ||= nil
			status = "false"
		else
			status = "true"
		end
		@editar_funcionarios = Funcionario.find_by_sql("
			UPDATE 
				funcionarios
			SET
				nome = '#{params[:funcionario][:nome]}', endereco_id = '#{params[:funcionario][:endereco_id]}', endereco_n = '#{params[:funcionario][:endereco_n]}', telefone1 = '#{params[:funcionario][:telefone1]}',
					telefone2 = '#{params[:funcionario][:telefone2]}', celular = '#{params[:funcionario][:celular]}', rg = '#{params[:funcionario][:rg]}' ,
					 ultima_alteracao = '#{Time.now}' , status='#{status}'
			WHERE 
				funcionarios.id = #{params[:id]}
		")
		flash[:notice] = "Usuário alterado com sucesso"
		redirect_to action: 'exibir', id: params[:id]
	end
	def deletar
		@delete_funcionario = Funcionario.find_by_sql("
			UPDATE
				funcionarios
			SET
				status='false'
			WHERE
				id = '#{params[:id]}'
		")
		redirect_to action: 'listar'
		flash[:alert] = "Você deletou um funcionario"
	end
	def index
		redirect_to action: 'listar'
	end
end