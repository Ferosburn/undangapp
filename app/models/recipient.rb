class Recipient < ApplicationRecord

  validates :name, {presence: true, uniqueness: true}
end
