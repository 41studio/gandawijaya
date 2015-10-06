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
#  status     :boolean          default(FALSE)
#

class PremiumAccount < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user
  delegate   :id, :username, :image, to: :shop, allow_nil: true, prefix: true

  scope :with_url, -> (url) { where(url: url) }
end
