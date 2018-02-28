require 'station'

describe Station do

  subject {described_class.new(name: "Aldgate East", zone: 1)}

  describe "station name stored" do
    it "reads the station name" do
    expect(subject.name).to eq("Aldgate East")
  end
end

  describe "station name stored" do
    it "reads the station zone" do
    expect(subject.zone).to eq(1)
  end
end

end
