ActiveAdmin.register Sale do
	controller do 
		
	end

	collection_action :add_item do
		# sale = Sale.find(params[:id])
		puts '9999988888889989898989898989898989898989898'
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
