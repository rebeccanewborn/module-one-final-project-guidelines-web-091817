require_relative "person.rb"
require_relative "lunch.rb"
require_relative "restaurant.rb"
require_relative "restaurantcategory.rb"
require_relative "cuisine.rb"

require_relative "command_line_interface.rb"

class RunMethod
  def get_person_instance(name)
    Person.find_or_create_by(name: name)
  end

  def run
    welcome
    username = get_username_from_user
    person = get_person_instance(username)
    first_options(username)
    first = get_first_choice
    navigate_to_first_choice(first)
  end

  def navigate_to_first_choice(choice)
    if choice == "1"
      top_ten_recommendations
    elsif choice == "2"
      see_what_classmates_are_eating
    elsif choice == "3"
      explore_yelp
    end
  end

  def top_ten_recommendations
  end

  def see_what_classmates_are_eating
    
  end

  def explore_yelp(arg)
  end


end
