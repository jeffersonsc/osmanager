def validate_form	
  errors.add(:base , 'Nome é obrigatório') if self.nome.empty?
  errors.add(:base , 'Sexo é obrigatório') if self.sexo.blank?
  errors.add(:base , 'A datade nascimento é obrigatório') if self.dt_nacimento.blank?
	errors.add(:base , 'RG é obrigatório') if self.rg.blank?
	errors.add(:base , 'SSP é obrigatório') if self.ssp.blank?
	errors.add(:base , 'CPF é obrigatório') if self.cpf.blank?	
	errors.add(:base , 'CEP é obrigatório') if self.cep.blank?
	errors.add(:base , 'Endereço é obrigatório') if self.endereco.blank?
	errors.add(:base , 'Número é obrigatório') if self.cep.blank?
	errors.add(:base , 'Bairro é obrigatório') if self.bairro.blank?
	errors.add(:base , 'Cidade é obrigatório') if self.cidade.blank?
	errors.add(:base , 'Estado é obrigatório') if self.estado.blank?
	errors.add(:base , 'Telefone 1 é obrigatório') if self.telefone1.blank?
	errors.add(:base , 'Celular é obrigatório') if self.celular.blank?
	errors.add(:base , 'RG é obrigatório') if self.rg.blank?
	errors.add(:base , 'CPF é obrigatório') if self.cpf.blank?

end
