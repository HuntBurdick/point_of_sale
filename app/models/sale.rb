class Sale < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :sale_number, :total_amount, :payment_type, :first_name, :last_name, :email_address, :phone_number, :address, :city, :state, :zip, :customer_id, :work_order, :work_order_paid, :work_order_called, :sale_completed, :comments, :amount_paid, :dropped_off, :promised_by, :special_order, :special_order_paid, :sale_refunded

  has_many :line_items
  belongs_to :customer
end
