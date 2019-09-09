class Restaurant < ApplicationRecord
  validates_presence_of :name, :latitude, :longitude
  has_many :items
end