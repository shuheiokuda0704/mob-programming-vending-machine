class Drink
  attr_accessor :price, :name
  def initialize(price: p, name: n)
    @price = price
    @name = name
  end
end