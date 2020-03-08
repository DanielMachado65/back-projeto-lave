class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :establishment, foreign_key: true
      t.references :category, foreign_key: true
      t.float :price
      t.string :name
      t.string :description
      t.boolean :is_active

      t.timestamps
    end
  end
end
