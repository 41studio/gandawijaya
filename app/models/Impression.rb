class Impression < ActiveRecord::Base
  scope :today, -> { where("created_at >= ? AND created_at < ?", Time.now.beginning_of_day, Time.now.end_of_day) }
  scope :group_by_hour, -> { group_by_hour_of_day(:created_at, format: "%l %P").count }
end