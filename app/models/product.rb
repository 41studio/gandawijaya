class Product < ActiveRecord::Base
  has_many  :galleries, dependent: :destroy
  belongs_to :shop

  accepts_nested_attributes_for :galleries, allow_destroy: true
end
