require 'test_helper'
require 'rack/test'

class LivrosTest < ActionDispatch::IntegrationTest
  include Rack::Test::Methods

  def app
    Rails.application
  end

  test "deve acessar a index de livros" do
    get '/livros'
    assert last_response.ok?
    assert_includes last_response.body, 'Livros'
  end

  test "deve criar um novo livro" do
    autor = Autor.create(nome: 'Autor Teste')
    genero = Genero.create(nome: 'Genero Teste')

    post '/livros', livro: { titulo: 'Novo Livro', autor_id: autor.id, genero_id: genero.id }
    assert last_response.redirect?
    follow_redirect!
    assert last_response.ok?
    assert_includes last_response.body, 'Novo Livro'
  end
end
