class CreateWorkOrders < ActiveRecord::Migration
  def change
    create_table :work_orders do |t|

    	t.decimal :total_amount, :precision => 8, :scale => 2
    	t.string :payment_type
      t.string :status
      t.string :order_number

    	t.string :first_name
    	t.string :last_name
    	t.string :email_address
    	t.string :phone_number
    	t.string :address
    	t.string :city
    	t.string :state
    	t.string :zip
    	
      t.timestamps
    end
  end
end
