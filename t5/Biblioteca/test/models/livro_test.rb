require 'test_helper'

class LivroTest < ActiveSupport::TestCase
  test "deve ser válido com atributos válidos" do
    autor = Autor.create(nome: 'Autor Teste')
    genero = Genero.create(nome: 'Genero Teste')
    livro = Livro.new(titulo: 'Livro Teste', autor: autor, genero: genero)
    assert livro.valid?
  end

  test "não deve ser válido sem título" do
    livro = Livro.new(titulo: nil)
    assert_not livro.valid?
  end

  test "não deve ser válido sem autor" do
    genero = Genero.create(nome: 'Genero Teste')
    livro = Livro.new(titulo: 'Livro Teste', autor: nil, genero: genero)
    assert_not livro.valid?
  end

  test "não deve ser válido sem genero" do
    autor = Autor.create(nome: 'Autor Teste')
    livro = Livro.new(titulo: 'Livro Teste', autor: autor, genero: nil)
    assert_not livro.valid?
  end
end

