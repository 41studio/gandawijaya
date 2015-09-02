# == Schema Information
#
# Table name: shops
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#  description :text
#

class Shop < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  ratyrate_rateable "review"
  mount_uploader :image, GalleryUploader

  has_many :products, dependent: :destroy
  belongs_to :user
end
