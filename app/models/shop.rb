class Shop < ActiveRecord::Base
  mount_uploader :image, GalleryUploader
  has_many :products, dependent: :destroy
end
