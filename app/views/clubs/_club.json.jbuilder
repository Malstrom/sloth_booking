# frozen_string_literal: true

json.extract! club, :id, :created_at, :updated_at
json.url club_url(club, format: :json)
