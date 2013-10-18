ActiveAdmin.register Sale do

		sidebar :cart, :partial => 'admin/sales/added_item'
		sidebar :new_customer, :partial => "admin/sales/create_new_customer"
		sidebar :new_item, :partial => 'admin/sales/custom_item'
		sidebar :inventory_items, :partial => 'admin/sales/inventory'
	
		config.filters = false

	index do
		column :id do |sale|
	  		link_to sale.id, admin_sale_path(sale)
	  	end
	  	column :customer_id do |sale|
	  		unless sale.customer_id.blank?
	  			"#{Customer.find(sale.customer_id).last_name},#{Customer.find(sale.customer_id).first_name}"
	  		end
	  	end
	  	column :total_amount do |sale|
	  		number_to_currency sale.total_amount
	  	end
	  	column :payment_type
	  	column :created_at
	  	default_actions
	end

	collection_action :add_item do
		# sale = Sale.find(params[:id])
		(session[:products] ||= []) << params[:product_id]
	  respond_to do |format|
        # format.html 
        format.js 
      end
	end

	collection_action :add_custom_item do

		item = Item.new(:name => params[:item][:name].capitalize, :price => params[:item][:price].to_f)
		item.custom_item = true
		item.stock_amount = 1
		item.save

		(session[:products] ||= []) << item.id

		respond_to do |format|
      format.html	{ redirect_to :back }
      # format.js 
    end
	end

	collection_action :remove_product do
		session[:products].delete_if {|x| x == params[:delete_id]}
		respond_to do |format|
        # format.html 
        format.js 
      end
	end

	collection_action :remove_all_product  do

		session.delete(:products)
		respond_to do |format|
	        # format.html 
	        format.js 
	      end
	end

	collection_action :create_sale_with_items do

		@sale = Sale.new()
		total_amount = 0.00
		@sale.save
		unless session[:products].blank? 
			for item in session[:products].group_by {|d| d }
				current_item = Item.find(item[0])
				line_item = LineItem.new(:item_id => current_item.id, :sale_id => @sale.id, :quantity => item[1].count)
				line_item.save
				total_amount += (current_item.price * item[1].count)
				current_item.stock_amount -= item[1].count
				current_item.save
			end
		end
		@sale.total_amount = (total_amount * 1.0825)
		@sale.save

		session.delete(:products)
		redirect_to :contoroller => 'admin/sales', :action => 'show', :id => @sale.id


	end

	collection_action :add_new_customer_to_sale do
		customer = Customer.new(:first_name => params[:customer][:first_name], :last_name => params[:customer][:last_name], :email_address => params[:customer][:email_address], :phone_number => params[:customer][:phone_number] )
		customer.save

		respond_to do |format|
			format.html	{ redirect_to :back }
		end

	end

	collection_action :add_item do
		# sale = Sale.find(params[:id])
		(session[:products] ||= []) << params[:product_id]
	  respond_to do |format|
        # format.html 
        format.js 
      end
	end

	show do
    # renders app/views/admin/pages/_some_partial.html.erb
    render "form"
  end

  form :partial => "form"  
end
