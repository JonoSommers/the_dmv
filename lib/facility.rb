class Facility
  attr_reader :name, :address, :phone, :services, :collected_fees, :registered_vehicles
  def initialize(facility_info)
    @name = facility_info[:name] || facility_info[:dmv_office]
    @address = facility_info[:address] || "#{facility_info[:address_li]}, #{facility_info[:address__1]}"
    @phone = facility_info[:phone]
    @services = facility_info[:services_p] || []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    if @services.include?('Vehicle Registration')
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
      @registered_vehicles << vehicle
    else
      return nil
    end
  end

  def administer_written_test(registrant)
    unless @services.include?('Written Test')
      return false
    else
      registrant.take_written_test
    end
  end
  
  def administer_road_test(registrant)
    unless @services.include?('Road Test')
      return false
    else
      registrant.take_road_test
    end
  end

  def renew_drivers_license(registrant)
    unless @services.include?('Renew License')
      return false
    else
      registrant.renew_license
    end
  end

end

