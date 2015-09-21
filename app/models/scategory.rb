# == Schema Information
#
# Table name: scategories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Scategory < ActiveRecord::Base
  has_many :scategory_shops
  has_many :shops, through: :scategory_shops
end

