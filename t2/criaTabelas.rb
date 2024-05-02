require_relative 'seed'

# Criação do banco de dados e tabelas
ActiveRecord::Schema.define do
  create_table :pessoas do |t|
    t.string :last_name
    t.string :first_name
  end

  create_table :enderecos do |t|
    t.integer :pessoa_id
    t.string :address
    t.string :city
  end

  create_table :telefones do |t|
    t.integer :pessoa_id
    t.string :number
  end
end