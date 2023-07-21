class Repository < ApplicationRecord
  validates :name, :owner, :stars, presence: true
  validates :name, uniqueness: { scope: :owner }
end
