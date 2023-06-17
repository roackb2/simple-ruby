#!/usr/bin/ruby -w

# fronzen_string_literal: true

require './customer'

puts 'hello world'

BEGIN {
  puts 'This will be print before others'
}

END {
  puts 'This will be print right before program ends'
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
