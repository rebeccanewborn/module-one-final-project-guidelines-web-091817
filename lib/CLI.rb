class CLI
  attr_accessor :person, :rest_obj

  def run
    Restaurant.update_all today_popularity: 0 if first_login_today?
    binding.pry
    clear_screen
    welcome
    clear_null_data
    get_username_from_user
  end

  def menu
    first_options
    first = get_choice
    @rest_obj = navigate_to_first_choice(first)
    person.add_lunch(rest_obj)
    end_app(rest_obj)
  end

  def first_login_today?
    !Lunch.all.any? { |lunch| lunch.datetime == Date.today }
  end

  def welcome
    puts "Welcome to the Flatiron School Lunch Pal".colorize(:cyan)
  end

  def get_username_from_user
    puts "Please enter your name"
    user_input = gets.chomp.downcase.gsub(/\s+/, "")
    check_username(user_input)
  end

  def check_username(user_input)
    !!Person.all.find {|person| person.name == user_input} ? get_person_instance(user_input) : ask_user(user_input)
  end

  def get_person_instance(name)
    @person = Person.find_by(name:name)
    check_password
  end

  def ask_user(user_input)
    clear_screen
    puts "It seems that #{user_input} has not been registered yet!".colorize(:light_red)
    puts "Press 1 to create an account or press anything else to go back."
    user_choice = gets.chomp
    user_choice == "1" ? create_new_user(user_input) : run
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

  def check_password
    puts "Please enter your password:"
    pass_input = STDIN.noecho(&:gets).chomp
    restored_hash = BCrypt::Password.new person.password
    restored_hash == pass_input ? menu : try_again
  end

  def try_again
    puts "That password is incorrect".colorize(:red)
    check_password
  end

  def create_new_user(name)
    password = create_password
    @person = Person.create(name: name, password: password.to_s)
    menu
  end

  def create_password
    puts "Please create a new password:"
    pass_input = STDIN.noecho(&:gets).chomp
    BCrypt::Password.create pass_input
  end

  def first_options
    clear_screen
    puts "Welcome #{person.name}!"

    puts "Today's most popular lunch is #{Restaurant.today_most_popular.name}." if !first_login_today?

    msg = <<-MSG
      What would you like to do?
      1. Join today's most popular lunch
      2. Explore Yelp
      3. Explore Flatiron students' lunch choices
      4. None of the above - I brought my own lunch today!
    MSG
    puts msg
  end

  def get_choice
    gets.chomp
  end

  def navigate_to_first_choice(choice)
    case choice
    when "1"
      join_most_popular
    when "2"
      explore_yelp(top_ten_recommendations)
    when "3"
      array = see_what_classmates_are_eating_today
      explore_flatiron_students(array)
    when "4"
      brought_lunch
    when "back" || "return"
      run
    else
      puts "Whoooooooops!".colorize(:light_red)
      menu
    end
  end

  def join_most_popular
    Restaurant.today_most_popular
  end

  def top_ten_recommendations
    response = search(DEFAULT_TERM, DEFAULT_LOCATION, DEFAULT_RADIUS)
    header = "These are the ten highest rated restaurants near you: "
    list_out_options(response, header)
    # find_or_create_restaurant_object(response["businesses"])
    response
  end

  def list_out_options(response, header)
    # puts "Found #{response["total"]} businesses within #{DEFAULT_RADIUS} meters. Listing #{SEARCH_LIMIT}:"
    puts "
    #{header}
    "
    response["businesses"].each_with_index {|biz,i| puts "#{i+1}. #{biz['name']}  //  #{biz['price']}  //  #{biz['location']['address1']}"}
  end

  def find_or_create_restaurant_object(response)
    choice = response[pick_from_current_list]
    Restaurant.find_or_create_by(name:choice["name"],rating:choice["rating"], price:choice["price"], address:choice["location"]["display_address"][0], url: choice["url"])
  end

  def find_by_choice(response, number)
    choice = response[number-1]
    Restaurant.find_or_create_by(name:choice["name"],rating:choice["rating"], price:choice["price"], address:choice["location"]["display_address"][0], url: choice["url"])
  end

  def explore_yelp(response)
    puts "
    Choose from the list above, enter your own search term to explore other options, or enter 'back' to return to the main menu."
    input = get_input_from_user


    (1..SEARCH_LIMIT).to_a.include?(input.to_i) ? find_by_choice(response["businesses"], input.to_i) : search_yelp(input)
  end

  def search_yelp(input)
    response = search(input, DEFAULT_LOCATION, DEFAULT_RADIUS)
    header =  "Found #{response["total"]} businesses within #{DEFAULT_RADIUS} meters. Listing #{SEARCH_LIMIT}:"
    list_out_options(response, header)
    puts "Choose from options above, or enter 'back' to return to the main menu"
    find_or_create_restaurant_object(response["businesses"])
  end


  def get_input_from_user
    output = gets.chomp.downcase.gsub(/\s+/, "")
    back(output)
  end

  def back(output)
    clear_null_data
    output == "back" || output ==  "return" ? menu :  output
  end

  def explore_flatiron_students(array)
    # puts "
    # Choose from the list above, enter your own search term to explore other options, or enter 'back' to return to the main menu."
    # input = get_input_from_user
    #
    #
    # (1..SEARCH_LIMIT).to_a.include?(input.to_i) ? find_or_create_restaurant_object(response["businesses"]) : search_yelp(input)

    msg = <<-MSG

      Choose from the list above to join a classmate, enter 'search people' to explore people, enter 'browse restaurants' to explore restaurants, and as always, enter 'back' to return to the main menu.

      MSG

    puts msg
    flatiron_student_options(gets.chomp, array)
  end

  def flatiron_student_options(choice, array)
    back(choice)
    case choice
    when "search people"
      search_by_classmate
    when "browse restaurants"
      browse_restaurants
    else
      if (1..100).to_a.include?(choice.to_i)
        array[choice.to_i-1]
      else
        puts "whooops! try again"
        explore_flatiron_students
      end
    end
  end

  def see_what_classmates_are_eating_today
    rest_array = Lunch.display_all_today_lunches
  end

  def search_by_classmate
    puts "Enter the name of the student you'd like to search"
    person = Person.find_by(name: gets.chomp.downcase.gsub(/\s+/, ""))
    rest_array = Lunch.display_all_lunches_of_person(person)
    puts "Choose from options above, or enter 'back' to return to the main menu"
    rest_array[pick_from_current_list]
  end

  def browse_restaurants
    all_rests = Restaurant.all_unique
    puts "Choose from options above, or enter 'back' to return to the main menu"
    all_rests[pick_from_current_list]
  end

  def pick_from_current_list
    # puts "Choose from the options above, or enter 'back' to return to the main menu."
    output = gets.chomp
    back(output).to_i - 1
  end

  def brought_lunch
    rest = Restaurant.find_or_create_by(name: "Brought Lunch", rating: 5.0, price: "$", address: "Flatiron School", url: "www.yelp.com")
    Lunch.display_all_brought_lunches(rest)
  end

  def clear_null_data
    Lunch.all.where(restaurant_id: nil).each {|lunch| lunch.destroy }
  end

  def end_app(lunch)
    clear_screen
    puts "You picked #{lunch.name} located at #{lunch.address}."
    puts "We hope you enjoy your lunch! Check out #{lunch.name}'s Yelp page now!'"
    sleep 5
    Launchy.open(rest_obj.url)
  end
end
