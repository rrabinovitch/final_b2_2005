require 'rails_helper'

RSpec.describe Flight do
  before :each do
    @airline = Airline.create(name: "Frontier")
    @flight = @airline.flights.create(number: 1727, date: "08/03/20", time: "12PM MT", departure_city: "Denver", arrival_city: "Reno")
    @passenger_1 = Passenger.create(name: "Bob", age: 32)
    @passenger_2 = Passenger.create(name: "Barry", age: 17)
    @passenger_3 = Passenger.create(name: "Billy", age: 28)
    FlightPassenger.create(flight_id: @flight.id, passenger_id: @passenger_1.id)
    FlightPassenger.create(flight_id: @flight.id, passenger_id: @passenger_2.id)
    FlightPassenger.create(flight_id: @flight.id, passenger_id: @passenger_3.id)
  end

  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many :flight_passengers}
    it {should have_many(:passengers).through(:flight_passengers)}
  end

  describe 'methods' do
    it "#num_minors" do
      expect(@flight.num_minors).to eq(1)
    end

    it "#num_adults" do
      expect(@flight.num_adults).to eq(2)
    end
  end
end
