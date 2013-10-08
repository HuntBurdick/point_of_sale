ActiveAdmin.register Sale do
	index do
		column :id do |sale|
	  		link_to sale.id, admin_sale_path(sale)
	  	end
	  	column :total_amount do |sale|
	  		number_to_currency sale.total_amount
	  	end
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

	collection_action :update_sale_with_items do

	end

	show do
    # renders app/views/admin/pages/_some_partial.html.erb
    render "form"
  end

  form :partial => "form"  
end
