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

class Review < ActiveRecord::Base
  belongs_to :reviewable, polymorphic: true
  belongs_to :user

  validates :content, :rate_point, presence: true
end
