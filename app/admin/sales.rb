ActiveAdmin.register Sale do
	
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

	collection_action :print_view  do

		@sale = Sale.find(params[:sale_id])

		render :layout => 'print_sale'

	end

	member_action :create, :method => :post do
		@sale = Sale.new(params[:sale])
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
		@sale.tax_amount = (total_amount * 0.0825)
		@sale.save

		session.delete(:products)
		redirect_to :controller => 'admin/sales', :action => 'show', :id => @sale.id, :notice => "Sale was Created"
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
		redirect_to :controller => 'admin/sales', :action => 'show', :id => @sale.id


	end

	collection_action :add_new_customer_to_sale do
		customer = Customer.new(:first_name => params[:customer][:first_name], :last_name => params[:customer][:last_name], :email_address => params[:customer][:email_address], :phone_number => params[:customer][:phone_number] )
		customer.save

		respond_to do |format|
			format.html	{ redirect_to :back }
		end

	end

	

  
	form do |f| 
		f.inputs "Line Items" do 
		  f.has_many :line_items, :allow_destroy => true, :heading => '', :new_record => true do |cf|
		    cf.input :item_id, :as => :select, :collection => Item.find(:all, :order => 'name').collect {|p| [ p.name, p.id ]} 
		   	cf.input :quantity
		  end 
		end 

		f.inputs "Choose Customer" do
			f.input :customer_id, :as => :select, :collection => Customer.find(:all, :order => 'last_name').collect {|p| [ "#{p.last_name}, #{p.first_name}", p.id ]}
		end
			
		f.inputs "Type of Sale" do
				f.input :special_order 
				f.input :work_order
			end 

			f.inputs "Work Items", :class => 'work_order_items' do 
			  f.has_many :work_items, :allow_destroy => true, :heading => '', :new_record => true do |cf|
			   	cf.input :name
			   	cf.input :description
			  end
			  f.input :dropped_off_date 
			  f.input :promised_by_date
			  f.input :work_order_called, :label => 'Customer Has Been Called Upun Completion'
			end

			f.inputs "Initial Comments" do
				f.input :comments
			end
			f.inputs "Payment Method" do
				f.input :payment_type, :as => :select, :collection => ['Credit Card', 'Cash', 'Check']
			end
			f.inputs "Payment Details" do
				f.input :total_amount
				f.input :amount_paid
				f.input :paid
			end

			f.actions do
	      f.action :submit, :as => :button
	    end
	end 
end
