class ServicosController < ApplicationController

	def novo
		@servico = Servico.new		
	end

	def create
		servico_novo = Servico.create(nome: params[:servico][:nome] , custo: params[:servico][:custo] )
		if @servico.save 
			flash[:notice] = "Criado com sucesso"
			redirect_to action: 'novo'
		end
		
	end

	def listar
		@lista_servicos = Servico.all
	end

	def exibir
		@listar_detalhe = Servico.where(:id => params[:servico_id])
	end

	def editar
		@editar_servico = Servico.find_by(id: params[:servico_id])
	end

	def update
		
		servico_update = Servico.update(params[:id] , :nome => params[:servico][:nome] ,
		 :custo => params[:servico][:custo] , :status => params[:servico][:status] , :ultima_alteracao => Time.now )
		if servico_update.save
			flash[:notice] = "Dados atualizado com sucesso!"
			redirect_to action: 'listar'
		end
	end

end