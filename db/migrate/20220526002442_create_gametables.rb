class CreateGametables < ActiveRecord::Migration[7.0]
  def change
    create_table :gametables do |t|
      t.belongs_to :club, null: false, foreign_key: true
      t.string :description
      t.integer :active
      t.integer :display_description
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
