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
  scope :order_by_day, -> { order("day_work= 6, day_work= 5, day_work= 4, day_work= 3,
                                               day_work= 2, day_work= 1, day_work= 0 "); }
  scope :not_contain_nil_hour, -> { where('start_work != ? ',  "") }
  belongs_to :shop
end
