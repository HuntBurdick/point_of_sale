class Sale < ActiveRecord::Base
  # attr_accessible :title, :body

  has_and_belongs_to_many :items
  attr_accessible :sale_number, :total_amount, :payment_type_id, :first_name, :last_name, :email_address, :phone_number, :address, :city, :state, :zip
end
