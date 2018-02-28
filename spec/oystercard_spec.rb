require 'oystercard'
describe Oystercard do
  subject(:Oystercard) { Oystercard.new }
  let(:fake_station) { double :station }
  limit = Oystercard::LIMIT
  fare = Oystercard::FARE

  describe '#balance' do
    it "has a balance eq to 0" do
      expect(subject.balance).to eq 0
    end
  end
  describe '#top_up' do
    it 'returns the balance from top_up' do
      expect { subject.top_up(1) }.to change { subject.balance }.by 1
    end
    it "raises an error message if new balance > #{limit} pounds" do
      expect { subject.top_up(limit + 1) }.to raise_error 'Sorry the new balance would exceed the limit!'
    end
  end

  describe '#touch_in' do
    it "raises an error message if balance is less than #{1} pound" do
      expect(subject.balance).to be < fare
      expect { subject.touch_in(fake_station) }.to raise_error(RuntimeError)
    end
    it 'the card has touched in' do
      subject.top_up(fare)
      expect(subject.touch_in(fake_station)).to eq fake_station
    end
    it 'remembers touch in station' do
      subject.top_up(fare)
      subject.touch_in(fake_station)
      expect(subject.entry_station).to eq fake_station
    end
  end

  describe '#touch_out' do
    it "deducts #{fare} from the card when touched out" do
      subject.top_up(fare)
      expect { subject.touch_out(fake_station) }.to change { subject.balance }.by(-fare)
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
      subject.top_up(fare)
      subject.touch_in(fake_station)
      expect(subject.in_journey?).to eq true
    end
  end
end
