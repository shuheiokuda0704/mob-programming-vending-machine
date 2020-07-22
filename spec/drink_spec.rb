require 'spec_helper'
require './lib/drink'

RSpec.describe 'Drink' do
  let(:coke) { Drink.new(price: 120, name: "Coke") }

  example "One type of drink which has “price” and “name” attributes can be stored" do
    expect(coke.class).to eq Drink
  end
end
