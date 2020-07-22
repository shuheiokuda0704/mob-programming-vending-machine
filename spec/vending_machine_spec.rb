require 'spec_helper'
require './lib/vending_machine'
require './lib/drink'

RSpec.describe 'Vending Machine' do
  example "test" do
  end

  example "should be of ruby version 2.6.3" do
    expect(RUBY_VERSION).to eq "2.6.3"
  end

  let(:vending_machine){ VendingMachine.new }

  example "vending machine should be initialised" do
    expect(vending_machine.class).to eq VendingMachine
  end

  example "can insert 10, 50, 100, 500 coins and 1000 yen bills" do
    expect(vending_machine.insert_money(10)).to be 0
  end

  example "cannot insert other than 10, 50, 100, 500 coins and 1000 yen bills" do
    expect(vending_machine.insert_money(1)).to be 1
  end

  example "can insert money multiple times" do
    10.times do
      expect(vending_machine.insert_money(10)).to be 0
    end
  end

  example "can get total amount of inserted money" do
    10.times do
      vending_machine.insert_money(10)
    end
    expect(vending_machine.collected_amount).to eq(100)
  end

  example "can refund collected amount" do
    10.times do
      vending_machine.insert_money(10)
    end
    expect(vending_machine.collected_amount).to eq(100)
    expect(vending_machine.refund).to eq(100)
    expect(vending_machine.collected_amount).to eq(0)
  end

  example "1, 5, 10000 not be added to the total money and refund it to user" do
    [1, 5, 10000].each do |money|
      expect(vending_machine.insert_money(money)).to eq(money)
      expect(vending_machine.refund).to eq(0)
    end
  end

  example "store 5 Cokes" do
    coke = Drink.new(price: 120, name: "Coke")
    vending_machine.store(coke, 5)
  end

end