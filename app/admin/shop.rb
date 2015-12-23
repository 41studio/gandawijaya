ActiveAdmin.register Shop do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :name, :image, :description, :status, premium_account_attributes: [:id, :url, :user_id, :shop_id, :status, :_destroy]
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

      h4 "premium account settings", id: "premium-h4"
      f.inputs "", for: [:premium_account, f.object.premium_account || shop.build_premium_account] do |form|
          form.input :status, label: "premium shop"
          form.input :url
          form.input :shop_id, value: shop.user.id, as: :hidden
          form.input :shop_id, value: shop.id, as: :hidden
          # button "save", onclick: "$(this.form).submit();", id: "save-nested-admin"
      end
      f.actions
   end
    # f.inputs 'premium_account' do
    #   f.has_one :premium_account, heading: 'Themes', allow_destroy: true, new_record: true do |a|
    #     a.input :title
    #     a.input :status, as: :boolean, checked_value: true, unchecked_value: false, label: "premium shop :"
    #     a.input :url
    #     a.hidden_field :shop_id, value: shop.id
    #     a.hidden_field :user_id, value: shop.user.id
    #   end
    # end
 end

  show do
    attributes_table do
      row :name
      row :image do
        image_tag shop.image.url
      end
      row :status, :as => :select, :collection => ["under_review", "on_progress", "approved", "rejected"]
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
        link_to 'on_progress', on_progress_path(id: shop.id), method: :post
      else
        link_to 'Approve', approve_path(id: shop.id), method: :post

      end
    end

   action_item only: :show do |resource|
    if shop.status.eql? "under_review"
      link_to 'Approve', approve_path(id: shop.id), method: :post
    else
      link_to 'On Progress', on_progress_path(id: shop.id), method: :post
    end
   end
end
