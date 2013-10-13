ActiveAdmin.register WorkOrder do
	index do
    
    default_actions
  end

  show do
    # renders app/views/admin/pages/_some_partial.html.erb
    render "form"
  end

  form :partial => "form"
end
