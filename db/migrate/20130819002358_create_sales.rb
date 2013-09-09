class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|

    	t.decimal :total_amount, :precision => 8, :scale => 2
    	t.integer :payment_type_id

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
