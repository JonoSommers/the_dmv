require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
  end

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

  before(:each) do
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
    @today = Date.today
  end

  describe '#vehicle registration' do
    it 'exists' do
      expect(@facility_1).to be_a(Facility)
      expect(@facility_2).to be_a(Facility)
      expect(@cruz).to be_a(Vehicle)
      expect(@bolt).to be_a(Vehicle)
      expect(@camaro).to be_a(Vehicle)
      expect(@today).to be_an_instance_of(Date)
    end

    it 'has an unregistered vehicle by default' do
      expect(@cruz.registration_date).to be(nil)
      expect(@facility_1.registered_vehicles).to eq([])
      expect(@facility_1.collected_fees).to eq(0)
    end

    it 'add_service "vehicle registration" service to facility_1' do
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(['Vehicle Registration'])
    end
    
    it 'registers the cruz vehicle adds it to the registered_vehicles array' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      expect(@cruz.registration_date).to eq(@today)
      expect(@cruz.plate_type).to eq(:regular)
      expect(@facility_1.registered_vehicles).to eq([@cruz])
      expect(@facility_1.collected_fees).to eq(100)
    end

    it 'registers the camaro vehicle and adds it to the registered_vehicles array' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      expect(@camaro.registration_date).to eq(@today)
      expect(@camaro.plate_type).to eq(:antique)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro])
    end

    it 'registers the bolt vehicle' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)
      expect(@bolt.registration_date).to eq(@today)
      expect(@bolt.plate_type).to eq(:ev)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro, @bolt])
    end
  end

  describe '#@registered_vehicles' do
    it 'stores all the registered vehciles in an array' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro, @bolt])
    end
  end

  describe '#@collected_fees' do
    it 'stores and increases the total collected fees from registered vehicles' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)
      expect(@facility_1.collected_fees).to eq(325)
    end
  end

  describe '@facility_2' do
    it 'starts with an empty array of registered_vehicles and services' do
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.services).to eq([])
    end

    it '@facility_2 cannot register a vehicle' do
      expect(@facility_2.register_vehicle(@bolt)).to be(nil)
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.collected_fees).to eq(0)
    end
  end

  before(:each) do
    @registrant_1 = Registrant.new('Bruce', 18, true )
    @registrant_2 = Registrant.new('Penny', 16 )
    @registrant_3 = Registrant.new('Tucker', 15 )
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
  end

  describe 'instances' do
    it 'exists' do
      expect(@registrant_1).to be_a(Registrant)
      expect(@registrant_2).to be_a(Registrant)
      expect(@registrant_3).to be_a(Registrant)
      expect(@facility_1).to be_a(Facility)
      expect(@facility_2).to be_a(Facility)
    end
  end
  
  describe '#Written Test' do  
    it 'starts @registrant_1 with license_data :written as false' do
      expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
      expect(@registrant_1.permit?).to be(true)
      expect(@facility_1.administer_written_test(@registrant_1)).to be(false)
      expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end

    it 'add_service "Written Test" to facility_1' do
      @facility_1.add_service('Written Test')
      expect(@facility_1.services).to eq(['Written Test'])
    end

    it 'administers "Written Test" and updates license_date :written to true for @registrant_1' do
      @facility_1.add_service('Written Test')
      expect(@facility_1.administer_written_test(@registrant_1)).to be(true)
      expect(@registrant_1.license_data).to eq({:written=>true, :license=>false, :renewed=>false})
    end

    it 'starts @registrant_2 with license_data :written as false' do
      expect(@registrant_2.age).to eq(16)
      expect(@registrant_2.permit?).to be(false)
      expect(@facility_1.administer_written_test(@registrant_2)).to be(false)
    end

    it 'has @registrant_2 get thier permit before taking the "Written Test"'do
      @registrant_2.earn_permit
      expect(@registrant_2.permit?).to be(true)
    end

    it 'administers "Written Test" and updates license_date :written to true for @registrant_2' do
      @registrant_2.earn_permit
      expect(@registrant_2.permit?).to be(true)
      @facility_1.add_service('Written Test')
      expect(@facility_1.services).to eq(['Written Test'])
      expect(@facility_1.administer_written_test(@registrant_2)).to be(true)
      expect(@registrant_2.license_data).to eq({:written=>true, :license=>false, :renewed=>false})
    end

    it 'starts @registrant_3 with license_data :written as false' do
      expect(@registrant_3.age).to eq(15)
      expect(@registrant_3.permit?).to be(false)
      expect(@facility_1.administer_written_test(@registrant_3)).to be(false)
    end

    it 'has @registrant_3 get thier permit before taking the "Written Test"' do
      @registrant_3.earn_permit
      expect(@registrant_3.permit?).to be(true)
    end

    it 'administers "Written Test" and DOES NOT updates license_date :written to true for @registrant_3' do
      @registrant_3.earn_permit
      expect(@registrant_3.permit?).to be(true)
      @facility_1.add_service('Written Test')
      expect(@facility_1.services).to eq(['Written Test'])
      expect(@facility_1.administer_written_test(@registrant_3)).to be(false)
      expect(@registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end
  end

  describe '#Road Test' do
    it 'checks if @registrant_3 can take the road test' do
      expect(@facility_1.administer_road_test(@registrant_3)).to be(false)
    end

    it 'has @registrant_3 get their permit then check if they can take the "Road Test"' do
      @registrant_3.earn_permit
      expect(@registrant_3.permit?).to be(true)
      expect(@facility_1.administer_road_test(@registrant_3)).to be(false)
    end

    it 'add_service "Road Test" to @facility_1 and contains "Written Test" service' do
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Road Test')
      expect(@facility_1.services).to eq(['Written Test', 'Road Test'])
    end

    it 'administers "Road Test" for @registrant_1' do
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Road Test')
      expect(@facility_1.services).to eq(['Written Test', 'Road Test'])
      expect(@facility_1.administer_written_test(@registrant_1)).to be(true)
      expect(@facility_1.administer_road_test(@registrant_1)).to be(true)
      expect(@registrant_1.license_data).to eq({:written=>true, :license=>true, :renewed=>false})
    end

    it 'administers "Road Test" for @registrant_2 after they recieve their permit' do
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Road Test')
      expect(@facility_1.services).to eq(['Written Test', 'Road Test'])
      @registrant_2.earn_permit
      expect(@facility_1.administer_written_test(@registrant_2)).to be(true)
      expect(@facility_1.administer_road_test(@registrant_2)).to be(true)
      expect(@registrant_2.license_data).to eq({:written=>true, :license=>true, :renewed=>false})
    end
  end

  describe '#Renew License' do
    it 'starts @registrant_1 with license_data :renewed as false' do
      expect(@facility_1.renew_drivers_license(@registrant_1)).to be(false)
    end

    it 'add_service "Road Test" to @facility_1 and contains "Written Test" and "Renew License" services' do
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Renew License')
      @facility_1.add_service('Road Test')
      expect(@facility_1.services).to eq(['Written Test','Renew License', 'Road Test'])
    end

    it 'renews the driver license for @registrant_1' do
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Renew License')
      @facility_1.add_service('Road Test')
      expect(@facility_1.services).to eq(['Written Test','Renew License', 'Road Test'])
      expect(@facility_1.administer_written_test(@registrant_1)).to be(true)
      expect(@facility_1.administer_road_test(@registrant_1)).to be(true)
      expect(@facility_1.renew_drivers_license(@registrant_1)).to be(true)
      expect(@registrant_1.license_data).to eq({:written=>true, :license=>true, :renewed=>true})
    end

    it 'does not allow @registrant_3 to renew their license' do
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Renew License')
      @facility_1.add_service('Road Test')
      expect(@facility_1.services).to eq(['Written Test','Renew License', 'Road Test'])
      @registrant_3.earn_permit
      expect(@registrant_3.permit?).to be(true)
      expect(@facility_1.administer_written_test(@registrant_3)).to be(false)
      expect(@facility_1.administer_road_test(@registrant_3)).to be(false)
      expect(@facility_1.renew_drivers_license(@registrant_3)).to be(false)
    end

    it 'renews the dirver license for @registrant_2' do
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Renew License')
      @facility_1.add_service('Road Test')
      expect(@facility_1.services).to eq(['Written Test','Renew License', 'Road Test'])
      @registrant_2.earn_permit
      expect(@facility_1.administer_written_test(@registrant_2)).to be(true)
      expect(@facility_1.administer_road_test(@registrant_2)).to be(true)
      expect(@facility_1.renew_drivers_license(@registrant_2)).to be(true)
      expect(@registrant_2.license_data).to eq({:written=>true, :license=>true, :renewed=>true})
    end
  end
end