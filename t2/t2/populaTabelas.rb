# -*- coding: utf-8 -*-

$:.push './'
require_relative 'filiacao.rb'
require_relative 'itens.rb'
require_relative 'personagem.rb'

# 1. Luke
p = Personagem.new
    ({
      :nome => "Luke",
      :sobrenome => "Skywalker", 
      :ama => "Pilotar",
      :odeia => "Pai"
    })
    
fil = Filiacao.new ({:ideologia => "Jedi"})
fil.personagem = p
fil.save

itens = Itens.new
    ({
      :nave => "Millennium Falcon",
      :sabre => "Verde",
      :pistola => "N/A"
    })

itens.personagem = p
itens.save
p.save