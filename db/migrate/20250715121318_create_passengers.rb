class CreatePassengers < ActiveRecord::Migration[8.0]
  def change
    create_table :passengers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.references :booking, null: false, foreign_key: true
      t.timestamps
    end
  end
end
