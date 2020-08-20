class VendingMachine

  def initialize
    @collected_amount = 0
    @sales_amount = 0
    @stock = Hash.new
  end

  def insert_money(amount)
    return amount unless [10, 50, 100, 500, 1000].include?(amount)
    @collected_amount += amount
    0
  end

  def collected_amount
    @collected_amount
  end

  def refund
    @collected_amount.tap { @collected_amount = 0 }
  end

  def store(drink, count)
    @stock[drink.name.to_sym] = {price: drink.price, count: count}
    true
  end

  def stored_drinks
    @stock
  end

  def purchase_drink(drink)
    return false if (@collected_amount < drink.price) || (@stock[drink.name.to_sym][:count] == 0)
    @stock[drink.name.to_sym][:count] -= 1
    @collected_amount -= drink.price
    @sales_amount += drink.price
    drink
  end

  def sales_amount
    @sales_amount
  end
end