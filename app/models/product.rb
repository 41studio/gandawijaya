# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  price       :decimal(8, 2)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  shop_id     :integer
#

class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  has_many  :galleries, dependent: :destroy
  has_many  :reviews, as: :reviewable
  belongs_to :shop
  belongs_to :user
<<<<<<< HEAD
=======

>>>>>>> ea7e43efc95cbdd9dcb5931289b42d8e42278e97
  accepts_nested_attributes_for :galleries, allow_destroy: true
end
