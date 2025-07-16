class FlightsController < ApplicationController
  def index
    @airports = Airport.all.order(:code)
    @passenger_options = (1..4).to_a
    @dates = Flight.distinct.order(:start_datetime).pluck(:start_datetime).map { |dt| dt.to_date }.uniq

    if params[:departure_airport_id].present? && params[:arrival_airport_id].present? && params[:date].present?
      @flights = Flight.where(
        departure_airport_id: params[:departure_airport_id],
        arrival_airport_id: params[:arrival_airport_id],
        start_datetime: params[:date].to_date.all_day
      )
      @num_passengers = params[:num_passengers].to_i
    else
      @flights = []
    end
  end
end
