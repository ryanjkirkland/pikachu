class Room < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accomodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true
end
