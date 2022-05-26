class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.belongs_to :gametable, null: false, foreign_key: true
      t.datetime :hour
      t.integer :value

      t.timestamps
    end
  end
end
