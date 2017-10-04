class Lunch < ActiveRecord::Base
  belongs_to :person
  belongs_to :restaurant

  def self.display_all_today_lunches
    all.where(datetime: Date.today).map.with_index { |lunch,i|
      puts "#{i+1}. #{lunch.person.name} // #{lunch.restaurant.name} // #{lunch.restaurant.address} // #{lunch.restaurant.price}"
      lunch.restaurant
    }
  end

  def self.display_all_recent_lunches
    all.where("datetime >= #{Date.today-14}").map.with_index { |lunch,i|
      puts "#{i+1}. #{lunch.restaurant.name}"
      lunch.restaurant
    }
  end

  def self.display_all_lunches_of_person(person)
    all.where(person_id: person.id).map.with_index { |lunch, i|
      puts "#{i+1}. #{lunch.restaurant.name}"
      lunch.restaurant
    }
  end

end
