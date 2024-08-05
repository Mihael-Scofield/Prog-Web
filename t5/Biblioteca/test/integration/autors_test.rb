require 'test_helper'
require 'rack/test'

class AutorsTest < ActionDispatch::IntegrationTest
  include Rack::Test::Methods

  def app
    Rails.application
  end

  test "deve acessar a index de autors" do
    get '/autors'
    assert last_response.ok?
    assert_includes last_response.body, 'Autors'
  end

  test "deve criar um novo autor" do
    post '/autors', autor: { nome: 'Novo Autor' }
    assert last_response.redirect?
    follow_redirect!
    assert last_response.ok?
    assert_includes last_response.body, 'Novo Autor'
  end
end

