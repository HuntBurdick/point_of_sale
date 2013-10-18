class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|

    	t.decimal :total_amount, :precision => 8, :scale => 2
    	t.string :payment_type
      t.string :status
      t.integer :order_number
      t.integer :customer_id
      t.text :comments
      t.boolean :sale_completed
      t.boolean :work_order
      t.boolean :work_order_completed
      t.boolean :work_order_called

      t.timestamps
    end
  end
end
