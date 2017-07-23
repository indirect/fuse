require "threaded_memoize"

test_class = Class.new do
  include ThreadedMemoize

  def only_once
    threaded_memoize(expires_in: 60) do
      @called ? raise("oh no") : true
      @called = true
    end
  end

  def second
    threaded_memoize(expires_in: 60) { Time.now.sec }
  end

end

RSpec.describe ThreadedMemoize do
  subject { test_class.new }

  it "caches the result of calling the block" do
    expect(subject.only_once).to eq(subject.only_once)
  end

  it "calls the block again after the given number of seconds pass" do
    allow(Time).to receive(:now).and_return(Time.parse("2017-07-22T20:15:52-07:00"))
    expect(subject.second).to eq(52)

    allow(Time).to receive(:now).and_return(Time.parse("2017-07-22T20:35:10-07:00"))
    expect(subject.second).to eq(10)
  end
end