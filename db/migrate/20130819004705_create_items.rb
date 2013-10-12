class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
    	t.string :sku
    	t.string :name
    	t.text :description
    	t.decimal :price, :precision => 8, :scale => 2
    	t.attachment :image_url
    	t.integer :stock_amount
      t.string :status
      t.string :vendor
      t.decimal :cost_price, :precision => 8, :scale => 2
      t.decimal :price_override, :precision => 8, :scale => 2

      t.boolean :custom_item

      t.timestamps
    end
  end
end
