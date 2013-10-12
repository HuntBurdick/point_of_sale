class CreateCustomerWorkOrders < ActiveRecord::Migration
  def up
  	create_table :customer_associations do |t|

  		t.integer :customer_id
  		t.integer :work_order_id

      t.timestamps
    end
  end

  def down
  end
end
