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
		session[:products].delete_if {|x| x == params[:delete_id]}
		puts 'firedfiredfiredfiredfiredfiredfiredfiredfiredfiredfiredfiredfiredfiredfired'
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

	collection_action :current_cart_items  do
		items = session[:products]

		count = Hash.new(0)

		items.each do |v|
			count[v] += 1
		end

		count.each do |k, v|
			puts "#{k} appears #{v} times"
		end

	end

	show do
    # renders app/views/admin/pages/_some_partial.html.erb
    render "form"
  end

  form :partial => "form"  
end
