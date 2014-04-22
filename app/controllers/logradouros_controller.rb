class LogradourosController < ApplicationController
	def listar
		@listar_logradouros = Logradouro.all
	end

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

end