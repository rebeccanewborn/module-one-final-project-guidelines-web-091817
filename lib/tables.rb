class Example
  include CommandLineReporter

  def yelp_table(response)
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
end
