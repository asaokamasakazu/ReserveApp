class Reservation < ApplicationRecord
  validates :user_id, {presence: true}
  validates :room_id, {presence: true}
  validates :start_day, {presence: true}
  validates :finish_day, {presence: true}

  belongs_to :user
  belongs_to :room
end
