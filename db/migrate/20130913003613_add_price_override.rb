class AddPriceOverride < ActiveRecord::Migration
  def up
  	add_column :sales, :price_override, :decimal, :precision => 8, :scale => 2
  end

  def down
  end
end
