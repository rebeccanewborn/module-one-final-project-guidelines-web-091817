class Lunch < ActiveRecord::Base
  belongs_to :person
  belongs_to :restaurant

  def self.display_all_today_lunches(cohort)
    # .map.with_index { |lunch,i|
    all_today_cohort = all.select { |lunch|
      lunch.datetime == Date.today && lunch.person.cohort == cohort
    }
    Table.new.all_today_lunches_table(all_today_cohort)
    #   puts Table.all_today_lunches_table(response)
    #   lunch.restaurant
    # }
    all_today_cohort.map { |lunch| lunch.restaurant }
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

  def self.display_all_brought_lunches_today(restaurant, person)
    all.where(:restaurant_id => restaurant.id, :datetime => Date.today).each { |lunch|
      puts lunch.person.name if lunch.person_id != person.id
    }
  end

end
