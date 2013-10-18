ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
          div :class => "button_action" do
            div do
              link_to "Create Sales and Work Orders", "/admin/sales/new"
            end
          end
      end
    end
    
    columns do
      column do
        panel "Sales" do
          ul do
            for sale in Sale.find(:all)
              li link_to(sale.id, admin_sale_path(sale))
            end
          end
        end
      end

      column do
        panel "Work Orders" do
          para "List out work open orders"
        end
      end
    end

  end
end
