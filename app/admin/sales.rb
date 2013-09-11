ActiveAdmin.register Sale do
	index do
		column :id
	  	column :total_amount
	  	column :last_name
	  	column :created_at
	  	default_actions
	end


	controller do 
		
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
		@sale.save

		for item in session[:products].group_by {|d| d }
			current_item = Item.find(item[0])
			line_item = LineItem.new(:item_id => current_item.id, :sale_id => @sale.id, :quantity => item[1].count)
			line_item.save
		end
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
