class OpeningHour < ActiveRecord::Base
  extend OrderAsSpecified
  enum day_work:   [ "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu" ]
  belongs_to :shop
end
