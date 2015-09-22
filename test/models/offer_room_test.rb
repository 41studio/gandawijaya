# == Schema Information
#
# Table name: offer_rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :integer
#  shop_id    :integer
#  offerer    :string
#

require 'test_helper'

class OfferRoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
