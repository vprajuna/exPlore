namespace :import do
  desc 'Import places into db'
  task photos: :environment do

    current_places = Place.where.not(photo_id: nil)

    File.foreach('public/photos.json') do |json|
      parsed_data = JSON.parse(json, symbolize_names: true)
      place = Place.where(business_id: parsed_data[:business_id]).first
      if place.photo_id.nil?
        place.update_attribute(:photo_id, parsed_data[:photo_id])
        puts "Updated photo for #{place.business_id}"
      else
        puts "#{place.business_id} already has photo."
      end
    end
    
    puts "#{Place.where.not(photo_id: nil) - current_places} Photos have been added."
  end
end
