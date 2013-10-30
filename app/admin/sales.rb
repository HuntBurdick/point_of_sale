ActiveAdmin.register Sale do
	
		# sidebar :create_new_customer, :partial => 'admin/sales/create_new_customer'

		filter :customer, :collection => Customer.all.collect {|p| [ "#{p.last_name}, #{p.first_name}", p.id ] }
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
	  end

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

		puts 'asdflkjsdflkjsdflkjsdflkjsdfksjfdklsdfjklj'

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
		@sale.total_amount = total_amount.to_f
		@sale.tax_amount = (total_amount.to_f * 0.0825)
		@sale.save
		
		for line_item in @sale.line_items
			@item = Item.find(line_item.item_id)
			@item.stock_amount -= line_item.quantity
			@item.save
		end

		redirect_to :controller => 'admin/sales', :action => 'show', :id => @sale.id, :notice => "Sale was Created"
	end

	member_action :update, :method => :post do
		@sale = Sale.find(params[:id])
		@sale.update_attributes(params[:sale])

		total_amount = params[:sale][:total_amount]
		@sale.total_amount = total_amount.to_f
		@sale.tax_amount = (total_amount.to_f * 0.0825)

		@sale.save

		redirect_to :controller => 'admin/sales', :action => 'show', :id => @sale.id, :notice => "Sale was Edited"
	end


	show do
		render :partial => 'sale_view'
	end
  
	form do |f|

		f.inputs "Sale Options" do
			f.input :quick_sale
			f.input :special_order 
			f.input :work_order
		end 

		f.inputs "Work Items", :class => 'work_order_items inputs hide_for_quick_sale' do 
		  f.has_many :work_items, :allow_destroy => true, :heading => '', :new_record => true do |cf|
		   	cf.input :name
		   	cf.input :description
		  end
		  f.input :dropped_off_date 
		  f.input :promised_by_date
		  f.input :work_order_called, :label => 'Customer Has Been Called Upun Completion'
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


		f.inputs "Choose Customer", :class => 'hide_for_quick_sale' do
			f.input :customer_id, :as => :select, :collection => Customer.find(:all, :order => 'last_name DESC').collect {|p| [ "#{p.last_name}, #{p.first_name}", p.id ]}
		end

		f.inputs "Initial Comments", :class => 'hide_for_quick_sale' do
			f.input :comments
		end
		f.inputs "Payment Method" do
			f.input :payment_type, :as => :select, :collection => ['Credit Card', 'Cash', 'Check']
		end
		f.inputs "Payment Details" do
			f.input :total_amount, :label => "Amount", :hint => "Total Amount w/ Tax :"
			f.input :amount_paid
			f.input :paid
		end

		f.actions
	end 
end
