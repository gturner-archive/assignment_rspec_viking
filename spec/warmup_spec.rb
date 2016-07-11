require 'warmup'

describe Warmup do
  describe '#gets_shout' do
    it "returns user input in upper case" do
      allow(subject).to receive(:gets).and_return("quiet")
      expect(subject.gets_shout).to eq('QUIET')
    end
  end

  describe '#triple_size' do
    it "returns the size of an array times three" do
      object = double(:size=>3)
      expect(subject.triple_size(object)).to eq(9)
    end
  end

  describe "#calls_some_methods" do
    let(:object) do
      str = double("string", empty?: false, reverse!: "0LLEH")
      allow(str).to receive(:upcase!).and_return(str)
      str
    end
    it "calls upcase if it's passed a string" do
      expect(object).to receive("upcase!")
      subject.calls_some_methods(object)
    end
    it "calls reverse if it's passed a string" do
      expect(object).to receive("reverse!")
      subject.calls_some_methods(object)
    end
    it "returns a different object to the one passed in" do
      expect(subject.calls_some_methods(object)).not_to eq(object)
    end

  end







end
