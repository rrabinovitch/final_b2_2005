require 'rails_helper'

RSpec.describe Airline do
  describe 'relationships' do
    it {should have_many :flights}
  end
end
