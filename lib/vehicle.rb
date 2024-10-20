require 'date'

class Vehicle
  attr_reader :vin,
              :year,
              :make,
              :model,
              :engine,
              :plate_type,
              :registration_date

  def initialize(vehicle_details)
    @vin = vehicle_details[:vin] || vehicle_details[:vin_1_10]
    @year = vehicle_details[:year] || vehicle_details[:model_year]
    @make = vehicle_details[:make]
    @model = vehicle_details[:model]
    @engine = vehicle_details[:engine] || :ev 
    @registration_date = nil
    @plate_type = nil || :ev
  end

  def set_registration_date
    @registration_date = Date.today
  end

  def set_plate_type
    if antique? == true
      @plate_type = :antique
    elsif electric_vehicle? == true
      @plate_type = :ev
    else
      @plate_type = :regular
    end
  end

  def antique?
    Date.today.year - @year > 25
  end

  def electric_vehicle?
    @engine == :ev
  end
end
