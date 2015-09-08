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
      f.input :status, :as => :select, :collection => ["under_review", "on_progress", "approved"]
      f.actions
   end
 end

  show do
    attributes_table do
      row :name
      row :image do
        image_tag shop.image.url
      end
    end
    active_admin_comments
  end
end
