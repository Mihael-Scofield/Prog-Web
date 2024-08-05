require 'test_helper'

class GeneroTest < ActiveSupport::TestCase
  test "deve ser válido com atributos válidos" do
    genero = Genero.new(nome: 'Genero Teste')
    assert genero.valid?
  end

  test "não deve ser válido sem nome" do
    genero = Genero.new(nome: nil)
    assert_not genero.valid?
  end
end

