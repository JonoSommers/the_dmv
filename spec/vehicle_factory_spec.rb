require 'spec_helper'

RSpec.describe VehicleFactory do
    before(:each) do
        @factory = VehicleFactory.new
        @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
        @vehicles_made = []
    end

    describe '#initialize' do
        it 'exists' do
            expect(@factory).to be_a(VehicleFactory)
            expect(@wa_ev_registrations).to be_an(Array)
            expect(@vehicles_made).to eq([])
        end
    end

    describe '#create_vehicles' do
        it 'creates a vehicle and shovles it into the @created_vehicles array' do
            @factory.create_vehicles(@wa_ev_registrations)
            expect(@factory.vehicles_made.first).to be_a(Vehicle)
            expect(@factory.vehicles_made.length).to be > 0
        end

        it 'checks the vehicle info is correct' do
            @factory.create_vehicles(@wa_ev_registrations)
            expect(@factory.vehicles_made.first.vin).to be_a(String)
            expect(@factory.vehicles_made.first.year).to be_a(String)
            expect(@factory.vehicles_made.first.make).to be_a(String)
            expect(@factory.vehicles_made.first.model).to be_a(String)
            expect(@factory.vehicles_made.first.engine).to be_a(Symbol)
            expect(@factory.vehicles_made.first.registration_date).to be(nil)
            expect(@factory.vehicles_made.first.plate_type).to be_a(Symbol)
        end
    end
end