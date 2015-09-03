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
  friendly_id :name_and_id, use: [:slugged, :finders]
  mount_uploader :image, GalleryUploader
  belongs_to :user

  has_many :reviews, as: :reviewable
  has_many :products, dependent: :destroy
  belongs_to :user

  def name_and_id
    "#{name}  #{id}#{created_at.strftime("%Y%m%d")}"
  end
end
