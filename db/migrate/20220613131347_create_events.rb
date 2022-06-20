# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :club, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone
      t.integer :price
      t.date :day

      t.timestamps
    end
  end
end
