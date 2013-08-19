class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
    	t.string :sku
    	t.string :name
    	t.text :description
    	t.decimal :price, :precision => 8, :scale => 2
    	t.attachment :image_url
    	t.integer :stock_amount


      t.timestamps
    end
  end
end
