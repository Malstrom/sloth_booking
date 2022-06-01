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
Timecell.destroy_all
Gametable.destroy_all
Club.destroy_all

# sample_prices = [300,400,500,600]
@club = Club.create name: "Sokol"

starts = DateTime.now.beginning_of_day + 7.hours
ends = DateTime.now.beginning_of_day + 23.hours

# DateTime.parse(hour)

@hours = (starts.to_i..ends.to_i).step(1.hour).map do |hour|
  DateTime.parse(Time.at(hour).strftime("%H:%M"))
end

gametables = Array.new

20.times do |index|
  p index
  gametables << Gametable.create(club: @club, description: "Table 1", active: 1, display_description: 1)
end

gametables.each do |gametable|

  print gametable.id
  @hours.each do |hour|
    case hour.strftime("%H").to_i
    when 0..12
      Timecell.create gametable: gametable, time: hour, price: 400, kind: 0
    when 13..16
      Timecell.create gametable: gametable, time: hour, price: 500, kind: 0
    when 17..24
      Timecell.create gametable: gametable, time: hour, price: 600, kind: 0
    else
      Timecell.create gametable: gametable, time: hour, price: 100, kind: 0
    end
    p hour
  end
end