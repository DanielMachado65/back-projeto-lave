class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :telephone
      t.string :name
      t.string :rg
      t.string :cpf

      t.timestamps
    end
  end
end
