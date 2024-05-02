# -*- coding: utf-8 -*-
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'database.sqlite3'
)

class Personagem < ActiveRecord::Base ;
  has_one  :filiacao
  has_many :itens
end


