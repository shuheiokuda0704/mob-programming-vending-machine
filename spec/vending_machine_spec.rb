require 'spec_helper'
require './lib/vending_machine'

RSpec.describe 'Vending Machine' do
  example "test" do
  end

  example "should be of ruby version 2.6.3" do
    expect(RUBY_VERSION).to eq "2.6.3"
  end

  example "vending machine should be initialised" do
    vending_machine = VendingMachine.new
    expect(vending_machine.class).to eq VendingMachine
  end
end