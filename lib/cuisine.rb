class Cuisine < ActiveRecord::Base
  has_many :restaurants, through: :restaurantcategories
end
