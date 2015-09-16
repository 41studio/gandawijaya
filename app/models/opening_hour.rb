class OpeningHour < ActiveRecord::Base
  enum day_work:   [ "Senin", "Selasa", "Rabu", "Kamis", "Jum'at", "Sabtu", "Minggu" ]


  belongs_to :shop

end
