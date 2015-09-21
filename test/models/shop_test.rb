# == Schema Information
#
# Table name: shops
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  image          :string
#  description    :text
#  slug           :string
#  user_id        :integer
#  address        :string
#  status         :integer
#  telephone      :string
#  mobile_phones  :string
#  business_name  :string
#  business_email :string
#  categories     :string
#  cover_image    :string
#

require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
