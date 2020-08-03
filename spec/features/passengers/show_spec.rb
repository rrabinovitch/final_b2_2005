require 'rails_helper'

RSpec.describe "When I visit a passenger's show page," do
  before :each do
    @airline = Airline.create(name: "Frontier")
    @flight_1 = @airline.flights.create(number: 1727, date: "08/03/20", time: "12PM MT", departure_city: "Denver", arrival_city: "Reno")
    @flight_2 = @airline.flights.create(number: 2452, date: "11/23/19", time: "11AM MT", departure_city: "Salt Lake City", arrival_city: "Los Angeles")
    @flight_3 = @airline.flights.create(number: 5678, date: "01/15/20", time: "5PM MT", departure_city: "Denver", arrival_city: "New York City")
    @passenger = Passenger.create(name: "Bob", age: 32)
    FlightPassenger.create(flight_id: @flight_1.id, passenger_id: @passenger.id)
    FlightPassenger.create(flight_id: @flight_2.id, passenger_id: @passenger.id)
    visit "/passengers/#{@passenger.id}"
  end

  it "I see the passenger's name." do
    expect(page).to have_content(@passenger.name)
  end

  it "I see a section displaying the numbers of all this passenger's flights,
  each of which are links to the respective flight show page." do
    within('.flights') do
      expect(page).to have_link(@flight_1.number)
      expect(page).to have_link(@flight_2.number)
      click_on "#{@flight_1.number}"
    end
    expect(current_path).to eq("/flights/#{@flight_1.id}")
  end

  it "I see a form to assign the passenger to a flight,
  and when I fill in and submit the form with a flight number,
  I'm returned to the passenger's show page where I see the newly added flight number." do
    within('.flights') do
      expect(page).to_not have_link(@flight_3.number)
    end
    within('.add_flight') do
      fill_in :flight_number, with: @flight_3.number
      click_on "Submit"
    end
    expect(current_path).to eq("/passengers/#{@passenger.id}")
    within('.flights') do
      expect(page).to have_link(@flight_3.number)
    end
  end
end
