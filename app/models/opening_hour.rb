class OpeningHour < ActiveRecord::Base
  enum day_work: [:sunday, :monday, :friday]
  belongs_to :shop

end
