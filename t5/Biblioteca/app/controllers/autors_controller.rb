class AutorsController < ApplicationController
    before_action :require_login
    before_action :require_admin, except: [:index, :show]
    before_action :set_autor, only: [:show, :edit, :update, :destroy]
  
    def index
      @autors = Autor.all
    end
  
    def show
    end
  
    def new
      @autor = Autor.new
    end
  
    def create
      @autor = Autor.new(autor_params)
      if @autor.save
        redirect_to @autor, notice: 'Autor foi criado com sucesso.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @autor.update(autor_params)
        redirect_to @autor, notice: 'Autor foi atualizado com sucesso.'
      else
        render :edit
      end
    end
  
    def destroy
      @autor.destroy
      redirect_to autors_url, notice: 'Autor foi excluído com sucesso.'
    end
  
    private
  
    def set_autor
      @autor = Autor.find(params[:id])
    end
  
    def autor_params
      params.require(:autor).permit(:nome)
    end
  end
  
  