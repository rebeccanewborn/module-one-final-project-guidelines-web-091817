class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.float :rating
      t.string :price
      t.string :address #"location" ==> {... , "display_address": string, ...}
    end
  end
end
