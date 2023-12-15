namespace :import do
  desc 'Import places into db'
  task places: :environment do

    current_places = Place.all.count

    File.foreach('public/yelp_academic_dataset_business.json') do |json|
      parsed_data = JSON.parse(json, symbolize_names: true)
      Place.create(
        name: parsed_data[:name],
        business_id: parsed_data[:business_id],
        address: parsed_data[:address],
        city: parsed_data[:city],
        state: parsed_data[:state],
        postal_code: parsed_data[:postal_code],
        stars: parsed_data[:stars],
        reviews: parsed_data[:reviews],
        categories: parsed_data[:categories]
      )
    end
    
    puts "#{Place.all.count - current_places} Places have been created."
  end
end