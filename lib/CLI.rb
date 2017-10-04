class CLI
  attr_accessor :person

  def run
    Restaurant.update_all today_popularity: 0 if first_login_today?
    clear_screen
    welcome
    clear_null_data
    get_username_from_user
  end

  def menu
    first_options
    first = get_choice
    rest_obj = navigate_to_first_choice(first)
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
    msg = <<-MSG
      Welcome #{person.name}. What would you like to do?
      1. View recommendations close to you
      2. Explore Flatiron students' lunch choices
      3. Explore Yelp
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
      top_ten_recommendations
    when "2"
      explore_flatiron_students
    when "3"
      explore_yelp
    when "4"
      brought_lunch
    when "back" || "return"
      run
    else
      puts "Whoooooooops!".colorize(:light_red)
      menu
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

      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      What would you like to do?
      1. See where your classmates are planning on eating today
      2. See where Flatiron studen2ts have eaten recently
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
    else
      puts "whooops! try again".colorize(:light_red)
      explore_flatiron_students
    end
  end

  def see_what_classmates_are_eating_today
    rest_array = Lunch.display_all_today_lunches
    input = pick_from_current_list
    rest_array[input]
  end

  def see_where_classmates_have_eaten_recently
    rest_array = Lunch.display_all_recent_lunches
    rest_array.uniq!
    rest_array[pick_from_current_list]
  end

  def search_by_classmate
    puts "Enter the name of the student you'd like to search"
    person = Person.find_by(name: gets.chomp.downcase.gsub(/\s+/, ""))
    rest_array = Lunch.display_all_lunches_of_person(person)
    rest_array[pick_from_current_list]
  end

  def pick_from_current_list
    puts "Select the number of where you'd like to eat"
    puts "Enter 'Back' to return."
    output = gets.chomp
    back(output).to_i - 1
  end

  def explore_yelp
    term = get_searchterm_from_user
    response = search(term, DEFAULT_LOCATION, DEFAULT_RADIUS)
    list_out_options(response)
    find_or_create_restaurant_object(response["businesses"])
  end

  def get_searchterm_from_user
    puts "Excellent! What are you in the mood for today?"
    puts "Enter 'Back' to return."
    output = gets.chomp.downcase.gsub(/\s+/, "")
    back(output)
  end

  def brought_lunch
  end

  def back(output)
    clear_null_data
    output == "back" || output ==  "return" ? menu :  output
  end

  def clear_null_data
    Lunch.all.where(restaurant_id: nil).each {|lunch| lunch.destroy }
  end

  def end_app(lunch)
    clear_screen
    puts "You picked #{lunch.name} located at #{lunch.address}."
    puts "We hope you enjoy your lunch! Bon appetit"
  end
end
