require 'spec_helper'

describe Anchorer::Anchorer do
  it "should add anchors" do
    anchorer = ::Anchorer::Anchorer.new 'http://google.com'

    modifed_content = anchorer.modify File.read(File.expand_path 'spec/fixtures/content2.html')

    assert_match  /<a name="heading-\d+\.\d+">/i,
                  modifed_content
  end
end
