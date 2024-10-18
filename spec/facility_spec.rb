require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})

    describe '#initialize' do
      it 'can initialize' do
        expect(@facility).to be_an_instance_of(Facility)
        expect(@facility.name).to eq('DMV Tremont Branch')
        expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
        expect(@facility.phone).to eq('(720) 865-4600')
        expect(@facility.services).to eq([])
      end
    end

    describe '#add service' do
      it 'can add available services' do
        expect(@facility.services).to eq([])
        @facility.add_service('New Drivers License')
        @facility.add_service('Renew Drivers License')
        @facility.add_service('Vehicle Registration')
        expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
      end
    end
  end

  before(:each) do
    facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )

    describe '#vehicle registration' do
      it 'exists' do
        expect(facility_1).to be_a(Facility)
        expect(facility_2).to be_a(Facility)
        expect(cruz).to be_a(Vehicle)
        expect(bolt).to be_a(Vehicle)
        expect(camaro).to be_a(Vehicle)
      end

      it 'starts unregistered' do
        expect(cruz.registration_date).to be(nil)
        expect(facility_1.registered_vehicles).to eq([])
        expect(facility_1.collected_fees).to eq(0)
      end

      it 'add_service "vehicle registration" service to facility_1' do
        expect(facility_1.add_service).to be('Vehicle Registration')
      end

      it 'registers the cruz vehicle' do
        expect(facility_1.register_vehicle(cruz)).to eq([cruz])
        expect(cruz.registration_date).to eq(2023-01-12)
        expect(cruz.plate_type).to eq(:regular)
        expect(facility_1.registered_vehicles).to eq([cruz])
        expect(facility_1.collected_fees).to eq(100)
      end
    end
  end
end