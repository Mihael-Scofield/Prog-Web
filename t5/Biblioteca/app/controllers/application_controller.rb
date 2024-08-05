class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= Usuario.find(session[:usuario_id]) if session[:usuario_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:error] = "Você precisa estar logado para acessar essa página."
      redirect_to login_path
    end
  end

  def require_admin
    unless current_user&.admin?
      flash[:error] = "Você não tem permissão para acessar essa página."
      redirect_to root_path
    end
  end
end

