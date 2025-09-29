# app/mailers/passenger_mailer.rb
class PassengerMailer < ApplicationMailer
  def confirmation_email(passenger)
    @passenger = passenger
    @booking = passenger.booking
    @flight = @booking.flight
    mail(to: @passenger.email, subject: "Your Flight Booking Confirmation")
  end
end
