class Event < ApplicationRecord

  validates :name, {presence: true}
  validates :date, {presence: true}
  validates :place, {presence: true}
  validates :sender, {presence: true}
  validates :sender_status, {presence: true}

end
