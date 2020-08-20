require 'spec_helper'
require './lib/vending_machine'
require './lib/drink'
require 'byebug'

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
    expect(vending_machine.store(coke, 5)).to eq(true)
  end

  example "can get information of stored drinks" do
    # store 5 cokes
    coke = Drink.new(price: 120, name: "coke")
    vending_machine.store(coke, 5)
    # get info
    expect(vending_machine.stored_drinks).to eq({:coke=>{:price=>120, :count=>5}})
  end

  example "whether Coke can be purchased with inserted money " do
    coke = Drink.new(price: 120, name: "coke")
    vending_machine.store(coke, 1)
    expect(vending_machine.insert_money(10))
    expect(vending_machine.insert_money(10))
    expect(vending_machine.insert_money(100))
    expect(vending_machine.purchase_drink(coke)).to eq(coke)
    expect(vending_machine.collected_amount).to eq(0)
    expect(vending_machine.sales_amount).to eq(120)
  end

  example "whether Coke cannot be purchased without sufficient money" do
    coke = Drink.new(price: 120, name: "coke")
    vending_machine.store(coke, 1)
    expect(vending_machine.insert_money(10))
    expect(vending_machine.insert_money(10))
    expect(vending_machine.purchase_drink(coke)).to eq(false)
    expect(vending_machine.collected_amount).to eq(20)
    expect(vending_machine.sales_amount).to eq(0)
  end

  example "purchase is executed when Coke can be purchased, reduce stock of Coke and increase sales amount" do
    coke = Drink.new(price: 120, name: "coke")
    vending_machine.store(coke, 5)
    vending_machine.insert_money(100)
    vending_machine.insert_money(10)
    vending_machine.insert_money(10)
    expect(vending_machine.purchase_drink(coke)).to eq(coke)
    expect(vending_machine.sales_amount).to eq(120)
    expect(vending_machine.stored_drinks[:coke][:count]).to eq(4)
  end

  example "When Coke cannot be purchased, stock of Coke is not reduced and sales amount donot change" do
    coke = Drink.new(price: 120, name: "coke")
    vending_machine.store(coke, 5)
    vending_machine.insert_money(100)
    expect(vending_machine.purchase_drink(coke)).to eq(false)
    expect(vending_machine.sales_amount).to eq(0)
    expect(vending_machine.stored_drinks[:coke][:count]).to eq(5)
  end

  # TODO: confirm later
  example "purchase is executed when Coke can NOT be purchased, do nothing" do
    coke = Drink.new(price: 120, name: "coke")
    vending_machine.store(coke, 0)
    vending_machine.insert_money(500)
    expect(vending_machine.purchase_drink(coke)).to eq(false)
    expect(vending_machine.sales_amount).to eq(0)
  end

  example "Can get current sales amount" do
    coke = Drink.new(price: 120, name: "coke")
    vending_machine.store(coke, 10)
    vending_machine.insert_money(1000)
    5.times do
      expect(vending_machine.purchase_drink(coke)).to eq(coke)
    end
    expect(vending_machine.sales_amount).to eq(600)
  end

  example "Can get current sales amount when insufficient balance" do
    coke = Drink.new(price: 120, name: "coke")
    vending_machine.store(coke, 10)
    vending_machine.insert_money(500)
    4.times do
      expect(vending_machine.purchase_drink(coke)).to eq(coke)
    end
    expect(vending_machine.purchase_drink(coke)).to eq(false)
    expect(vending_machine.sales_amount).to eq(480)
  end

  example "refund is executed, refund money" do
    coke = Drink.new(price: 120, name: "coke")
    vending_machine.store(coke, 10)
    vending_machine.insert_money(500)
    4.times do
      expect(vending_machine.purchase_drink(coke)).to eq(coke)
    end
    expect(vending_machine.refund).to eq(20)
  end

  example "refund is 0 when purchased for full amount" do
    coke = Drink.new(price: 120, name: "coke")
    vending_machine.store(coke, 10)
    vending_machine.insert_money(500)
    vending_machine.insert_money(100)
    5.times do
      expect(vending_machine.purchase_drink(coke)).to eq(coke)
    end
    expect(vending_machine.refund).to eq(0)
  end

end