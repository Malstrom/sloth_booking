class CreateTrainings < ActiveRecord::Migration[7.0]
  def change
    create_table :trainings do |t|
      t.belongs_to :club, null: false, foreign_key: true
      t.string :trainer
      t.string :name
      t.integer :price
      t.date :day

      t.timestamps
    end
  end
end
