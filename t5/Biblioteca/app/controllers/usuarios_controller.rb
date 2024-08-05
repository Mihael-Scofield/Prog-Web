class UsuariosController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(usuario_params)
    if @usuario.save
      session[:usuario_id] = @usuario.id
      redirect_to root_path, notice: 'Usuário criado com sucesso!'
    else
      render :new
    end
  end

  private

  def usuario_params
    params.require(:usuario).permit(:username, :password, :password_confirmation, :admin)
  end
end

