class Room < ApplicationRecord
  validates :name, {presence: true}
  validates :introduction, {presence: true}
  validates :price, {presence: true}
  validates :address, {presence: true}
  validates :user_id, {presence: true}

  belongs_to :user
  has_many :reservations
end
