class Facility
  attr_reader :name, :address, :phone, :services, :collected_fees, :registered_vehicles
  def initialize(facility_info)
    @name = facility_info[:name]
    @address = facility_info[:address]
    @phone = facility_info[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    unless @services.include?('Vehicle Registration')
      return nil
    else
      if vehicle.antique?
        @collected_fees += 25
        vehicle.set_plate_type
        vehicle.set_registration_date
      elsif 
        vehicle.electric_vehicle?
        @collected_fees +=  200
        vehicle.set_plate_type
        vehicle.set_registration_date
      else
        @collected_fees += 100
        vehicle.set_plate_type
        vehicle.set_registration_date
      end
    end
    @registered_vehicles << vehicle
  end

  def administer_written_test(registrant)
    unless @services.include?('Written Test')
      return false
    else
      registrant.take_written_test
    end
  end
end

