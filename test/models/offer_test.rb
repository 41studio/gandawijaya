# == Schema Information
#
# Table name: offers
#
#  id              :integer          not null, primary key
#  content         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  offer_room_id   :integer
#  read_by_offerer :boolean          default(FALSE)
#  read_by_owner   :boolean          default(FALSE)
#

require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
