ActiveAdmin.register Sale do
	index do
		column :id
	  	column :total_amount
	  	column :last_name
	  	column :created_at

	  	h2 do
	    	'Current Cart'
	    end
	    div :class => 'cart_items' do
	    	render :partial => 'admin/sales/added_item'
	    end
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

		for product in session[:products]
			line_item = LineItem.new(:item_id => product, :sale_id => @sale.id)
			line_item.save
		end
		session.delete(:products)
		redirect_to :contoroller => 'admin/sales', :action => 'show', :id => @sale.id

	end

	show do
    # renders app/views/admin/pages/_some_partial.html.erb
    render "form"
  end

  form :partial => "form"  
end
