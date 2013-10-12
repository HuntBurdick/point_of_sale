class CreateWorkOrders < ActiveRecord::Migration
  def change
    create_table :work_orders do |t|

    	t.decimal :total_amount, :precision => 8, :scale => 2
    	t.string :payment_type
      t.string :status
      t.string :order_number
      t.integer :customer_id
    	
      t.timestamps
    end
  end
end
