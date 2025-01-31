class Registrant
    attr_reader :name, :age, :permit, :license_data

    def initialize(name, age, permit = false)
        @name = name
        @age = age
        @permit = permit
        @license_data = {:written=>false, :license=>false, :renewed=>false}
    end

    def permit?
        @permit
    end

    def earn_permit
        @permit = true
    end

    def take_written_test
        if @age >= 16 && @permit == true
            @license_data[:written] = true
        else
            @license_data[:written] = false
        end
    end

    def take_road_test
        if @license_data[:written] == true
            @license_data[:license] = true
        else
            @license_data[:license] = false
        end
    end

    def renew_license
        if @license_data[:written] == true && @license_data[:license] == true
            @license_data[:renewed] = true
        else
            @license_data[:renewed] = false
        end
    end
end