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


end