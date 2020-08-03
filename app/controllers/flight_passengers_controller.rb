class FlightPassengersController < ApplicationController
  def create
    flight = Flight.find_by(number: params[:flight_number])
    FlightPassenger.create(flight_id: flight.id, passenger_id: params[:passenger_id])
    redirect_to "/passengers/#{params[:passenger_id]}"
  end
end
