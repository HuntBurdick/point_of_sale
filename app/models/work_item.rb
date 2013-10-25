class WorkItem < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :description, :sale_id
  belongs_to :sale
end
