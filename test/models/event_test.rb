# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event = Event.new(club: Club.first, name: 'giovanni', phone: '7349857', starts_at: ('14:00'.to_time + 1.day),
                       duration: 1, day: Time.zone.tomorrow)
  end
end
