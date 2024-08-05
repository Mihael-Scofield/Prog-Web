class LivrosController < ApplicationController
    before_action :require_login
    before_action :require_admin, except: [:index, :show]
    before_action :set_livro, only: [:show, :edit, :update, :destroy]
  
    def index
      @livros = Livro.all
    end
  
    def show
    end
  
    def new
      @livro = Livro.new
    end
  
    def create
      @livro = Livro.new(livro_params)
      if @livro.save
        redirect_to @livro, notice: 'Livro foi criado com sucesso.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @livro.update(livro_params)
        redirect_to @livro, notice: 'Livro foi atualizado com sucesso.'
      else
        render :edit
      end
    end
  
    def destroy
      @livro.destroy
      redirect_to livros_url, notice: 'Livro foi excluído com sucesso.'
    end
  
    private
  
    def set_livro
      @livro = Livro.find(params[:id])
    end
  
    def livro_params
      params.require(:livro).permit(:titulo, :autor_id, :genero_id)
    end
  end
  
  