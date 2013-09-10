class LineItem < ActiveRecord::Base
  attr_accessible :item_id, :sale_id, :quantity
end
