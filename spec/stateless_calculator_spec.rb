require_relative '../functional/utility'
require_relative '../functional/stateless_calculator'

describe 'StatelessCalculator' do
  include Utility
  include StatelessCalculator

  let(:curry_add) { curry(:add) }

  describe 'Using curry add' do
    it 'correctly adds up the numbers' do
      expect(curry_add.call(2).call(3)).to eq(5)
    end
  end

  describe 'Using the curry to generate an add_2 method' do
    let(:add2) { curry_add.call(2) }
    it 'adds the number to 2' do
      expect(add2.call(3)).to eq(5)
    end

    describe 'Using block call with curry method' do
      def call_by_three(block)
        block.call 3
      end

      it 'calculates correctly' do
        expect(call_by_three(add2)).to eq(5)
      end
    end
  end
end
