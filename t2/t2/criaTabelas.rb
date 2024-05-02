require 'rubygems'
require 'active_record'
require_relative 'filiacao'
require_relative 'itens'
require_relative 'personagem'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'database.sqlite3'
)

    ActiveRecord::Base.connection.create_table :filiacaos do |t|
        t.string        :ideologia
        t.references    :personagem, foreign_key: true
    end

    ActiveRecord::Base.connection.create_table :itens do |t|
        t.string        :nave
        t.string        :sabre
        t.string        :pistola
        t.references    :personagem, foreign_key: true
    end

    ActiveRecord::Base.connection.create_table :personagems do |t|
        t.string        :nome
        t.string        :sobrenome
        t.string        :ama
        t.string        :odeia
        t.references    :filiacao, foreign_key: true
    end