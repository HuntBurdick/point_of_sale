class CustomItem < ActiveRecord::Base
  attr_accessible :name, :description, :quantity, :sale_id, :price, :total_price

  belongs_to :sale
end
