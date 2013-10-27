ActiveAdmin.register Item do

  # belongs_to :sale

  menu :label => "Items"

  filter :sku
  filter :name
  filter :description 

  sidebar :cart, :partial => 'admin/sales/added_item'

  controller do
    def apply_pagination(chain)
        chain = super unless formats.include?(:json) || formats.include?(:csv)
        chain
    end
  end

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

  	column "Add Item To Current Cart" do |item|
      link_to 'Add To Cart', url_for(:controller => 'sales', :action => 'add_item', :product_id => item.id), :format => :js, :remote => true
    end
  end

  show do
    # renders app/views/admin/pages/_some_partial.html.erb
    render "form"
  end

  form :partial => "form"
end
