class Gallery < ActiveRecord::Base
  mount_uploader :image, GalleryUploader

  belongs_to :product
end
