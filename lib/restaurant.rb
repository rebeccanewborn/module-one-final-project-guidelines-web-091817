class Restaurant < ActiveRecord::Base
  has_many :persons, through: :lunches
  has_many :cuisines, through: :restaurantcategories

  def self.today_most_popular
    Restaurant.order(today_popularity: :desc).first
  end

end
