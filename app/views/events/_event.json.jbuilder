# frozen_string_literal: true

json.extract! event, :id, :club_id, :name, :email, :phone, :tables, :starts_at, :ends_at, :created_at, :updated_at
json.url event_url(event, format: :json)
