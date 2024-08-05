class CreateLivros < ActiveRecord::Migration[7.0]
  def change
    create_table :livros do |t|
      t.string :titulo
      t.references :autor, null: false, foreign_key: true
      t.references :genero, null: false, foreign_key: true

      t.timestamps
    end
  end
end
