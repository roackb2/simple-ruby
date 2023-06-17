# fronzen_string_literal: true

#!/usr/bin/ruby -w

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

puts "Is 1234567890 a Bignum? #{1234567890.is_a?(Bignum)}"

puts "Is \"hello\" a String? #{"hello".is_a?(String)}"

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
