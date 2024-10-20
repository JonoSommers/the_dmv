require 'spec_helper'

RSpec.describe CreatingFacilities do
    before(:each) do
        @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
        @colorado_facilities = CreatingFacilities.new
        @facilities_made = []
    end

    describe '#initialize' do
        it 'exists' do
            expect(@colorado_facilities).to be_a(CreatingFacilities)
            expect(@co_dmv_office_locations).to be_a(Array)
            expect(@facilities_made).to eq([])
        end
    end

    describe '#create_dmv_facilities' do
        it 'creates a new dmv facility and shovels it into the @facilities_made array' do
            @colorado_facilities.create_dmv_facilities(@co_dmv_office_locations)
            expect(@colorado_facilities.facilities_made.first).to be_a(Facility)
            expect(@colorado_facilities.facilities_made.length).to be > 0
        end

        it 'checks the facility info is correct' do
            @colorado_facilities.create_dmv_facilities(@co_dmv_office_locations)
            expect(@colorado_facilities.facilities_made.first.name).to be_a(String)
            expect(@colorado_facilities.facilities_made.first.address).to be_an(String)
            expect(@colorado_facilities.facilities_made.first.phone).to be_a(String)
            expect(@colorado_facilities.facilities_made.first.services).to be_a(String)
            expect(@colorado_facilities.facilities_made.first.registered_vehicles).to be_an(Array)
            expect(@colorado_facilities.facilities_made.first.collected_fees).to be_an(Integer)
        end
    end
end