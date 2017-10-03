class Person < ActiveRecord::Base
  has_many :restaurants, through: :lunches

  def add_lunch(restaurant)
    Lunch.create { |lunch|
      lunch.person = self
      lunch.restaurant = restaurant
      lunch.datetime = Date.today
    }
  end
end
