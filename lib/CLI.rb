class CLI
  attr_accessor :person
  def run
    welcome
    username = get_username_from_user
    @person = get_person_instance(username)
    first_options
    first = get_choice
    rest_obj = navigate_to_first_choice(first)
    person.add_lunch(rest_obj)
    end_app(rest_obj)
  end

  def welcome
    puts "Welcome to Flatiron School lunch application"
  end

  def get_username_from_user
    puts "Please enter your name"
    gets.chomp.downcase.gsub(/\s+/, "")
  end

  def get_person_instance(name)
    Person.find_or_create_by(name: name)
  end

  def first_options
    msg = <<-MSG
      Welcome #{person.name}. What would you like to do?
      1. View recommendations close to you
      2. Explore Flatiron students' lunch choices
      3. Explore Yelp
    MSG
    puts msg
  end

  def get_choice
    gets.chomp
  end

  def navigate_to_first_choice(choice)
    case choice
    when "1"
      top_ten_recommendations
    when "2"
      explore_flatiron_students
    when "3"
      explore_yelp
    end
  end

  def top_ten_recommendations
    response = search(DEFAULT_TERM, DEFAULT_LOCATION, DEFAULT_RADIUS)
    list_out_options(response)
    find_or_create_restaurant_object(response["businesses"])
  end

  def list_out_options(response)
    puts "Found #{response["total"]} businesses within #{DEFAULT_RADIUS} meters. Listing #{SEARCH_LIMIT}:"
    response["businesses"].each_with_index {|biz,i| puts "#{i+1}. #{biz['name']}  //  #{biz['price']}  //  #{biz['location']['address1']}"}
  end

  def find_or_create_restaurant_object(response)
    choice = response[pick_from_current_list]
    Restaurant.find_or_create_by(name:choice["name"],rating:choice["rating"], price:choice["price"], address:choice["location"]["display_address"][0])
  end

  def explore_flatiron_students
    msg = <<-MSG
      What would you like to do?
      1. See where your classmates are planning on eating today
      2. See where Flatiron students have eaten recently
      3. Search by classmate for their recent lunch history
    MSG
    puts msg
    flatiron_student_options(gets.chomp)
  end

  def flatiron_student_options(choice)
    case choice
    when "1"
      see_what_classmates_are_eating_today
    when "2"
      see_where_classmates_have_eaten_recently
    when "3"
      search_by_classmate
    end
  end

  def see_what_classmates_are_eating_today
    rest_array = Lunch.display_all_today_lunches
    rest_array[pick_from_current_list]
  end

  def see_where_classmates_have_eaten_recently
    rest_array = Lunch.display_all_recent_lunches
    rest_array[pick_from_current_list]
  end

  def search_by_classmate
    puts "Enter the name of the student you'd like to search"
    person = Person.find_by(name: gets.chomp.downcase.gsub(/\s+/, ""))
    rest_array = Lunch.display_all_lunches_of_person(person)
    rest_array[pick_from_current_list]
  end

  def pick_from_current_list
    puts "Enter the number of where you'd like to eat"
    gets.chomp.to_i - 1
  end

  def explore_yelp
    term = get_searchterm_from_user
    response = search(term, DEFAULT_LOCATION, DEFAULT_RADIUS)
    list_out_options(response)
    find_or_create_restaurant_object(response["businesses"])
  end

  def get_searchterm_from_user
    puts "Excellent! What are you in the mood for today?"
    gets.chomp.downcase.gsub(/\s+/, "")
  end

  def end_app(lunch)
    puts "You picked #{lunch.name} located at #{lunch.address}."
    puts "We hope you enjoy your lunch! Bon appetit"
  end
end
