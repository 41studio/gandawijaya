# == Schema Information
#
# Table name: galleries
#
#  id         :integer          not null, primary key
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :integer
#

class Gallery < ActiveRecord::Base
  mount_uploader :image, GalleryUploader

  belongs_to :product
end
