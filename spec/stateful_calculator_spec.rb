# frozen_string_literal: true

require_relative '../functional/stateful_calculator'

describe 'StatefulCalulator' do
  # using before(:all) would fail since our calculator is stateful
  before(:each) do
    @subject = StatefulCalulator.new
  end

  it 'calculates result correctly' do
    expect(@subject.add(3).add(5).mult(4).div(8).result).to eq(4)
  end

  it 'doing simple addings correctly' do
    expect(@subject.add(2).add(3).add(5).result).to eq(10)
  end
end
