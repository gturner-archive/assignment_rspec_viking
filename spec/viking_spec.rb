require "viking"

describe Viking do
  let(:vik){Viking.new}
  describe "#initialize" do
    it "allows setting viking name" do
      tom = Viking.new("Tom")
      expect(tom.name).to eq("Tom")
    end

    it "allows setting viking health" do
      tom =  Viking.new("Tom", 90)
      expect(tom.health).to eq(90)
    end

    it "does not allow you to set health after initialize" do
      expect{vik.health = 100}.to raise_error(NoMethodError)
    end

    it "initilizes viking weapon to nil" do
      expect(vik.weapon).to eq(nil)
    end
  end

  describe "#pick_up_weapon" do
    let(:fake_wep) do
      double(is_a?: Weapon)
    end
    it "sets the vikings weapons" do
      vik.pick_up_weapon(fake_wep)
      expect(vik.weapon).to eq(fake_wep)
    end

    it "raises an hour if argument is not a weapon" do
      expect{vik.pick_up_weapon("String")}.to raise_error(RuntimeError)
    end

    it "replaces the viking's current weapon" do
      replacement = double(is_a?: Weapon)
      vik.pick_up_weapon(fake_wep)
      vik.pick_up_weapon(replacement)
      expect(vik.weapon).to eq(replacement)
    end
  end

  describe "#drop_weapon" do
    let(:fake_wep) do
      double(is_a?: Weapon)
    end
    it "sets viking weapon to nil" do
      vik.instance_variable_set(:@weapon, fake_wep)
      vik.drop_weapon
      expect(vik.weapon).to be_nil
    end
  end

  describe "#receive_attack" do
    it "reduces health by a set amount" do
      start = vik.health
      vik.receive_attack(10)
      expect(vik.health).to eq(start - 10)
    end

    it "calls the take_damage method" do
      expect(vik).to receive(:take_damage)
      vik.receive_attack(10)
    end
  end

  describe "#attack" do
    let(:viki){Viking.new}

    it "causes the recipients health to drop" do
      vik.attack(viki)
      expect(viki.health).to be <100
    end

    it "calls take_damage on target" do
      allow(viki).to receive(:take_damage).with(10)
      expect(viki).to receive(:take_damage)
      vik.attack(viki)
    end

    it "calls damage_with_fists if no weapon" do
      expect(vik).to receive(:damage_with_fists).and_return(10)
      vik.attack(viki)
    end

    it "attacking with no weapon deals fist multiplier damage" do
      fist = Fists.new
      attack = fist.use * vik.strength
      vik.attack(viki)
      expect(viki.health).to be(100 - attack)
    end

    it "runs damage with weapon when a weapon is used" do
      sven = Viking.new("sven", 100, 10, Weapon.new('weapon'))
      expect(sven).to receive(:damage_with_weapon).and_return(10)
      sven.attack(viki)
    end

    it "attacking with a weapon deals weapon multiplier damage" do
      sven = Viking.new("sven", 100, 10, Weapon.new('weapon'))
      attack = sven.weapon.use * sven.strength
      sven.attack(viki)
      expect(viki.health).to be(100 - attack)
    end

    it "uses fists if bow is weapon and has no arrows" do
      sven = Viking.new("sven", 100, 10, Bow.new(0))
      expect(sven).to receive(:damage_with_fists).and_return(2.5)
      sven.attack(viki)

    end

    it "raises an error when a viking is killed" do
      sven = Viking.new("sven", 1)
      expect{vik.attack(sven)}.to raise_error(RuntimeError)

    end
  end
end
