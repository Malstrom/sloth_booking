json.extract! tournament, :id, :name, :rating, :starts_at, :ends_at, :price, :created_at, :updated_at
json.url tournament_url(tournament, format: :json)
