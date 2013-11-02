class AddCreateCustomerToSales < ActiveRecord::Migration
  def change
  	add_column :sales, :create_new_customer, :boolean
  end
end
