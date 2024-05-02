# -*- coding: utf-8 -*-
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'database.sqlite3'
)

class Itens < ActiveRecord::Base;
  has_and_belongs_to_many  :personagem
end
