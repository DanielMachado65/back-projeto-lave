class CreateEstablishments < ActiveRecord::Migration[5.2]
  def change
    create_table :establishments do |t|
      t.references :address, foreign_key: true
      t.references :user, foreign_key: true
      t.string :name
      t.string :cnpj
      t.string :phone
      t.string :fantasy_name
      t.boolean :has_delivery

      t.timestamps
    end
  end
end
