# Your code here

require 'weapons/bow'

describe Bow do
  let(:bow){Bow.new}

  describe "#initialize" do
    it "should have a arrows method" do
      expect(bow.arrows).to be_a(Fixnum)
    end

    it "should return 10 arrows by default" do
      expect(bow.arrows).to eq(10)
    end

    it "should allow me to set the number of arrows" do
      bow_2 = Bow.new(15)
      expect(bow_2.arrows).to eq(15)
    end
  end

  describe "#use" do
    it "reduces the count of arrows by 1" do
      bow_arrows = bow.arrows
      bow.use
      expect(bow.arrows).to eq(bow_arrows - 1)
    end

    it "raises error if no arrows are left" do
      empty_shooter = Bow.new(0)
      expect{empty_shooter.use}.to raise_error('Out of arrows')
    end
  end
end
