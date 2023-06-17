class Customer
  CLS_NAME = 'Customer'
  @@no_customers = 0

  @customer_name = ''

  def initialize(name = '')
    @customer_name = name
    @@no_customers += 1
  end

  def name
    @customer_name
  end

  def update_name(name)
    @customer_name = name
  end

  def self.class_name
    CLS_NAME
  end

  def self.customer_count
    puts "There are #{@@no_customers} customers"
  end
end
