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
    vehicle.set_registration_date
    if vehicle.antique? == true
      @collected_fees += 25
      vehicle.set_plate_type
    elsif 
      vehicle.electric_vehicle? == true
      @collected_fees +=  200
      vehicle.set_plate_type
    else
      @collected_fees += 100
      vehicle.set_plate_type
    end
      @registered_vehicles << vehicle
  end
end
