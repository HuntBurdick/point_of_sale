class LineItem < ActiveRecord::Base
  attr_accessible :item_id, :sale_id, :quantity, :price

  belongs_to :sale
  belongs_to :item
end
