class BucketSort
    def self.call_sort(places)
        placesBucket = Array.new(11) { Array.new }
        endBucket = Array.new([])
        
        return BucketSort.sort(places, placesBucket, endBucket)
    end
    
    def self.putIntoBucket(places, placesBucket)
        places.each do |place|
            placesBucket[place.stars*2] << place
        end
    end

    def self.printArray(placesBucket)
        index = 0
        placesBucket.each do |arr|
            arr.each do |int|
                puts "#{int}"
            end
        index += 1
        end
    end

    def self.addToEndBucket(placesBucket, endBucket)
        # index = 0
        placesBucket.each do |arr|
            arr.each do |place|
                endBucket << place
            end
        end
        return endBucket
    end

    def self.sort(places, placesBucket, endBucket)
        BucketSort.putIntoBucket(places, placesBucket)
        return BucketSort.addToEndBucket(placesBucket, endBucket)
    end
end