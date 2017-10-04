class Restaurant < ActiveRecord::Base
  has_many :persons, through: :lunches
  has_many :cuisines, through: :restaurantcategories

  # def self.reset_daily_counters
  #   all.each { |rest|
  #     Restaurant.reset_counters(rest.id, :today_popularity)
  #   }
  # end

end
