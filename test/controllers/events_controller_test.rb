# frozen_string_literal: true

require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club = clubs(:sokol)
    @event = events(:first_event)
    @slot = slots(:tomorrow_slot)
    @booked_slot = slots(:tomorrow_slot_booked_slot)

    @event_attributes = {
        club: @club,
        name:'giovanni',
        phone: "7349857",
        starts_at: @slot.time,
        duration: 1
    }

    @tomorrow = Date.tomorrow
  end

  test 'should create event' do
    assert_difference('Event.count') do
      post club_events_url(@club),
           params: { event: @event_attributes }
    end
  end

  test 'should book event' do
    assert_difference('Event.count') do
      post book_club_events_url(@club),
           params: { event: @event_attributes }
    end
  end

  test 'should not book event without free slots' do
    @event_attributes[:starts_at] = @booked_slot.time
    assert_no_difference('Event.count') do
      post book_club_events_url(@club),
           params: { event: @event_attributes }
    end
  end

  test 'should update event' do
    patch club_event_url(@club, @event), params: { event: { name: 'marco' } }
    assert_equal('marco', Event.find(@event.id).name)
  end

  test 'should destroy event' do
    assert_difference('Event.count', -1) do
      delete club_event_url(@club, @event)
    end
  end
end
