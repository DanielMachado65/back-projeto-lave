class CreateOrderStatusLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :order_status_logs do |t|
      t.references :order, foreign_key: true
      t.references :order_status, foreign_key: true

      t.timestamps
    end
  end
end
