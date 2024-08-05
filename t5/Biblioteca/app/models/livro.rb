class Livro < ApplicationRecord
  belongs_to :autor
  belongs_to :genero
end
