require 'yack'
require 'minitest/spec'
require 'minitest/autorun'

describe Yack::Callback do
  before :each do
    @yack = Yack::Callback.new
    @mock = MiniTest::Mock.new
  end

  after :each do
    @mock.verify
  end

  it "should call root callbacks correctly" do
    @mock.expect(:call, nil, [2])
    @yack.something do |value|
      @mock.call value
    end
    @yack.process({:something  => 2})
  end

  it "should call nested callbacks correctly" do
    @mock.expect(:call, nil, [2])
    @yack.something.test do |value|
      @mock.call value
    end
    @yack.process({:something  => {:test => 2}})
  end

  it "should not change anything if callback not defined" do
    @yack.process({:something  => {:test => 2}})
  end

  it "should callback with hash" do
    result = {:test => 2}
    @mock.expect(:call, nil, [{:test => 2}])
    @yack.something do |value|
      @mock.call value
    end
    @yack.process({:something => result})
  end

  it "should not overwrite nested callbacks" do
    @mock.expect(:call, nil, [2])
    @mock.expect(:call, nil, [3])
    @yack.something.test1 do |value|
      @mock.call value
    end
    @yack.something.test2 do |value|
      @mock.call value
    end
    @yack.process({:something => {:test1 => 2, :test2 => 3}})
  end

  it "should call several root level elements" do
    @mock.expect(:call, nil, [2])
    @yack.something do |value|
      @mock.call value
    end
    @mock.expect(:call, nil, [3])
    @yack.else do|value|
      @mock.call value
    end
    @yack.process({:something  => 2, :else => 3})
  end
end