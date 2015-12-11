# == Schema Information
#
# Table name: shops
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  image          :string
#  description    :text
#  slug           :string
#  user_id        :integer
#  address        :string
#  status         :integer
#  telephone      :string
#  mobile_phones  :string
#  business_name  :string
#  business_email :string
#  categories     :string
#  cover_image    :string
#

class Shop < ActiveRecord::Base
  extend FriendlyId
  acts_as_votable
  is_impressionable
  # searchkick
  # searchkick settings: {number_of_shards: 5}
  # searchkick callbacks: :async
  searchkick word_start: [:name], callbacks: :async

  friendly_id    :name_and_id, use: [:slugged, :finders]
  mount_uploader :image, GalleryUploader
  mount_uploader :cover_image, GalleryUploader
  enum status: [:under_review, :on_progress, :approved]

  with_options dependent: :destroy do
    has_many :scategory_shops
    has_many :reviews, as: :reviewable
    has_many :products
    has_one  :premium_account
    has_many :opening_hours
    has_many :offer_rooms
  end
  has_many   :scategories, through: :scategory_shops
  belongs_to :user

  delegate :username, :id, to: :user, allow_nil: true, prefix: true
  delegate :url, :status, to: :premium_account, prefix: true

  accepts_nested_attributes_for :premium_account, allow_destroy: true
  accepts_nested_attributes_for :opening_hours, allow_destroy: true
  accepts_nested_attributes_for :scategory_shops, allow_destroy: true

  after_create :send_mail_new_shop
  # after_save :reindex_data

  validates :name,  presence: true, format: { with: /\A[a-zA-Z0-9 ]+\Z/ },
                    length: {  within: 2..40,
                               too_short: 'too short name',
                               too_long: 'too long name' }
  validates :address, presence: true
  validates :telephone, presence: true, numericality: true
  validates :mobile_phones, presence: true, numericality: true

  SHOP_DAY_WORK  = [ "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu" ]
  SHOP_WORK_HOUR = ["Closed", "1:00", "2:00", "3:00", "4:00", "5:00", "6:00", "7:00", "8:00",
                    "9:00",   "10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00",
                    "18:00",  "19:00","20:00","21:00","22:00", "23:00"]
  def send_mail_new_shop
    ShopMailer.shop_created(self.user).deliver_now
  end

  def name_and_id
    "#{name}  #{id}#{Time.now.to_s(:number)}"
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def self.search_shop(text)
    # search(text, include: [:premium_account], fields: [{"name^2" => :word_start}], order: {name: :desc})
    # search(text, fields: [{"name^2" => :word_start}])
    search text, fields: [{"name^10" => :word_start}], boost_where: {premium: true}
  end

  def search_data
    {
      name: name,
      premium: premium_account.present?
    }
  end

  private
    def reindex_data
      reindex
    end

end
