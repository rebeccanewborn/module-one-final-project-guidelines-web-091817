class Person < ActiveRecord::Base
  include BCrypt
  has_many :restaurants, through: :lunches
  has_many :lunches
  belongs_to :cohort

  def add_lunch(restaurant)
    Lunch.create { |lunch|
      lunch.person = self
      lunch.restaurant = restaurant
      lunch.datetime = Date.today
      Restaurant.increment_counter(:all_time_popularity, restaurant.id)
      Restaurant.increment_counter(:today_popularity, restaurant.id)
    }
  end

end
