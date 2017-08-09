class Team < ApplicationRecord
  validates :name, length: { minimum: 2, maximum: 24 }
end
