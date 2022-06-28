# frozen_string_literal: true
require "test_helper"

class SlotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club = clubs(:sokol)
    @slot = slots(:tomorrow_slot)
    @slot_booked = slots(:tomorrow_slot_booked)
    @tomorrow = Date.tomorrow
    @yesterday = Date.yesterday
  end

  test 'should update slot' do
    patch slot_url(@slot), params: { slot: { price: '700' } }
    assert_equal(700, Slot.find(@slot.id).price)
  end

  test 'should not update slot' do
    patch slot_url(@slot), params: { slot: { price: '' } }
    assert_not_equal('', Slot.find(@slot.id).price)
  end

  test 'should update working time' do
    hours = (@tomorrow.at_beginning_of_day.to_i..@tomorrow.at_end_of_day.to_i).step(30.minutes).map do |hour|
      [(Time.at(hour).utc).strftime('%H:%M'), Time.at(hour).utc]
    end

    put set_working_time_slots_url(selected_day:@tomorrow), params: { starts_at: hours[20][1], ends_at: hours[30][1] }
    assert_equal('open', Slot.by_day(@tomorrow).first.state)
  end

  test 'should not update in past' do
    hours = (@yesterday.at_beginning_of_day.to_i..@yesterday.at_end_of_day.to_i).step(30.minutes).map do |hour|
      [(Time.at(hour).utc).strftime('%H:%M'), Time.at(hour).utc]
    end

    put set_working_time_slots_url(selected_day:@yesterday), params: { starts_at: hours[0][1], ends_at: hours[5][1] }
    assert_equal('open', Slot.by_day(@yesterday).first.state)
  end

  test 'should not update where there is booked slot' do
    hours = (@tomorrow.at_beginning_of_day.to_i..@tomorrow.at_end_of_day.to_i).step(30.minutes).map do |hour|
      [(Time.at(hour).utc).strftime('%H:%M'), Time.at(hour).utc]
    end

    put set_working_time_slots_url(selected_day:@tomorrow), params: { starts_at: hours[0][1], ends_at: hours[10][1] }
    assert_equal('open', @slot_booked.state)
  end
end
