class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.references :gametable, null: false, foreign_key: true
      t.datetime :time
      t.integer :price
      t.integer :state, default: 0
      t.references :bookable, polymorphic: true

      t.timestamps
    end
  end
end
