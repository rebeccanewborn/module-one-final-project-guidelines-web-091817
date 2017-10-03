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
    first = get_choice
    rest_obj = navigate_to_first_choice(first)
    person.add_lunch(rest_obj)
    binding.pry
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
      response = search(DEFAULT_TERM, DEFAULT_LOCATION, DEFAULT_RADIUS)
      puts "Found #{response["total"]} businesses within #{DEFAULT_RADIUS} meters. Listing #{SEARCH_LIMIT}:"
      response["businesses"].each_with_index {|biz,i| puts "#{i+1}. #{biz['name']}  //  #{biz['price']}  //  #{biz['location']['address1']}"}
      find_or_create_restaurant_object(response["businesses"])
  end

  def see_what_classmates_are_eating

  end

  def explore_yelp
      term = get_searchterm_from_user
      response = search(term, DEFAULT_LOCATION, DEFAULT_RADIUS)

      puts "Found #{response["total"]} businesses. Listing #{SEARCH_LIMIT}:"
      response["businesses"].each_with_index {|biz,i| puts "#{i+1}. #{biz['name']}  //  #{biz['price']}  //  #{biz['location']['address1']}"}

      find_or_create_restaurant_object(response["businesses"])


  end

  def find_or_create_restaurant_object(response)
    choice = response[pick_from_current_list]
    rest_object = Restaurant.find_or_create_by(name:choice["name"],rating:choice["rating"], price:choice["price"], address:choice["location"]["display_address"][0])
  end
end
