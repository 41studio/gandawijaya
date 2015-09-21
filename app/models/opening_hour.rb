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

class OpeningHour < ActiveRecord::Base
  enum day_work:   [ "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu" ]
  belongs_to :shop
end
