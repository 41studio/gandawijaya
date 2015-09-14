ActiveAdmin.register Shop do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :name, :image, :description, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  # menu parent: "Shops"

  form do |f|
    f.inputs 'Shops' do
      f.input :name
      f.input :image
      f.input :description
      f.input :status, :as => :select, :collection => ["under_review", "rejected", "approved"]
      f.input :address
      f.input :telephone
      f.input :mobile_phones
      f.input :business_name
      f.input :business_email
      f.input :categories
      f.actions
   end
   panel "Premum Account settings" do
    render partial: "premium_account_form", locals: {shop: shop}
  end
 end

  show do 
    attributes_table do
      row :name
      row :image do
        image_tag shop.image.url
      end
      row :status, :as => :select, :collection => ["under_review", "rejected", "approved"]
      row :address
      row :telephone
      row :mobile_phones
      row :business_name
      row :business_email
      row :categories
    end
    panel "Premum Account settings" do
      render partial: "premium_account_form", locals: {shop: shop}
    end
    active_admin_comments

    
  end  
  
    action_item only: :show do |resource|
      if shop.status.eql? "under_review"
        link_to 'Reject', reject_path(id: shop.id), method: :delete 
      else
        link_to 'Approve', approve_path(id: shop.id), method: :post 
        
      end  
    end
    
   action_item only: :show do |resource|
    if shop.status.eql? "under_review"
      link_to 'Approve', approve_path(id: shop.id), method: :post
    else
      link_to 'Reject', reject_path(id: shop.id), method: :delete  
    end  
   end
end
