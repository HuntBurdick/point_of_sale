class CreateCustomerSales < ActiveRecord::Migration
  def up
  	create_table :customer_sales do |t|

  		t.integer :customer_id
  		t.integer :sale_id

      t.timestamps
    end
  end

  def down
  end
end
