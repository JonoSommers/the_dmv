class Facility
  attr_reader :name, :address, :phone, :services, :collected_fees, :registered_vehicles
  def initialize(facility_info)
    @name = facility_info[:name] || facility_info[:dmv_office] || facility_info[:office_name]
    @address = facility_info[:address] || 
      facility_info[:address1] ||
      facility_info[:street_address_line_1] || 
      "#{facility_info[:address_li]}, #{facility_info[:address__1]} #{facility_info[:location]}"
    @phone = facility_info[:phone] || facility_info[:public_phone_number]
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
    if @services.include?('Written Test')
      registrant.take_written_test
    else
      false
    end
  end
  
  def administer_road_test(registrant)
    if @services.include?('Road Test')
      registrant.take_road_test
    else
      false
    end
  end

  def renew_drivers_license(registrant)
    if @services.include?('Renew License')
      registrant.renew_license
    else
      false
    end
  end

end

