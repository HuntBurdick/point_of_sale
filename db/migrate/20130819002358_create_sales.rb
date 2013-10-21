class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|

    	t.decimal :total_amount, :precision => 8, :scale => 2
      t.decimal :tax_amount, :precision => 8, :scale => 2
      t.boolean :paid
      t.decimal :amount_paid
    	t.string :payment_type
      t.integer :customer_id
      t.text :comments

      t.boolean :sale
      t.boolean :sale_refunded

      t.boolean :work_order
      t.boolean :work_order_called

      t.string :item_1
      t.text :item_1_description
      t.string :item_2
      t.text :item_2_description
      t.string :item_3
      t.text :item_3_description

      t.date :dropped_off_date
      t.date :promised_by_date

      t.boolean :special_order

      t.timestamps
    end
  end
  def self.down
    drop_table :sales
  end
end
