class BookingsController < ApplicationController
  def new
    puts "New Params: #{params.inspect}" # Debug
    unless params[:flight_id].present?
      redirect_to root_path, alert: "No flight selected."
      return
    end
    @flight = Flight.find(params[:flight_id])
    @num_passengers = params[:num_passengers].to_i
    @booking = Booking.new
    @num_passengers.times { @booking.passengers.build }
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Flight not found."
  end

  def create
    puts "Create Params: #{params.inspect}" # Debug
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to @booking, notice: "Booking created successfully."
    else
      # Set @flight from booking_params if possible
      @flight = Flight.find(booking_params[:flight_id]) if booking_params[:flight_id].present?
      @num_passengers = @booking.passengers.size
      render :new, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Invalid flight selected."
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [ :name, :email ])
  end
end
