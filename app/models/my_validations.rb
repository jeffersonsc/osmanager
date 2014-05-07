def validate_form
	
	  errors.add(:base , 'Nome é obrigatório') if self.nome.empty?
	  errors.add(:base , 'Sexo é obrigatório') if self.sexo.empty?
	  errors.add(:base , 'A datade nascimento é obrigatório') if self.dt_nacimento.empty?
		errors.add(:base , 'RG é obrigatório') if self.rg.empty?
		errors.add(:base , 'SSP é obrigatório') if self.ssp.empty?
		errors.add(:base , 'CPF é obrigatório') if self.cpf.empty?	
	
	errors.add(:base , 'CEP é obrigatório') if self.cep.empty?
end
