class AddPopularitiesToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :all_time_popularity, :integer, :default => 0
    add_column :restaurants, :today_popularity, :integer, :default => 0
  end
end
