class Facility
  attr_reader :name, :address, :phone, :services, :collected_fees, :registered_vehicles
  def initialize(facility_info)
    @name = facility_info[:name]
    @address = facility_info[:address]
    @phone = facility_info[:phone]
    @services = []
    @registration_date = nil
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    if vehicle.antique? == true
      @collected_fees += 25
    elsif 
      vehicle.electric_vehicle? == true
      @collected_fees +=  200
    else
      @collected_fees += 100
    end
    @registered_vehicles << vehicle
  end
end
