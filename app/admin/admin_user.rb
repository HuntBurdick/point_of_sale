ActiveAdmin.register AdminUser do  

  menu :priority => 8, :label => "Employees"
  
  filter :last_name
  filter :first_name
  filter :user_type

  index do                            
    column :last_name
    column :first_name
    column :user_type                              
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :user_type, :label => 'User Type', :as => :select, :collection => [["Owner", "owner"],["Manager", "manager"], ["Employee", "employee"]]              
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end                                 
end                                   
