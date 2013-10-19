class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|

    	t.decimal :total_amount, :precision => 8, :scale => 2
      t.decimal :amount_paid
    	t.string :payment_type
      t.integer :customer_id
      t.text :comments

      t.boolean :sale_paid
      t.boolean :sale_refunded

      t.boolean :work_order
      t.boolean :work_order_paid
      t.boolean :work_order_called

      t.string :work_order_dropped_off_item_1
      t.string :work_order_dropped_off_item_2
      t.string :work_order_dropped_off_item_3

      t.date :dropped_off_date
      t.date :promised_by_date

      t.boolean :special_order
      t.boolean :special_order_paid

      t.timestamps
    end
  end
  def self.down
    drop_table :sales
  end
end
