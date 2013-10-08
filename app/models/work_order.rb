class WorkOrder < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items
end
