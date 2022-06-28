# frozen_string_literal: true

require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club = clubs(:sokol)
    @event = events(:first_event)
    @tomorrow = Date.tomorrow
  end

  test 'should create event' do
    assert_difference('Event.count') do
      post club_events_url(@club),
           params: { event: { name: @event.name, phone: @event.phone, day: @tomorrow } }
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
