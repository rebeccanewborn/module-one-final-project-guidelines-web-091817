require_relative "person.rb"
require_relative "lunch.rb"
require_relative "restaurant.rb"
require_relative "restaurantcategory.rb"
require_relative "cuisine.rb"

def welcome
  puts "Welcome to Flatiron School lunch application"
end

def get_username_from_user
    puts "Please enter your name"
    gets.chomp.downcase.gsub(/\s+/, "")
end

def first_options(username)
  msg = <<-MSG
    Welcome #{username}. What would you like to do?
    1. View recommendations close to you
    2. See what your classmates are eating
    3. Explore Yelp
  MSG
  puts msg
end

def get_first_choice
  gets.chomp
end
