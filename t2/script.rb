require 'optparse'
require_relative 'seed'

options = {}

OptionParser.new do |parser|
  parser.on("--operacao=OPERACAO", "Operação a ser realizada (inclusao, alteracao, exclusao, lista)") do |operacao|
    options[:operacao] = operacao
  end

  parser.on("--tabela=TABELA", "Nome da tabela") do |tabela|
    options[:tabela] = tabela
  end

  parser.on("--atributos=ATRIBUTOS", "Atributos no formato atributo1=valor1,atributo2=valor2,...") do |atributos|
    options[:atributos] = atributos
  end
end.parse!

# Operações
case options[:operacao]
when "inclusao"
  if (options[:tabela].nil? || options[:atributos].nil?)
    puts "Erro: É necessário especificar a tabela e os atributos para a inclusão."
    exit
  end

  tabela_class = Object.const_get(options[:tabela].capitalize)
  atributos = options[:atributos].split(',').map { |pair| pair.split('=') }.to_h
  tabela_class.create(atributos)
when "alteracao"
  if (options[:tabela].nil? || options[:atributos].nil?)
    puts "Erro: É necessário especificar a tabela e os atributos para a alteração."
    exit
  end

  tabela_class = Object.const_get(options[:tabela].capitalize)
  atributos = options[:atributos].split(',').map { |pair| pair.split('=') }.to_h
  id = atributos.delete('id').to_i
  registro = tabela_class.find(id)
  registro.update(atributos)
when "exclusao"
  if (options[:tabela].nil? || options[:atributos].nil?)
    puts "Erro: É necessário especificar a tabela e os atributos para a exclusão."
    exit
  end

  tabela_class = Object.const_get(options[:tabela].capitalize)
  atributos = options[:atributos].split(',').map { |pair| pair.split('=') }.to_h
  id = atributos.delete('id').to_i
  tabela_class.find(id).destroy
when "lista"
  if (options[:tabela].nil?)
    puts "Erro: É necessário especificar a tabela para listar os registros."
    exit
  end

  tabela_class = Object.const_get(options[:tabela].capitalize)
  registros = tabela_class.all
  registros.each { |registro| puts registro.inspect }
else
  puts "Operação inválida."
end
