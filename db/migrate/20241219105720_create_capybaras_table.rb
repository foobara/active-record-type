class CreateCapybarasTable < ActiveRecord::Migration[8.0]
  def change
    puts "about to create_table"
    create_table :capybaras do |t|
      t.string :name, null: false
      t.string :nickname
      t.integer :age
      t.integer :legs, default: 4
      t.timestamps
    end
  end
end
