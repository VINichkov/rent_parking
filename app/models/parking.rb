class Parking < ActiveRecord::Base
  has_many :patchphotos
  has_many :bookings
  belongs_to :user
end
