require 'my_validations'

class Cliente < ActiveRecord::Base

self.table_name = 'pessoas'

validate :validate_form

end
