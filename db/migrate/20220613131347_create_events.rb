# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :club, null: false, foreign_key: true
      t.string :name
      t.string :phone
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :duration
      t.date :day

      t.timestamps
    end
  end
end
