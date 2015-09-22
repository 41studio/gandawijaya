# == Schema Information
#
# Table name: offers
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Offer < ActiveRecord::Base
  belongs_to :offer_room
  belongs_to :user
  belongs_to :product
end