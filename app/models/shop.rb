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

require 'elasticsearch/model'

class Shop < ActiveRecord::Base
  enum status: [:under_review, :on_progress, :approved]
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  mount_uploader :image, GalleryUploader
  belongs_to :user
  searchkick word_start: [:name]

  acts_as_votable

  has_many :products, dependent: :destroy


  def self.search_kick(query)
    search query, fields: [{name: :word_start}]
  end  
end
