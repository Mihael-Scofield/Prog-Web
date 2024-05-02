# -*- coding: utf-8 -*-
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'database.sqlite3'
)

class Filiacao < ActiveRecord::Base;
  has_many  :personagem
end


