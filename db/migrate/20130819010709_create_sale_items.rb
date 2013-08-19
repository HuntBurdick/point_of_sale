class CreateSaleItems < ActiveRecord::Migration
  def change
    create_table :sale_items do |t|
    	t.integer :item_id
    	t.integer :sale_id
    	t.decimal :original_price, :precision => 8, :scale => 2
    	t.decimal :sale_price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
