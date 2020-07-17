class VendingMachine

  def initialize
    @collected_amount = 0
  end

  def insert_money(amount)
    return unless [10, 50, 100, 500, 1000].include?(amount)
    @collected_amount += amount
    true
  end

  def collected_amount
    @collected_amount
  end
end