ActiveAdmin.register AdminUser do  

  menu :priority => 8, :label => "Employees"

  index do                            
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
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
