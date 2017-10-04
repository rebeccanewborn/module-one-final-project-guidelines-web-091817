class Restaurant < ActiveRecord::Base
  has_many :people, through: :lunches
  has_many :lunches
  has_many :cuisines, through: :restaurantcategories
  @@brought_lunch

  def self.today_most_popular
    Restaurant.order(today_popularity: :desc).first
  end

  def self.all_unique
    all.distinct.map.with_index { |rest, i|
      puts "#{i+1}. #{rest.name}  //  #{rest.price}  //  #{rest.address}"
      rest.people.distinct.each { |person|
        puts person.name
      }
      puts ""
      rest
    }
  end

  def self.make_brought
    
  end

end
