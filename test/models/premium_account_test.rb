# == Schema Information
#
# Table name: premium_accounts
#
#  id         :integer          not null, primary key
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  shop_id    :integer
#

require 'test_helper'

class PremiumAccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
