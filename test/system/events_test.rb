# frozen_string_literal: true

require 'application_system_test_case'

class EventsTest < ApplicationSystemTestCase
  setup do
    @event = events(:one)
  end

  test 'visiting the index' do
    visit events_url
    assert_selector 'h1', text: 'Events'
  end

  test 'should create event' do
    visit events_url
    click_on 'New event'

    fill_in 'Club', with: @event.club_id
    fill_in 'Email', with: @event.email
    fill_in 'Ends at', with: @event.ends_at
    fill_in 'Name', with: @event.name
    fill_in 'Phone', with: @event.phone
    fill_in 'Starts at', with: @event.starts_at
    fill_in 'Tables', with: @event.tables
    click_on 'Create Event'

    assert_text 'Event was successfully created'
    click_on 'Back'
  end

  test 'should update Event' do
    visit event_url(@event)
    click_on 'Edit this event', match: :first

    fill_in 'Club', with: @event.club_id
    fill_in 'Email', with: @event.email
    fill_in 'Ends at', with: @event.ends_at
    fill_in 'Name', with: @event.name
    fill_in 'Phone', with: @event.phone
    fill_in 'Starts at', with: @event.starts_at
    fill_in 'Tables', with: @event.tables
    click_on 'Update Event'

    assert_text 'Event was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Event' do
    visit event_url(@event)
    click_on 'Destroy this event', match: :first

    assert_text 'Event was successfully destroyed'
  end
end
