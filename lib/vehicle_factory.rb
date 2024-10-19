class VehicleFactory

    def initialize
        @created_vehicles = []
    end

    def create_vehilces(wa_ev_registrations)
        wa_ev_registrations.each do |vehicle|
            new_vehicle = Vehicle.new(vehicle)
            @created_vehicles << new_vehicle
        end
    end
end