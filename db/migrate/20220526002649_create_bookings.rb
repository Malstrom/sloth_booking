class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :price, null: false, foreign_key: true
      t.string :email
      t.string :phone
      t.integer :kind

      t.timestamps
    end
  end
end
