class Lunch < ActiveRecord::Base
  belongs_to :person
  belongs_to :restaurant
end
