class CreateItemsSales < ActiveRecord::Migration
  def change
    create_table :items_sales do |t|
    	t.integer :item_id
    	t.integer :sale_id
    end
  end
end
