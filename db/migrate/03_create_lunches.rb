class CreateLunches < ActiveRecord::Migration
  def change
    create_table :lunches do |t|
      t.integer :person_id
      t.integer :restaurant_id
      t.datetime :datetime
    end
  end
end
