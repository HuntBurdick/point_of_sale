ActiveAdmin.register Item do

  # belongs_to :sale

  menu :label => "Items"

  index do
  	column :sku do |item|
      link_to item.sku, admin_item_path(item)
    end
    column :stock_amount
  	column :name do |item|
      link_to item.name, admin_item_path(item)
    end
  	column :price do |item|
      number_to_currency item.price
    end
  	column :description

  	column "Add Item" do |item|
      link_to 'Add', url_for(:controller => 'sales', :action => 'add_item', :product_id => item.id), :format => :js, :remote => true
    end

    h2 do
    	'Current Sale'
    end
    div :class => 'cart_items' do
    	render :partial => 'admin/sales/added_item'
    end
    div :class => 'create_sale' do
         link_to "Create Sale", url_for(:controller => 'sales', :action => 'create_sale_with_items')
    end
  end

  show do
    # renders app/views/admin/pages/_some_partial.html.erb
    render "form"
  end

  form :partial => "form"
end
