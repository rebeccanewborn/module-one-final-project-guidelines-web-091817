class Table
  include CommandLineReporter

  def yelp_table(response)
    CLI.resize_screen
    table(border: true) do
     row do
       column('Number', width: 15, align: 'center')
       column('Name', width: 40, align: 'center', padding: 5)
       column('Price', width: 15, align: 'center')
       column('Address', width: 25, align: 'center')
     end

     response["businesses"].each_with_index do |biz,i|
       row do
         column("#{i+1}")
         column("#{biz['name']}")
         column("#{biz['price']}")
         column("#{biz['location']['address1']}")
       end
     end
   end
  end

  def all_today_lunches_table(response)
    CLI.resize_screen
    table(border: true) do
     row do
       column('Number', width: 10, align: 'center')
       column('Name', width: 28, align: 'center')
       column('Restaurant', width: 27, align: 'center')
       column('Price', width: 10, align: 'center')
       column('Address', width: 25, align: 'center')
     end

     response.each_with_index do |lunch,i|
       row do
         column("#{i+1}")
         column("#{lunch.person.name}")
         column("#{lunch.restaurant.name}")
         column("#{lunch.restaurant.price}")
         column("#{lunch.restaurant.address}")
       end
     end
   end
  end


end
