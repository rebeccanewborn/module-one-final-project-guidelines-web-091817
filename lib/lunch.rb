class Lunch < ActiveRecord::Base
  belongs_to :person
  belongs_to :restaurant

  def self.display_all_today_lunches
    all.each_with_index.map { |lunch,i|
      puts "#{i+1}. #{lunch.person.name} // #{lunch.restaurant.name} // #{lunch.restaurant.address} // #{lunch.restaurant.price}"
      lunch.restaurant
    }
  end
end
