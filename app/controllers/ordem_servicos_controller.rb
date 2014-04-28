class OrdemServicosController < ApplicationController
	
	def listar
		@os = OrdemServico.all	
	end

	def novo
		status = "status = false"
		@nova_os = OrdemServico.new		
		@cliente_id = Cliente.where(status)
		@funcionario_id = Funcionario.where(status)
		@servico_id = Servico.where(status)
	end

	def create
		
	end
	
	def exibir
		
	end

	def editar
		
	end

	def update
		
	end


end