class AddLineItemTotalPrice < ActiveRecord::Migration
  def up
  	add_column :line_items, :total_price, :decimal, :precision => 8, :scale => 2
  end

  def down
  end
end
