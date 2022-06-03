require "application_system_test_case"

class TimetablesTest < ApplicationSystemTestCase
  setup do
    @today = Date.today
  end

  test "visiting the index" do
    visit timetable_index_url
    assert_text "TimeTable for"
  end

  test "Navigate next/prev day" do
    visit timetable_index_url

    next_day = @today + 1.day
    previous_day = @today - 1.day

    click_on next_day.strftime('%A')
    assert_text "TimeTable for #{next_day.strftime('%A')}"

    click_on previous_day.strftime('%A')
    assert_text "TimeTable for #{previous_day.strftime('%A')}"
  end

  test "navigate prev/next week" do
    visit timetable_index_url

    prev_week_day = @today - 1.week
    next_week_day = @today + 1.week

    click_on "prevWeek"
    assert_text "TimeTable for #{prev_week_day.strftime('%A')}"

    click_on "nextWeek"
    assert_text "TimeTable for #{next_week_day.strftime('%A')}"
  end
end
