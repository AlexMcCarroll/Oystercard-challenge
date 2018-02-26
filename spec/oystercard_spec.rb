require 'oystercard'
describe Oystercard do

  describe '#balance' do
    it {is_expected.to respond_to :balance}
    it 'has a balance eq to 0' do
      expect(subject.balance).to eq 0
    end
  end

end
