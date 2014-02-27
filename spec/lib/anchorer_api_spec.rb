require 'spec_helper'

describe Anchorer::API do
  include Rack::Test::Methods
  it "should at least respond" do
    get '/anchorize?url=http://c7.se/switching-to-vundle/'

    assert_equal last_response.status, 200
  end
end
