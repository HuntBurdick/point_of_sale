class AddCostPriceToItem < ActiveRecord::Migration
  def change
  	add_column :items, :cost_price, :decimal, :precision => 8, :scale => 2
  end
end
