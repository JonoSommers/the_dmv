class VehicleFactory
    attr_reader :vehicles_made

    def initialize
        @vehicles_made = []
    end

    def create_vehicles(wa_ev_registrations)
        wa_ev_registrations.each do |vehicle|
            new_vehicle = Vehicle.new(vehicle)
            @vehicles_made << new_vehicle
        end
    end
end