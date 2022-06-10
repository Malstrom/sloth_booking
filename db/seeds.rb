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

Slot.destroy_all
Gametable.destroy_all
Club.destroy_all

starts = "00:00".to_time # 2022-06-02 23:00:00 +0300
ends = "23:00".to_time

@club = Club.create name: "Sokol", starts_at: "05:00", ends_at: "07:00"

@hours = (starts.to_i..ends.to_i).step(30.minutes).map do |hour|
  time = Time.at(hour)
end

gametables = Array.new

10.times do |index|
  gametables << Gametable.create(club: @club, description: "Table 1", active: 1, display_description: 1)
end

gametables.each do |gametable|

  print gametable.id
  @hours.each do |hour|
    local_hour = hour
    case hour.strftime("%H").to_i
    when 0..12
      Slot.create gametable: gametable, time: local_hour, price: 400
    when 13..16
      Slot.create gametable: gametable, time: local_hour, price: 500
    when 17..24
      Slot.create gametable: gametable, time: local_hour, price: 600
    else
      Slot.create gametable: gametable, time: local_hour, price: 100
    end
  end
end

#
# slots = Slot.all
# slots.each(&:dump_fixture)
