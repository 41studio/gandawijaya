# == Schema Information
#
# Table name: opening_hours
#
#  id         :integer          not null, primary key
#  day_work   :integer
#  start_work :string
#  end_work   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  shop_id    :integer
#

require 'test_helper'

class OpeningHourTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
