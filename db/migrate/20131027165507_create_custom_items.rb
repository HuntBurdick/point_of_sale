class CreateCustomItems < ActiveRecord::Migration
  def change
    create_table :custom_items do |t|
      t.string :name
      t.text :description
      t.integer :quantity, :default => 1
      t.integer :sale_id
      t.decimal :price, :precision => 8, :scale => 2
      t.decimal :total_price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
