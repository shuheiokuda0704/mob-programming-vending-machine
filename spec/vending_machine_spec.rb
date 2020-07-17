require 'spec_helper'
require './lib/vending_machine'

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
    expect(vending_machine.insert_money(10)).to be true
  end

  example "cannot insert other than 10, 50, 100, 500 coins and 1000 yen bills" do
    expect(vending_machine.insert_money(1)).to be false
  end
end