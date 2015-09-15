ActiveAdmin.register Product do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :price, :description, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  form do |f|
    f.inputs 'Shops' do
      f.input :name
      f.input :price
      f.input :description
      f.input :status, :as => :select, :collection => ["under_review", "on_progress", "approved"] 
      f.actions
   end
 end

  show do
    attributes_table do
      row :name
      row :image do
        image_tag product.galleries.first.image.url
      end
    end
    active_admin_comments
  end

end
