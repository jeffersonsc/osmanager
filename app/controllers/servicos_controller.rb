class ServicosController < ApplicationController

	def novo
		@servico = Servico.new		
	end

	def create
		@servico = Servico.create(nome: params[:servico][:nome] , custo: params[:servico][:custo])
		if @servico.save 
			flash[:notice] = "Criado com sucesso"
			redirect_to action: 'novo'
		end
		
	end

	def editar
		@servicos = Servico.find(params[:servico_id])
	end

end