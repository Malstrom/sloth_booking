json.extract! event, :id, :club_id, :name, :email, :phone, :created_at, :updated_at
json.url event_url(event, format: :json)
