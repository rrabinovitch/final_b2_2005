class Passenger < ApplicationRecord
  has_many :flight_passengers
  has_many :passngers, through: :flight_passengers
end
