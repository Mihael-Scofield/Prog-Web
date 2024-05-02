loop do
    # Receber a entrada do usuário na linha de comando
    entrada_usuario = gets.chomp
  
    # Verificar se o usuário deseja sair
    break if entrada_usuario.downcase == "sair"
  
    # Dividir a entrada em partes separadas por espaços
    parts = entrada_usuario.split
  
    # Extrair o comando, a tabela e os atributos
    comando = parts.shift
    tabela = parts.shift
    atributos = {}
    parts.each do |part|
      chave, valor = part.split('=')
      atributos[chave.to_sym] = valor
    end
  
    # Executar a operação correspondente com base no comando fornecido pelo usuário
    case comando
    when "insere"
      # Crie um novo objeto do modelo ActiveRecord com os atributos fornecidos e salve no banco de dados.
      objeto = tabela.capitalize.constantize.new(atributos)
      if objeto.save
        puts "#{tabela.capitalize} inserido com sucesso!"
      else
        puts "Erro ao inserir #{tabela.capitalize}: #{objeto.errors.full_messages.join(', ')}"
      end
    when "altera"
      # Encontre o objeto a ser alterado no banco de dados e atualize seus atributos com os valores fornecidos.
      objeto = tabela.capitalize.constantize.find_by(id: atributos[:id])
      if objeto
        if objeto.update(atributos.except(:id))
          puts "#{tabela.capitalize} alterado com sucesso!"
        else
          puts "Erro ao alterar #{tabela.capitalize}: #{objeto.errors.full_messages.join(', ')}"
        end
      else
        puts "#{tabela.capitalize} não encontrado!"
      end
    when "exclui"
      # Encontre o objeto a ser excluído no banco de dados e remova-o.
      objeto = tabela.capitalize.constantize.find_by(id: atributos[:id])
      if objeto
        objeto.destroy
        puts "#{tabela.capitalize} excluído com sucesso!"
      else
        puts "#{tabela.capitalize} não encontrado!"
      end
    when "lista"
      # Listar os elementos da tabela especificada
      elementos = tabela.capitalize.constantize.all
      elementos.each do |elemento|
        puts elemento.inspect
      end
    else
      puts "Comando inválido!"
    end
  end
  
  