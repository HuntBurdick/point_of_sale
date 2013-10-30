class Sale < ActiveRecord::Base
  # attr_accessible :title, :body


  attr_accessible :quick_sale, :price, :line_items_attributes, :work_items_attributes, :custom_items_attributes, :sale_number, :total_amount, :payment_type, :first_name, :last_name, :email_address, :phone_number, :address, :city, :state, :zip, :customer_id, :work_order, :work_order_paid, :work_order_called, :sale_completed, :comments, :amount_paid, :dropped_off, :promised_by, :special_order, :special_order_paid, :sale_refunded, :sale, :item_1, :item_1_description, :item_2, :item_2_description, :item_3, :item_3_description, :dropped_off_date, :promised_by_date, :paid
  
  belongs_to :customer
  has_many :line_items
  has_many :work_items
  has_many :custom_items

  accepts_nested_attributes_for :line_items, :allow_destroy => true
  accepts_nested_attributes_for :work_items, :allow_destroy => true
  accepts_nested_attributes_for :custom_items, :allow_destroy => true
  accepts_nested_attributes_for :customer

end
