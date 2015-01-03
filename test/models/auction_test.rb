require 'test_helper'

class AuctionTest < ActiveSupport::TestCase
  test "should not save auction without url" do
    auction = Auction.new
    auction.name = 'some name'
    assert_not auction.save
  end

  test "should not save auction without name" do
    auction = Auction.new
    auction.url = 'http://www.site.org'
    assert_not auction.save
  end

  test "should not save auction with duplicated url" do
    auction = auctions(:one)
    auction2 = auction.dup
    assert_not auction2.save 
  end
end
