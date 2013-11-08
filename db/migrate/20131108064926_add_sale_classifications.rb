class AddSaleClassifications < ActiveRecord::Migration
  def up
  	add_column :sales, :reservation, :boolean
  	add_column :sales, :pending_parts, :boolean
  	add_column :sales, :layaway, :boolean
  	add_column :sales, :work_order_done, :boolean
  end

  def down
  end
end
