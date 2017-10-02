class CreateRestaurantCategories < ActiveRecord::Migration
  def change
    create_table :restaurantcategories do |t|
      t.integer :restaurant_id
      t.integer :cuisine_id
    end
  end
end
