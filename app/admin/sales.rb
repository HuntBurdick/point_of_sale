ActiveAdmin.register Sale do
	
	# sidebar :create_new_customer, :partial => 'admin/sales/create_new_customer'

	filter :customer, :collection => Customer.order('last_name ASC').all.collect {|p| [ "#{p.last_name}, #{p.first_name}", p.id ] }
	filter :payment_type, :as => :select, :collection => ['Credit Card', 'Cash', 'Check']
	filter :paid
	filter :sale_refunded
	filter :work_order
	filter :work_order_called
	filter :dropped_off_date
	filter :promised_by_date
	filter :created_at
	filter :updated_at

	controller do
	  def apply_pagination(chain)
      chain = super unless formats.include?(:json) || formats.include?(:csv)
      chain
	  end

	  def scoped_collection
      resource_class.includes(:customer) # prevents N+1 queries to your database
    end
	end


	index do
		column :id do |sale|
  		link_to sale.id, admin_sale_path(sale)
  	end

  	# column :customer_id, sortable: 'customer_id' do |sale|
  	# 	unless sale.customer_id.blank?
  	# 		"#{Customer.find(sale.customer_id).last_name},#{Customer.find(sale.customer_id).first_name}"
  	# 	end
  	# end

  	column :customer, sortable: 'customers.last_name' do |sale|
  		unless sale.customer_id.blank?
  			customer = Customer.find(sale.customer_id)
  			"#{customer.last_name}, #{customer.first_name}"
  		end
  	end

  	column :total_amount do |sale|
  		unless sale.total_amount.blank?
  			number_to_currency(sale.total_amount * 1.0825)
  		end
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


	collection_action :start_sale_with_cart_products  do

		unless session[:products].blank?
			@new_sale = Sale.create()
	
			for item in session[:products].group_by {|d| d }
				current_item = Item.find(item[0])
				line_item = LineItem.new(:item_id => current_item.id, :sale_id => @new_sale.id, :quantity => item[1].count)
				line_item.save
			end
			@new_sale.save
		end

		session.delete(:products)
		redirect_to :controller => 'sales', :action => 'edit', :id => @new_sale.id
	end



	collection_action :print_view  do

		@sale = Sale.find(params[:sale_id])

		render :layout => 'print_sale'

	end


	member_action :create, :method => :post do
		@sale = Sale.new(params[:sale])
		total_amount = params[:sale][:total_amount]

		unless @sale.total_amount.blank?
			@sale.total_amount = total_amount.to_f
			@sale.tax_amount = (total_amount.to_f * 0.0825)
		end

		unless params[:sale][:dropped_off_date].blank?
			@sale.dropped_off_date = params[:sale][:dropped_off_date].to_datetime.to_formatted_s(:db)
		end

		unless params[:sale][:promised_by_date]
			@sale.promised_by_date = params[:sale][:promised_by_date].to_datetime.to_formatted_s(:db) 
		end


		if @sale.create_new_customer == true
			new_customer = Customer.new()

			new_customer.first_name = @sale.first_name
			new_customer.last_name = @sale.last_name
			new_customer.email_address = @sale.email_address
			new_customer.phone_number = @sale.phone_number
			new_customer.address = @sale.address
			new_customer.city = @sale.city
			new_customer.state = @sale.state
			new_customer.zip = @sale.zip
			new_customer.bike_customer = @sale.bike_customer
			new_customer.public_service = @sale.public_service

			new_customer.save

			@sale.customer_id = new_customer.id

			@sale.create_new_customer = false

			@sale.first_name = ''
			@sale.last_name = ''
			@sale.email_address = ''
			@sale.phone_number =  ''
			@sale.address = ''
			@sale.city = ''
			@sale.state = ''
			@sale.zip = ''
			@sale.bike_customer = ''
			@sale.public_service = ''

		end


		@sale.save
		
		for line_item in @sale.line_items
			unless line_item.item_id.blank?
				@item = Item.find(line_item.item_id)
				@item.stock_amount -= line_item.quantity
				@item.save
			end
		end

		redirect_to :controller => 'admin/sales', :action => 'show', :id => @sale.id, :notice => "Sale was Created"
	end

	member_action :update, :method => :post do
		@sale = Sale.find(params[:id])
		@sale.update_attributes(params[:sale])

		total_amount = params[:sale][:total_amount]

		unless total_amount.blank?
			@sale.total_amount = total_amount.to_f
			@sale.tax_amount = (total_amount.to_f * 0.0825)
		end

		unless params[:sale][:dropped_off_date].blank?
			@sale.dropped_off_date = params[:sale][:dropped_off_date].to_datetime.to_formatted_s(:db)
		end

		unless params[:sale][:promised_by_date]
			@sale.promised_by_date = params[:sale][:promised_by_date].to_datetime.to_formatted_s(:db) 
		end

		if @sale.create_new_customer == true
			new_customer = Customer.new()

			new_customer.first_name = @sale.first_name
			new_customer.last_name = @sale.last_name
			new_customer.email_address = @sale.email_address
			new_customer.phone_number = @sale.phone_number
			new_customer.address = @sale.address
			new_customer.city = @sale.city
			new_customer.state = @sale.state
			new_customer.zip = @sale.zip
			new_customer.bike_customer = @sale.bike_customer
			new_customer.public_service = @sale.public_service

			new_customer.save

			@sale.customer_id = new_customer.id

			@sale.create_new_customer = false

			@sale.first_name = ''
			@sale.last_name = ''
			@sale.email_address = ''
			@sale.phone_number =  ''
			@sale.address = ''
			@sale.city = ''
			@sale.state = ''
			@sale.zip = ''
			@sale.bike_customer = ''
			@sale.public_service = ''

		end

		@sale.save

		redirect_to :controller => 'admin/sales', :action => 'show', :id => @sale.id, :notice => "Sale was Edited"
	end


	

	show do
		render :partial => 'sale_view'
	end
  
	form do |f|

		f.inputs "Sale Types" do
			f.input :quick_sale
			f.input :special_order 
			f.input :work_order
			f.input :layaway
		end 

		f.inputs "Work Order Items Dropped Off (bicycles, wheels, parts for service)", :class => 'work_order_items inputs hide_for_quick_sale' do 
		  f.has_many :work_items, :allow_destroy => true, :heading => '', :new_record => true do |cf|
		   	cf.input :name
		   	cf.input :description
		  end
		  # f.input :dropped_off_date 
		  # f.input :promised_by_date

			f.input :dropped_off_date, :as => :string, :input_html => {:class => "hasDatetimePicker"}
			f.input :promised_by_date, :as => :string, :input_html => {:class => "hasDatetimePicker"} 

			f.input :pending_parts, :label => 'Work order is pending parts'
		  f.input :work_order_done, :label => 'Work order is completed'
		  f.input :work_order_called, :label => 'Customer Has Been Called Upon Completion'
		end

		f.inputs "Line Items from Inventory" do 
		  f.has_many :line_items, :allow_destroy => true, :heading => '', :new_record => true do |cf|
		    cf.input :item_id, :as => :select, :collection => Item.find(:all, :order => 'name').collect {|p| [ "#{p.name}, $#{p.price}", p.id ]} 
		   	cf.input :quantity, :input_html => { :class => "item_quantity" }
		   	cf.input :price, :input_html => { :class => "item_price" }
		   	cf.input :total_price, :input_html => { :class => "item_total_price" }

		  end 
		end 

		f.inputs "Custom Line Items" do 
		  f.has_many :custom_items, :allow_destroy => true, :heading => '', :new_record => true do |cf|
		    cf.input :name
		    cf.input :description
		   	cf.input :quantity, :input_html => { :class => "item_quantity" }
		   	cf.input :price, :input_html => { :class => "item_price" }
		   	cf.input :total_price, :input_html => { :class => "item_total_price" }

		  end 
		end 


		f.inputs "Choose Customer", :class => 'inputs hide_for_quick_sale' do
			f.input :customer_id, :as => :select, :collection => Customer.find(:all, :order => 'last_name DESC').collect {|p| [ "#{p.last_name}, #{p.first_name}", p.id ]}
			f.input :create_new_customer
		end

		f.inputs "Create and Add New Customer", :class => ' inputs new_customer_fields' do
			f.input :first_name
			f.input :last_name
			f.input :email_address
			f.input :phone_number
			f.input :address
			f.input :zip
			f.input :bike_customer
			f.input :public_service
		end

		f.inputs "Initial Comments", :class => 'inputs hide_for_quick_sale' do
			f.input :comments
		end
		f.inputs "Payment Method" do
			f.input :payment_type, :as => :select, :collection => ['Credit Card', 'Cash', 'Check']
		end
		f.inputs "Payment Details", :class => 'inputs payment_details' do
			f.input :total_amount, :label => "Amount", :hint => "Total + Tax :"
			f.input :amount_paid
			f.input :paid
		end

		f.actions
	end 
end
