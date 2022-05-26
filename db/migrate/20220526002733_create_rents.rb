class CreateRents < ActiveRecord::Migration[7.0]
  def change
    create_table :rents do |t|
      t.belongs_to :booking, null: false, foreign_key: true
      t.integer :balls
      t.integer :rackets
      t.integer :robot
      t.belongs_to :trainer, null: true, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
