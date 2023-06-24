require_relative '../functional/utility'
require_relative '../functional/stateless_calculator'

describe 'StatelessCalculator' do
  include Utility
  include StatelessCalculator

  let(:curry_add) { curry(:add) }

  describe 'using curry add' do
    it 'correctly adds up the numbers' do
      expect(curry_add.call(2).call(3)).to eq(5)
    end
  end

  describe 'using the curry to generate an add_2 method' do
    let(:add2) { curry_add.call(2) }
    it 'adds the number to 2' do
      expect(add2.call(3)).to eq(5)
    end

    describe 'using block call with curry method' do
      def call_by_three(&block)
        block.call 3
      end

      it 'calculates correctly' do
        expect(call_by_three(&add2)).to eq(5)
      end
    end

    describe 'currying with array map' do
      let(:nums) { [1, 3, 5, 8, 11] }

      describe 'ussing curried add lambda with 5 on array map' do
        let(:expected) { [6, 8, 10, 13, 16] }
        it 'add all numbers with the called lambda function' do
          expect(nums.map(&curry_add.call(5))).to eq(expected)
        end
      end

      describe 'passing the add2 lambda to array map' do
        let(:expected) { [3, 5, 7, 10, 13] }
        it 'add all numbers with 2' do
          expect(nums.map(&add2)).to eq(expected)
        end
      end
    end
  end
end
