# == Schema Information
#
# Table name: reviews
#
#  id              :integer          not null, primary key
#  content         :text
#  rate_point      :integer
#  reviewable_id   :integer
#  reviewable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
