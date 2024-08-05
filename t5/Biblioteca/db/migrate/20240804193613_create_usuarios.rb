class CreateUsuarios < ActiveRecord::Migration[7.0]
  def change
    create_table :usuarios do |t|
      t.string :username
      t.string :password_digest
      t.boolean :admin

      t.timestamps
    end
  end
end
