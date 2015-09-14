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

  scope :with_url, -> (url) { select(:shop_id).where(url: url).first }
  belongs_to :shop
  belongs_to :user
end
