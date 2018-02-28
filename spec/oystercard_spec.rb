require 'oystercard'
describe Oystercard do
  let(:fake_station) { double :station }
  let(:fake_station2) { double :station2 }
  limit = Oystercard::LIMIT
  fare = Oystercard::FARE

  describe '#balance' do
    it "has a balance eq to 0" do
      expect(subject.balance).to eq 0
    end
  end
  describe '#journey_history' do
    it "has an empty array" do
      expect(subject.journey_history).to eq []
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
    it "raises an error message if balance is less than 1 pound" do
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
      expect { subject.touch_out(fake_station2) }.to change { subject.balance }.by(-fare)
    end
    it "stores hash in journey_history array" do
      subject.top_up(fare)
      subject.touch_in(fake_station)
      subject.touch_out(fake_station2)
      expect(subject.journey_history[0][:entry]).to eq fake_station
      expect(subject.journey_history[0][:exit]).to eq fake_station2
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
