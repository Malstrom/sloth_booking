class CreateClubs < ActiveRecord::Migration[7.0]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :starts_at
      t.string :ends_at

      t.timestamps
    end
  end
end
