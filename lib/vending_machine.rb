class VendingMachine

  def initialize
    @collected_amount = 0
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
end