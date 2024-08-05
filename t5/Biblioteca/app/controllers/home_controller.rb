class HomeController < ApplicationController
   helper_method :current_user, :logged_in?

   def index
    end
  end
  
  def admin?
    !!Usuario.admin
  end