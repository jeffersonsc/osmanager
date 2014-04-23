class LogradourosController < ApplicationController
	
	def novo
		@novo_logradouro = Logradouro.new
		@uf = Tipouf.all
	end

	def create
		query ="INSERT INTO logradouros 
						(endereco , bairro , cidade , uf , criado_em )
						VALUES
						('#{params[:logradouro][:endereco]}', '#{params[:logradouro][:bairro]}', 
						 '#{params[:logradouro][:cidade]}', '#{params[:logradouro][:uf]}', '#{Time.now}')"
		@novo_logradouro = Logradouro.find_by_sql(query)
		flash[:notice] = "Logradouro cadastrado com sucesso"
		redirect_to action: 'listar'
	end

	def listar
		@listar_logradouros = Logradouro.all
	end
	
	def exibir
		@logradouro = Logradouro.where("id = '#{params[:logradouro_id]}'")
	end

	def editar
		@editar_logradouro = Logradouro.find_by_sql("select * from logradouros where id = #{params[:id]}")
		@uf = Tipouf.all
	end
	def update
		query = "UPDATE logradouros 
							SET endereco = '#{params[:logradouro][:endereco]}' , bairro = '#{params[:logradouro][:bairro]}',
							cidade = '#{params[:logradouro][:cidade]}' , uf ='#{params[:logradouro][:uf]}' , status = '#{params[:logradouro][:status]}'
							WHERE 
							id = #{params[:id]} "							
		@editar_logradouro = Logradouro.find_by_sql(query)
		flash[:notice] = "Logradouro Atualizado com sucesso!"
		redirect_to action: 'exibir', logradouro_id: params[:id] 
	end
end