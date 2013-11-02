class AddCustomerFieldsToSales < ActiveRecord::Migration
  def change
  	add_column :sales, :first_name, :string
  	add_column :sales, :last_name, :string
  	add_column :sales, :email_address, :string
  	add_column :sales, :phone_number, :string
  	add_column :sales, :address, :string
  	add_column :sales, :city, :string
  	add_column :sales, :state, :string
  	add_column :sales, :zip, :string
  	add_column :sales, :bike_customer, :boolean
  	add_column :sales, :public_service, :boolean
  end
end
