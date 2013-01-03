require 'spec_helper'

describe BinaryBeast do
	it "must have apikey variable" do
		BinaryBeast.api_key.should == "e17d31bfcbedd1c39bcb018c5f0d0fbf.4dcb36f5cc0d74.24632846"
	end
	it "should have a raw call method" do
		BinaryBeast.should respond_to(:call)
	end
end