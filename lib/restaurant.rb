class Restaurant < ActiveRecord::Base
  has_many :persons, through: :lunches
  has_many :cuisines, through: :restaurantcategories
end
