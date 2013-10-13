class Customer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email_address, :phone_number, :address, :city, :state, :zip, :bike_customer, :public_service
end
