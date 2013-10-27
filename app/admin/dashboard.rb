ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    
    columns do
      column do
        panel "Sales" do
          render :partial => 'dashboard/sales'
        end
      end

      column do
        panel "Work Orders" do
          render :partial => 'dashboard/work_orders'
        end
      end
    end

  end
end
