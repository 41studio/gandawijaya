# == Schema Information
#
# Table name: offer_rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  product_id :integer
#  shop_id    :integer
#

require 'test_helper'

class OfferRoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
