# frozen_string_literal: true

# A calculator that holds a state for calculation result
class StatefulCalulator
  def initialize
    @res = 0
  end

  def add(num)
    @res += num
    self
  end

  def minus(num)
    @res -= num
    self
  end

  def mult(num)
    @res *= num
    self
  end

  def div(num)
    @res /= num
    self
  end

  def result
    @res
  end
end
