class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.belongs_to :club, null: false, foreign_key: true
      t.string :rating
      t.integer :price

      t.timestamps
    end
  end
end
