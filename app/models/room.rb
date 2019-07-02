class Room < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accomodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true

  def cover_photo
  	if self.images.length > 0
  		self.images[0]
	else
		"blank.jpg"
	end
  end
end
