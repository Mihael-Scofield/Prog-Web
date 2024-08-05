class SessionsController < ApplicationController
  def new
  end

  def create
    usuario = Usuario.find_by(username: params[:username])
    if usuario && usuario.authenticate(params[:password])
      session[:usuario_id] = usuario.id
      redirect_to root_path, notice: 'Login realizado com sucesso!'
    else
      flash.now[:alert] = 'Usuário ou senha inválidos'
      render :new
    end
  end

  def destroy
    session[:usuario_id] = nil
    redirect_to root_path, notice: 'Logout realizado com sucesso!'
  end
end

