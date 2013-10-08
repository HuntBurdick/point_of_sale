class LineItems < ActiveRecord::Migration
  def up
  	create_table :line_items do |t|
      t.integer :item_id
      t.integer :quantity, :default => 1
      t.integer :sale_id
      t.integer :work_order_id

      t.timestamps
    end
  end

  def down
  end
end
