class Person < ActiveRecord::Base
  has_many :restaurants, through: :lunches
end
