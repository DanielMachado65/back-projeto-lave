class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :deadline
      t.float :total
      t.string :payment_type
      t.string :order_hash
      t.references :address, foreign_key: true
      t.references :user, foreign_key: true
      t.references :establishment, foreign_key: true

      t.timestamps
    end
  end
end
