# frozen_string_literal: true

require 'application_system_test_case'

class TimetablesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers # Rails >= 5

  setup do
    @user = users(:client)
    sign_in @user
    @today = Date.today

  end

  test 'visiting the index' do
    visit timetable_index_url
    assert_selector 'h4', text: @today.strftime('%A %d %b')

    # assert_text "TimeTable for"
  end

  # test "Navigate next/prev day" do
  #   visit timetable_index_url
  #
  #   next_day = @today + 1.day
  #   previous_day = @today - 1.day
  #
  #
  #   click_on next_day.strftime('%A')
  #   assert_selector "h4", text: next_day.strftime('%A %d %b')
  #
  #   sleep 5
  #   click_on previous_day.strftime('%A')
  #   sleep 5
  #   assert_selector "h4", text: previous_day.strftime('%A %d %b')
  # end

  test 'navigate prev/next week' do
    visit timetable_index_url

    prev_week_day = @today - 1.week
    next_week_day = @today + 1.week

    click_on 'prevWeek'
    assert_selector 'h4', text: prev_week_day.strftime('%A %d %b')

    click_on 'nextWeek'
    click_on 'nextWeek'
    assert_selector 'h4', text: next_week_day.strftime('%A %d %b')
  end

  #
  # test "set price for all tables in specific hour" do
  #   visit timetable_index_url
  #
  #   fill_in "free_price", with: 777
  #   next_week_day = @today + 1.week
  #
  #
  #   click_on next_week_day.strftime('%A')
  #   click_on "15:00"
  #
  #   tables = Gametable.all
  #   gametables.each do |table|
  #     table.slots.where(time: )
  #     assert_selector "table_", text: "777"
  #   end
end
