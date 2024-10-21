require 'spec_helper'

RSpec.describe CreatingFacilities do
    before(:each) do
        @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
        @ny_dmv_office_locations = DmvDataService.new.ny_dmv_office_locations
        @mo_dmv_office_locations = DmvDataService.new.mo_dmv_office_locations
        @missouri_facilities = CreatingFacilities.new
        @colorado_facilities = CreatingFacilities.new
        @new_york_facilities = CreatingFacilities.new
        @facilities_made = []

    end

    describe '#initialize' do
        it 'exists' do
            expect(@colorado_facilities).to be_a(CreatingFacilities)
            expect(@new_york_facilities).to be_a(CreatingFacilities)
            expect(@missouri_facilities).to be_a(CreatingFacilities)
            expect(@co_dmv_office_locations).to be_an(Array)
            expect(@ny_dmv_office_locations).to be_an(Array)
            expect(@mo_dmv_office_locations).to be_an(Array)
            expect(@facilities_made).to eq([])
        end
    end

    describe '#create_dmv_facilities' do
        it 'creates a new dmv facility and shovels it into the @facilities_made array' do
            @colorado_facilities.create_dmv_facilities(@co_dmv_office_locations)
            expect(@colorado_facilities.facilities_made.sample).to be_a(Facility)
            expect(@colorado_facilities.facilities_made.length).to be > 0
        end

        it 'checks the CO facility info is correct' do
            @colorado_facilities.create_dmv_facilities(@co_dmv_office_locations)
            expect(@colorado_facilities.facilities_made.sample.name).to be_a(String)
            expect(@colorado_facilities.facilities_made.sample.address).to be_an(String)
            expect(@colorado_facilities.facilities_made.sample.phone).to be_a(String)
            expect(@colorado_facilities.facilities_made.sample.services).to be_a(String)
            expect(@colorado_facilities.facilities_made.sample.registered_vehicles).to be_an(Array)
            expect(@colorado_facilities.facilities_made.sample.collected_fees).to be_an(Integer)
        end
        
        it 'checks the NY facility info is correct' do
            @new_york_facilities.create_dmv_facilities(@ny_dmv_office_locations)
            expect(@new_york_facilities.facilities_made.sample.name).to be_a(String)
            expect(@new_york_facilities.facilities_made.sample.address).to be_an(String)
            expect(@new_york_facilities.facilities_made.sample.phone).to be_a(String).or be_nil
            expect(@new_york_facilities.facilities_made.sample.services).to be_an(Array)
            expect(@new_york_facilities.facilities_made.sample.registered_vehicles).to be_an(Array)
            expect(@new_york_facilities.facilities_made.sample.collected_fees).to be_an(Integer)
        end

        it 'checks the MO facility infor is correct' do
            @missouri_facilities.create_dmv_facilities(@mo_dmv_office_locations)
            expect(@missouri_facilities.facilities_made.sample.name).to be_a(String)
            expect(@missouri_facilities.facilities_made.sample.address).to be_an(String)
            expect(@missouri_facilities.facilities_made.sample.phone).to be_a(String)
            expect(@missouri_facilities.facilities_made.sample.services).to be_an(Array)
            expect(@missouri_facilities.facilities_made.sample.registered_vehicles).to be_an(Array)
            expect(@missouri_facilities.facilities_made.sample.collected_fees).to be_an(Integer)
        end
    end
end