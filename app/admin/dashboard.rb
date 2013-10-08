ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Quicklinks" do
          div do
            "Create Sale"
          end
          div do
            "Create Work Order"
          end
        end
      end
    end
    
    columns do
      column do
        panel "Sales from Today" do
          ul do
            for sale in Sale.find(:all)
              li link_to(sale.order_number, admin_sale_path(sale))
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

    columns do
      column do
        panel "Recent History" do
          para "List out daily totals and links to graphs"
        end
      end

      column do
        panel "Pending Orders" do
          para "List out work pending / special orders"
        end
      end
    end

  end
end
