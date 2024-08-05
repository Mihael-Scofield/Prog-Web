require 'test_helper'
require 'rack/test'

class GenerosTest < ActionDispatch::IntegrationTest
  include Rack::Test::Methods

  def app
    Rails.application
  end

  test "deve acessar a index de generos" do
    get '/generos'
    assert last_response.ok?
    assert_includes last_response.body, 'Gêneros'
  end

  test "deve criar um novo genero" do
    post '/generos', genero: { nome: 'Novo Genero' }
    assert last_response.redirect?
    follow_redirect!
    assert last_response.ok?
    assert_includes last_response.body, 'Novo Genero'
  end
end

