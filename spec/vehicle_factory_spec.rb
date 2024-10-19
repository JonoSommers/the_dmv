require 'spec_helper'

RSpec.describe VehicleFactory do
    before(:each) do
        @factory = VehicleFactory.new
        @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
        @factory.create_vehilces(@wa_ev_registrations)
        @created_vehicles = []
    end

    describe '#initialize' do
        it 'exists' do
            expect(@factory).to be_a(VehicleFactory)
            expect(@wa_ev_registrations).to be_an(Array)
            expect(@created_vehicles).to eq([])
        end
    end

    describe '#create_vehicles' do
        it 'creates a vehicle and shovles it into the @created_vehicles array' do
            @factory.create_vehicles(@wa_ev_registrations)
            expect(@created_vehicles.first).to be_a(Vehicle)
            expect(@created_vehicles.length).to be > 0
        end
    end
end