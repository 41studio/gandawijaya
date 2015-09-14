# == Schema Information
#
# Table name: impressions
#
#  id                  :integer          not null, primary key
#  impressionable_type :string
#  impressionable_id   :integer
#  user_id             :integer
#  controller_name     :string
#  action_name         :string
#  view_name           :string
#  request_hash        :string
#  ip_address          :string
#  session_hash        :string
#  message             :text
#  referrer            :text
#  created_at          :datetime
#  updated_at          :datetime
#

class Impression < ActiveRecord::Base
end
