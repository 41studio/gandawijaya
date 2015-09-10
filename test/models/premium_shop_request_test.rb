# == Schema Information
#
# Table name: premium_shop_requests
#
#  id         :integer          not null, primary key
#  approved   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  shop_id    :integer
#

require 'test_helper'

class PremiumShopRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
