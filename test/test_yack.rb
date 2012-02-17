require 'yack'
require 'yaml'
require 'minitest/spec'
require 'minitest/autorun'

describe Yack::Callback do
  before :each do
    @yack = Yack::Callback.new
  end

  it "should call root callbacks correctly" do
    test = 1
    @yack.something do |value|
      test = value
    end
    @yack.process_yaml({:something  => 2}.to_yaml)
    test.must_equal 2
  end

  it "should call nested callbacks correctly" do
    test = 1
    @yack.something.test do |value|
      test = value
    end
    @yack.process_yaml({:something  => {:test => 2}}.to_yaml)
    test.must_equal 2
  end

  it "should not change anything if callback not defined" do
    test = 1
    @yack.process_yaml({:something  => {:test => 2}}.to_yaml)
    test.must_equal 1
  end
end