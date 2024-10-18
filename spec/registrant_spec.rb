require 'spec_helper'

RSpec.describe Registrant do
    describe '#initialize' do
        it 'exists' do
            registrant_1 = Registrant.new('Bruce', 18, true )
            registrant_2 = Registrant.new('Penny', 15 )

            registrant = Registrant.new(registrant_1, registrant_2)

            expect(registrant_1).to be_a(Registrant)
            expect(registrant_2).to be_a(Registrant)
        end

        it 'has attributes' do
            registrant_1 = Registrant.new('Bruce', 18, true )
            registrant_2 = Registrant.new('Penny', 15 )

            expect(registrant_1.name).to eq("Bruce")
            expect(registrant_1.age).to eq(18)
            expect(registrant_1.permit?).to be(true)
            expect(registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
            expect(registrant_2.name).to eq("Penny")
            expect(registrant_2.age).to eq(15)
            expect(registrant_2.permit?).to be(false)
            expect(registrant_2.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
        end
    end

    describe '#earn_permit' do
        it 'changes registrant permit status from false to true after permit is earned' do
            registrant_1 = Registrant.new('Bruce', 18, true )
            registrant_2 = Registrant.new('Penny', 15 )

            registrant_2.earn_permit

            expect(registrant_2.permit?).to be(true)
        end
    end
end