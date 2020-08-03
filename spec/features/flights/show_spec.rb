require 'rails_helper'

RSpec.describe "When I visit a flight's show page," do
  before :each do
    @airline = Airline.create(name: "Frontier")
    @flight = @airline.flights.create(number: 1727, date: "08/03/20", time: "12PM MT", departure_city: "Denver", arrival_city: "Reno")
    @passenger_1 = Passenger.create(name: "Bob", age: 32)
    @passenger_2 = Passenger.create(name: "Barry", age: 17)
    @passenger_3 = Passenger.create(name: "Billy", age: 28)
    FlightPassenger.create(flight_id: @flight.id, passenger_id: @passenger_1.id)
    FlightPassenger.create(flight_id: @flight.id, passenger_id: @passenger_2.id)
    FlightPassenger.create(flight_id: @flight.id, passenger_id: @passenger_3.id)
    visit "/flights/#{@airline.id}"
  end

  it "I see all of that flight's information: number, date, time, departure city, and arrival city." do
    expect(page).to have_content(@flight.number})
    expect(page).to have_content("Date: #{@flight.date}")
    expect(page).to have_content("Time: #{@flight.time}")
    expect(page).to have_content("Departure city: #{@flight.departure_city}")
    expect(page).to have_content("Arrival city: #{@flight.arrival_city}")
  end

  it "I see the name of the airline this flight belongs to." do
    expect(page).to have_content(#{@airline.name})
  end

  it "I see the names of all passengers on this flight." do
    expect(page).to have_content(@passenger_1.name)
    expect(page).to have_content(@passenger_2.name)
    expect(page).to have_content(@passenger_3.name)
  end

  it "I see the number of minors and adults on the flight." do

  end
end
