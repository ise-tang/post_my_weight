require 'rails_helper'

RSpec.describe Weight, :type => :model do
  before { @weight = Weight.new(weight: 80) }

  subject { @weight }

  describe "存在しなければならない" do
    before { @weight.weight = "" } 
    it { should_not be_valid  }
  end

  describe "0より大きくなければならない" do
    before { @weight.weight = 0 }
    it { should_not be_valid }
  end
end
