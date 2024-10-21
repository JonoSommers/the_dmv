class CreatingFacilities
    attr_reader :facilities_made

    def initialize
        @facilities_made = []
    end

    def create_dmv_facilities(all_facilities)
        all_facilities.each do |facility|
            new_facility = Facility.new(facility)
            @facilities_made << new_facility
        end
    end
end