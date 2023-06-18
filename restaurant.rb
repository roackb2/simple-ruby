# Clerk module implements method to take order and deliver order
module Clerk
  def take_order(dish_name)
    puts "The clerk has received an order for #{dish_name}"

    handle_order(dish_name)
  end

  def deliver_order(dish_name)
    puts "The clerk is delivering dish #{dish_name}"
  end
end

# Chef module implements method to cook the dish
module Chef
  def cook(dish_name)
    puts "The chef started to cook #{dish_name}"

    handle_dish_cooked(dish_name)
  end
end

# A restaurant greets a customer, call Clerk to take the order,
# handle the order to cook when clerk finish taking order,
# then handle the dish to clerk for delivering after cook finish cooking.
class Restaurant
  include Clerk
  include Chef

  def greet(customer)
    puts "Hi customer #{customer}, what do you want to order?"

    dish_name = gets.chomp

    take_order(dish_name)
  end

  def handle_order(dish_name)
    cook(dish_name)
  end

  def handle_dish_cooked(dish_name)
    deliver_order(dish_name)
  end
end
