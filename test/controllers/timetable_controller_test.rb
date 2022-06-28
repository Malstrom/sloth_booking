# frozen_string_literal: true

require 'test_helper'

class TimetableControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get timetable_index_path
    assert_response :success
  end

  test 'should get index where slots is not generated' do
    get timetable_index_path(selected_day: Date.today + 1.month)
    assert_response :success
  end
end
