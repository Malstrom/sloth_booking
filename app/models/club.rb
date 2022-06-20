# frozen_string_literal: true

class Club < ApplicationRecord
  has_many   :users, dependent: :delete_all
  has_many   :gametables, dependent: :delete_all
  has_many   :tournaments, dependent: :delete_all
  has_many   :trainings, dependent: :delete_all
  has_many   :events, dependent: :delete_all
end
