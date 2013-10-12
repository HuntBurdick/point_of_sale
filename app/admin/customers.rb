ActiveAdmin.register Customer do
  
  collection_action :create_customer_association do
		
  	if params[:work_order_id]
  		customer = Customer.new(:item_id => current_item.id, :sale_id => @sale.id, :quantity => item[1].count)
  	end

  	if params[:sale_id]
  		customer = Customer.new(:item_id => current_item.id, :sale_id => @sale.id, :quantity => item[1].count)
  	end
  	
		customer.save

	  respond_to do |format|
      # format.html 
      format.js 
    end
	end



end
