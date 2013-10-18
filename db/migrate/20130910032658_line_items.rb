class LineItems < ActiveRecord::Migration
  def change
  	# create_table :line_items do |t|
   #    t.integer :item_id
   #    t.integer :quantity, :default => 1
   #    t.integer :sale_id
   #    t.integer :work_order_id

   #    t.timestamps
   #  end
  end

  def self.down
    drop_table :line_items
  end
end
