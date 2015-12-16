# == Schema Information
#
# Table name: offers
#
#  id              :integer          not null, primary key
#  content         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  offer_room_id   :integer
#  read_by_offerer :boolean          default(FALSE)
#  read_by_owner   :boolean          default(FALSE)
#

class Offer < ActiveRecord::Base
  belongs_to :offer_room
  belongs_to :user
  delegate :username, :id, :email, :image, :handphone, :first_name, :last_name, to: :user, allow_nil: true, prefix: true

  after_create :send_notif

  def send_notif
    OfferNotifier.received(self).deliver_later
  end
end
