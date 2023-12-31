#!/usr/bin/ruby -w

$LOAD_PATH << '.'

# fronzen_string_literal: true

require 'customer'
require 'restaurant'
require 'functional/utility'
require 'functional/stateful_calculator'
require 'functional/stateless_calculator'

include Utility
include StatelessCalculator

puts 'hello world'

BEGIN {
  puts 'This will be print before others'
}

END {
  puts "End of program"
}

puts <<EOF
 This is a short paragraph
 containing multiple lines
 to demonstrate here document
EOF

=begin
This is a comment
that could span across multiple lines
and is suitable for long documentaiton
like function description
or parameter types
=end

puts 'something after the comment'

cust1 = Customer.new 'Alice'

puts cust1

puts "name of cust1: #{cust1.name}"

cust1.update_name 'Bob'

puts "name of cust1: #{cust1.name}"

cust2 = Customer.new 'John'

puts Customer.customer_count

puts Customer.class_name

puts "we're executing file #{__FILE__}"

puts "This is line #{__LINE__}"

puts "Is 1234 a Fixnum? #{1234.is_a?(Fixnum)}"

puts "Is 1234567890 a Bignum? #{1_234_567_890.is_a?(Bignum)}"

puts "Is \"hello\" a String? #{'hello'.is_a?(String)}"

nums = [
  1234,
  1_234,
  0377,
  0xff,
  0b1011,
  1234567890,
  1.278e6,
  12.5E3
]

nums.each { |n| puts n }

my_info = {
  first_name: 'Jay',
  last_name: 'Liang',
  location: 'TW'
}

puts "My info: #{my_info}"
my_info.each do |k, v|
  puts "My #{k} is #{v}"
end

inclusive_range = (1..5)
exclusive_range = (1...5)

puts "An inclusive range for (1..5): #{inclusive_range.map { |v| v }}"
puts "An exclusive range for (1...5): #{exclusive_range.map { |v| v }}"

foo = 1

puts "Is foo defined? #{defined? foo}"
puts "Is puts defined? #{defined? puts}"
puts "Is bar defined? #{defined? bar}"
puts "Is yield defined? #{defined? yield}"

def test_block(arg)
  puts 'This is the test_block function'
  return unless block_given?

  puts "Is yield defined in a block? #{defined? yield}"
  yield arg
end

test_block('hello') do |v|
  puts "The passed in value is #{v}"
end

def echo_value(val)
  puts "The passed in value is #{val}"
end

test_block('hello') { |v| echo_value v }

echo_value_proc = proc { |v| puts "The value passed in the proc is #{v}" }

test_block('hello', &echo_value_proc)

echo_value_lambda = ->(v) { puts "The value passed in the lambda function is #{v}" }

test_block('hello', &echo_value_lambda)

def test_block_call(arg, block)
  puts 'Using block.call'
  block.call arg
end

test_block_call('hello', echo_value_proc)

test_block_call('hello', echo_value_lambda)

def test_multi_block_call(args, blocks)
  raise 'Number of args and blocks not match' if args.size != blocks.size

  puts 'Calling each block'
  blocks.each_with_index do |block, i|
    block.call args[i]
  end
end

test_multi_block_call(%w[hello world], [echo_value_proc, echo_value_lambda])

alice_age = 5

def tell_age(age)
  child_age = [0..2]
  youth_age = [3..6]
  teanage = [7..11]

  case age
  when *child_age
    puts 'Alice is child'
  when *youth_age
    puts 'Alice is youth'
  when *teanage
    puts 'Alice is teanage'
  else
    puts 'Alice is grown up'
  end
end

tell_age(alice_age)

def read_input
  puts 'Please type some characters. Type "end" to exit.'
  input = ''
  while input != 'end'
    input = gets.chomp
    puts "You just typed #{input}"
  end
end

alias print_age tell_age

def tell_age
  puts 'Here we modified the method defonition of "tell_age"'
end

print_age(2)

calculator = StatefulCalulator.new

res = calculator.add(3).add(5).minus(2).mult(4).div(2).result

puts "result for a stateful calculator is #{res}"

# Note that the curry method takes arity of the given function
curry_add = curry(:add)

puts "The curry_add function: #{curry_add}"

add2 = curry_add.call(2)

puts "The add2 function: #{add2}"

puts "Adding 2 & 3 using curry: #{curry_add.call(2).call(3)}"

puts "Adding 3 to the method 'add2': #{add2.call(3)}"

# The '&' in function parameter turns given block into a Proc
def call_by_three(&block)
  block.call 3
end

# The '&' before 'add2' converts a Proc into a block
puts "Composing block call with curry method call_by_three add2: #{call_by_three(&add2)}"

# Using brackets means that we take the original method and return a new method with first argument being 5
add5_curry = method(:add).curry[5]

puts "Calling a returned function with 3 by preloading :add method with first argument being 5: #{add5_curry.call(3)}"

nums = [2, 3, 5, 8, 9]

nums_added_two = nums.map(&add2)

nums_added_three = nums.map(&curry_add.call(3)) # equivalent to nums.map(&curry_add.(3))

puts "Add all values of #{nums} with nums.map(&add2): #{nums_added_two}"

puts "Add all values of #{nums} with nums.map(&curry_add.call(3)): #{nums_added_three}"

add_and_multiply = ->(x, y, z) { (x + y) * z }
multiply_and_pow = ->(x, y, z) { (x * y)**z }

puts "Arity of add_and_multiply: #{add_and_multiply.arity}"
puts "Arity of multiply_and_pow: #{multiply_and_pow.arity}"

# A lambda function that takes a lambda function with arity of 3 and return a lambda function with arity of 2
arity_three_called_with_last_as_two = ->(block) { ->(var1, var2) { block.call(var1, var2, 2) } }

puts "Add 3 & 5, then multiply with 2: #{arity_three_called_with_last_as_two.call(add_and_multiply).call(3, 5)}"
puts "Multiply 3 with 5, then power to 2: #{arity_three_called_with_last_as_two.call(multiply_and_pow).call(3, 5)}"

restaurant = Restaurant.new
restaurant.greet('John Wick')

# Examples with arrays
arr = Array.new(20)
puts "An array at length of 20 #{arr}"

names = Array.new(4, 'John')
puts "An array of 4 Johns #{names}"

pows = Array.new(10) { |i| i ** 2 }
puts "An array created using block #{pows}"

digits = Array(0..10)
puts "An array created with range #{digits}"

# Hash examples
hs = Hash.new 'default'
puts "An hash created with a default value 'default', accessing a random key: #{hs[123]}"

# Time examples
now = Time.new
puts "Now is #{now}"

july9local = Time.local(2023, 7, 9)
puts "July 9 at local time: #{july9local}"

july9utc = Time.utc(2023, 7, 9)
puts "July 9 GTC: #{july9utc}"

puts "My timezone is #{now.zone}"
puts "My UTC offest in seconds: #{now.utc_offset}"

# Ranges
num_range = (1..10)
puts "Numeric ranges: #{num_range.to_a}"
char_range = ('a'..'z')
puts "Alphabet range: #{char_range.to_a}"
puts "is 6 included in num_range: #{num_range.include?(6)}"
puts "min and max in num_range: #{num_range.min}, #{num_range.max}"
puts "Is 6 in num_range using equality test: #{num_range === 6}"

# Files
file_path = 'output/test.txt'
new_file_name = 'output/renamed.txt'

File.open(file_path, 'w') do |file|
  paragraph1 = 'This should be written to the file'
  paragraph2 = 'This is the second line'
  puts 'Writing content to the file'
  file.puts(paragraph1)
  file.puts(paragraph2)
end

File.open(file_path, 'r') do |file|
  puts 'Is there any content in the file?'
  content = file.sysread(100)
  puts "Content in the file: #{content}"
end

puts 'Printing file content using IO.foreach'
IO.foreach(file_path) { |line| puts line }

puts "Renaming #{file_path} to #{new_file_name}"
File.rename(file_path, new_file_name)

puts "Deleting #{new_file_name}"
File.delete(new_file_name)

puts "Does the file still exists after removal? #{File.exist?(new_file_name)}"
