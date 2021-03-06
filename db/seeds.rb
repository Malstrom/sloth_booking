# frozen_string_literal: true

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

require 'faker'

Slot.destroy_all
Gametable.destroy_all
Club.destroy_all
User.destroy_all

starts = '00:00'.to_time.yesterday # 2022-06-02 23:00:00 +0300
ends = '23:00'.to_time + 2.weeks
@hours = (starts.to_i..ends.to_i).step(30.minutes).map { |hour| Time.zone.at(hour) }

clubs = []

clubs << Club.create(name: Faker::Company.unique.name, starts_at: '05:00', ends_at: '07:00')

clubs.each do |club|
  Rails.logger.debug club.name
  gametables = []

  10.times do
    gametable = Gametable.create(club: club, description: 'Table 1', active: 1, display_description: 1)
    @hours.each do |hour|
      Slot.create gametable: gametable, time: hour, price: 500
    end
  end

  gametables.each do |gametable|
    @hours.each do |hour|
      Slot.create gametable: gametable, time: hour, price: 500
    end
  end
end
