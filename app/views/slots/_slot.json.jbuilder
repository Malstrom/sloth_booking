# frozen_string_literal: true

json.extract! slot, :id, :gametable_id, :time, :price, :bookable_id, :bookable_type, :created_at, :updated_at
json.url slot_url(slot, format: :json)
