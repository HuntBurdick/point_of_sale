class Item < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :image_url_file_name, :image_url, :sku, :name, :description, :price, :stock_amount

  has_attached_file :image_url, :styles => { :large => "800x800>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end
