ActiveAdmin.register Sale do
	show do
    # renders app/views/admin/pages/_some_partial.html.erb
    render "form"
  end

  form :partial => "form"  
end
