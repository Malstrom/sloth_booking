class CreateTimecells < ActiveRecord::Migration[7.0]
  def change
    create_table :timecells do |t|
      t.belongs_to :gametable, null: false, foreign_key: true
      t.datetime :time
      t.integer :price
      t.integer :tournament_rating
      t.string :trainer

      t.references :bookable, polymorphic: true

      t.timestamps
    end
  end
end
