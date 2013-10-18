ActiveAdmin.register Customer do
	filter :last_name
	filter :first_name
	filter :email_address
	filter :phone_number
  index do
    column :last_name
    column :first_name
    column :email_address
    column :phone_number
    column :bike_customer
    column :public_service
    default_actions
  end
end
