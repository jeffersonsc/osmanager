require 'open-uri'
def buscacep
	cep = params[:cliente][:cep]
	puts "#{#####################################################}"
	puts cep
	url = "http://cep.republicavirtual.com.br/web_cep.php?formato=xml&cep=" + cep
	reg = open (url).read.split("&")

	@dados[:sucesso] = 
	@dados[:rua] =
	@dados[:bairro] = 
	@dados[:estado] =
	
end