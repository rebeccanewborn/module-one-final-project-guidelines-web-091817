
![Logo](https://github.com/rebeccanewborn/module-one-final-project-guidelines-web-091817/raw/master/img/logo.png)

# Short Description

This program is built to help students at the Flatiron school have social lunch experiences.
Using the Yelp API we find top rated restaurants within walking distance of 11 Broadway and allow users
to register where they will have lunch, as well as explore where their colleagues will be eating.

# Installation

Install by running "bundle" in project directory.
This project relies on the following Gems:
- sinatra-activerecord
- sqlite3
- pry
- require_all
- http
- json
- bcrypt
- launchy
- command_line_reporter

# Walkthrough

##Login

The program starts by prompting the user to enter their name and cohort:

![Logo](https://github.com/rebeccanewborn/module-one-final-project-guidelines-web-091817/raw/master/img/opening.png)

After identifying that the user name is on record the user will be prompted to enter their password. Passwords are obscured and hidden from the terminal and are then stored using BCrypt to ensure that our database doesn't store an easily accessible string of everyone's passwords.

![Logo](https://github.com/rebeccanewborn/module-one-final-project-guidelines-web-091817/raw/master/img/password.png)

Successful logins take the user the menu where they can choose to:

- Join the most popular lunch of the day, which is displayed above

![Top Recommendations](https://github.com/rebeccanewborn/module-one-final-project-guidelines-web-091817/raw/master/img/yelp_recommendations.png)


![Sushi Search](https://github.com/rebeccanewborn/module-one-final-project-guidelines-web-091817/raw/master/img/yelp_search.png)

- Explore Yelp (User receives a recommendation of the top 10 most highly reviewed restaurants in the vicinity and can then enter search terms to search for specific establishments)
- Explore colleague choices by seeing where they are eating.
- Register that they have brought their own lunch

All options allow you to pick a lunch (which allows others to see your meal and join you) and finish off by sending you to the Yelp page for the chosen restaurant to get a head start on selecting an item from the menu.

# Contributors Guide

# Link to Code License




## Project Requirements

### Option One - Data Analytics Project

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have at minimum three models including one join model. This means you must have a many-to-many relationship.
3. You should seed your database using data that you collect either from a CSV, a website by scraping, or an API.
4. Your models should have methods that answer interesting questions about the data. For example, if you've collected info about movie reviews, what is the most popular movie? What movie has the most reviews?
5. You should provide a CLI to display the return values of your interesting methods.  
6. Use good OO design patterns. You should have separate classes for your models and CLI interface.

### Option Two - Command Line CRUD App

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have a minimum of three models.
3. You should build out a CLI to give your user full CRUD ability for at least one of your resources. For example, build out a command line To-Do list. A user should be able to create a new to-do, see all todos, update a todo item, and delete a todo. Todos can be grouped into categories, so that a to-do has many categories and categories have many to-dos.
4. Use good OO design patterns. You should have separate models for your runner and CLI interface.

### Brainstorming and Proposing a Project Idea

Projects need to be approved prior to launching into them, so take some time to brainstorm project options that will fulfill the requirements above.  You must have a minimum of four [user stories](https://en.wikipedia.org/wiki/User_story) to help explain how a user will interact with your app.  A user story should follow the general structure of `"As a <role>, I want <goal/desire> so that <benefit>"`. In example, if we were creating an app to randomly choose nearby restaurants on Yelp, we might write:

* As a user, I want to be able to enter my name to retrieve my records
* As a user, I want to enter a location and be given a random nearby restaurant suggestion
* As a user, I should be able to reject a suggestion and not see that restaurant suggestion again
* As a user, I want to be able to save to and retrieve a list of favorite restaurant suggestions

## Instructions

1. Fork and clone this repository.
2. Build your application. Make sure to commit early and commit often. Commit messages should be meaningful (clearly describe what you're doing in the commit) and accurate (there should be nothing in the commit that doesn't match the description in the commit message). Good rule of thumb is to commit every 3-7 mins of actual coding time. Most of your commits should have under 15 lines of code and a 2 line commit is perfectly acceptable.
3. Make sure to create a good README.md with a short description, install instructions, a contributors guide and a link to the license for your code.
4. Make sure your project checks off each of the above requirements.
5. Prepare a video demo (narration helps!) describing how a user would interact with your working project.
    * The video should:
      - Have an overview of your project.(2 minutes max)
6. Prepare a presentation to follow your video.(3 minutes max)
    * Your presentation should:
      - Describe something you struggled to build, and show us how you ultimately implemented it in your code.
      - Discuss 3 things you learned in the process of working on this project.
      - Address, if anything, what you would change or add to what you have today?
      - Present any code you would like to highlight.   
7. *OPTIONAL, BUT RECOMMENDED*: Write a blog post about the project and process.
