ActiveAdmin.register Sale do
	index do
		column :sale_number
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
		puts session[:products]
	  respond_to do |format|
        # format.html 
        format.js 
      end
	end

	collection_action :remove_product do

	end

	collection_action :remove_all_product  do

		session.delete(:products)
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
