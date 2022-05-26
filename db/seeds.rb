# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#
#

Price.destroy_all
Gametable.destroy_all
Club.destroy_all

sample_prices = [300,400,500,600]
@club = Club.create name: "Sokol"

starts = DateTime.now.beginning_of_day + 7.hours
ends = DateTime.now.beginning_of_day + 23.hours

@hours = (starts.to_i..ends.to_i).step(1.hour).map { |hour| Time.at(hour).strftime("%H:%M") }

gametables = Array.new
gametables << Gametable.create(club: @club, description: "Table 1", active: 1, display_description: 1)
gametables << Gametable.create(club: @club, description: "Table 2", active: 1, display_description: 1)
gametables << Gametable.create(club: @club, description: "Table 3", active: 1, display_description: 1)
gametables << Gametable.create(club: @club, description: "Table 4", active: 1, display_description: 1)
gametables << Gametable.create(club: @club, description: "Table 5", active: 1, display_description: 1)
gametables << Gametable.create(club: @club, description: "Table 6", active: 1, display_description: 1)
gametables << Gametable.create(club: @club, description: "Table 7", active: 1, display_description: 1)

gametables.each do |gametable|
  print gametable
  @hours.each do |hour|
    p hour
    Price.create gametable: gametable, hour: hour, value: sample_prices.sample
  end
end

Booking.create(user:User.first, price: Price.first, kind:1)

#@available_slots = (starts.to_i..ends.to_i).step(1.hour).map { |hour| Time.at(hour).utc.strftime("%H:%M") }

# club = Club.first
#
# club_gametables_id = club.gametables.pluck :id
#
# club = 2
# Price.joins(:gametable).where("gametables.club_id = 2")
#
#
#
# to_update = Price.where(id:club_gametables_id, :hour => starts...ends )
# # to_update = Price.where(gametable:25)
#
# to_update.each do |price|
#   price.update_attribute :value, 777
# end
#

# (DateTime.now.at_beginning_of_week.to_i..DateTime.now.at_end_of_week.to_i).step(1.day) do |day|
#   p DateTime.new(day)
# end
#
