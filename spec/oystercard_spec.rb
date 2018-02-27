require 'oystercard'
describe Oystercard do
  subject(:Oystercard) { Oystercard.new }
  let(:fake_station) { double :station }

  describe '#balance' do
    it { is_expected.to respond_to :balance }
    it "has a balance eq to #{Oystercard::ZERO}" do
      expect(subject.balance).to eq Oystercard::ZERO
    end
  end
  describe '#top_up' do
    it 'increase the balance of the card' do
      expect(subject).to respond_to(:top_up).with(Oystercard::ONE).argument
    end
    it 'returns the balance from top_up' do
      expect { subject.top_up Oystercard::ONE }.to change { subject.balance }.by Oystercard::ONE
    end
    it "raises an error message if new balance > #{Oystercard::LIMIT} pounds" do
      expect { subject.top_up(Oystercard::LIMIT + 1) }.to raise_error 'Sorry the new balance would exceed the limit!'
    end
  end

  describe '#touch_in' do
    it "raises an error message if balance is less than #{Oystercard::ONE} pound" do
      expect(subject.balance).to be < Oystercard::ONE
      expect { subject.touch_in(fake_station) }.to raise_error(RuntimeError)
    end
    it 'the card has touched in' do
      subject.top_up(Oystercard::ONE)
      expect(subject.touch_in(fake_station)).to eq fake_station
    end
    it 'remembers touch in station' do
      subject.top_up(Oystercard::ONE)
      subject.touch_in(fake_station)
      expect(subject.entry_station).to eq fake_station
    end
  end

  describe '#touch_out' do
    it "deducts #{Oystercard::FARE} from the card when touched out" do
      subject.top_up(Oystercard::ONE)
      expect { subject.touch_out(fake_station) }.to change { subject.balance }.by(-Oystercard::FARE)
    end
    it 'the card has touched out' do
      expect(subject.touch_out(fake_station)).to eq fake_station
    end
    it 'forgets the entry station' do
      subject.touch_out(fake_station)
      expect(subject.exit_station).to eq fake_station
    end
  end

  describe '#in_journey?' do
    it 'the card has touched in and not touched out yet' do
      expect(subject.in_journey?(fake_station)).to eq fake_station
    end
  end
end
