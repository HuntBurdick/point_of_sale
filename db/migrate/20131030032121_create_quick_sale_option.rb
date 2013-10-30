class CreateQuickSaleOption < ActiveRecord::Migration
  def up
  	add_column :sales, :quick_sale, :boolean
  end

  def down
  end
end
