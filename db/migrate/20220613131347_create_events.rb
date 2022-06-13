class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :club, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone
      t.string :tables
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
