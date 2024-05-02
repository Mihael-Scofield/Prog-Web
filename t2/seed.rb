require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'database.sqlite3'
)

# Definição das tabelas
class Pessoa < ActiveRecord::Base
  has_one :endereco
  has_many :telefones
end

class Endereco < ActiveRecord::Base
  belongs_to :pessoa
end

class Telefone < ActiveRecord::Base
  belongs_to :pessoa
end