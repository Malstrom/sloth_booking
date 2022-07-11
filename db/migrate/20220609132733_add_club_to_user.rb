# frozen_string_literal: true

class AddClubToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :club, foreign_key: true
  end
end
