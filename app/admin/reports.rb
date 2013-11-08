ActiveAdmin.register_page "Reports" do
	# menu false

	page_action :sales_report do
		if params[:item][:paid] == '1'
			@sales = Sale.find(:all, :conditions => ["paid=? AND created_at BETWEEN ? AND ?", true, "#{params[:item][:start_date].to_datetime.to_formatted_s(:db)}", "#{params[:item][:end_date].to_datetime.to_formatted_s(:db)}"])
		elsif params[:item][:pending] == '1'
			@sales = Sale.find(:all, :conditions => ["paid=? AND created_at BETWEEN ? AND ?", false, "#{params[:item][:start_date].to_datetime.to_formatted_s(:db)}", "#{params[:item][:end_date].to_datetime.to_formatted_s(:db)}"])
		end

	end

  content do
  	h2 "Select Date Range"
 		form_for("item", :url => {:controller => "admin/reports", :action => "sales_report"}, :method => "get") do |f|
 			div :class => 'row' do
 				div :class => 'input' do
	   			f.label :start_date
					f.text_field :start_date, :as => :string, :class => "hasDatetimePicker"
				end
				div :class => 'input' do
					f.label :end_date
					f.text_field :end_date, :as => :string, :class => "hasDatetimePicker"
				end
			end
			h2 'Choose One'
			div :class => 'row options' do
				div :class => 'input option' do
					f.check_box :paid
					f.label :paid
				end
				div :class => 'input option' do
					f.check_box :pending
					f.label :pending
				end
			end
			f.submit 'Create Report'
  	end
  end
end