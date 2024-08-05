class GenerosController < ApplicationController
    before_action :require_login
    before_action :require_admin, except: [:index, :show]
    before_action :set_genero, only: [:show, :edit, :update, :destroy]
  
    def index
      @generos = Genero.all
    end
  
    def show
    end
  
    def new
      @genero = Genero.new
    end
  
    def create
      @genero = Genero.new(genero_params)
      if @genero.save
        redirect_to @genero, notice: 'Gênero foi criado com sucesso.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @genero.update(genero_params)
        redirect_to @genero, notice: 'Gênero foi atualizado com sucesso.'
      else
        render :edit
      end
    end
  
    def destroy
      @genero.destroy
      redirect_to generos_url, notice: 'Gênero foi excluído com sucesso.'
    end
  
    private
  
    def set_genero
      @genero = Genero.find(params[:id])
    end
  
    def genero_params
      params.require(:genero).permit(:nome)
    end
  end
  
  