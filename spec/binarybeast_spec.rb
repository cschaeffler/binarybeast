require 'spec_helper'

describe Binarybeast do
	it "must have apikey variable" do
		Binarybeast.api_key.should == "3c8955130c6e1406420d6202649651fe.50c9faa593f9c6.00530099"
	end
end