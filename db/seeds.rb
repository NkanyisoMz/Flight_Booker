# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Airport.destroy_all
Flight.destroy_all

airports = Airport.create([
  { code: "SFO" },
  { code: "NYC" },
  { code: "LAX" },
  { code: "ORD" }
])

dates = [ Date.today, Date.today + 1, Date.today + 2 ]
airports.combination(2).each do |departure, arrival|
  dates.each do |date|
    Flight.create!(
      departure_airport: departure,
      arrival_airport: arrival,
      start_datetime: date.to_time + rand(0..23).hours + rand(0..59).minutes,
      duration: rand(120..360)
    )
  end
end

puts "Seeded #{Airport.count} airports and #{Flight.count} flights."
