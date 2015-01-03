require 'test_helper'

class AuctionsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:auctions)
  end

  test "should creat new auction" do
    post :create, auction: {name: 'some name', url: 'http://www.sever.org'}
    assert_response :success
  end

  test "shouldn't creat new auction without mandatory data" do
    post :create, auction: {url: 'http://www.sever.org'}
    assert_response 422
  end

  test "should destroy auction" do
    assert_difference('Auction.count', -1) do
      @auction = auctions(:one)
      delete :destroy, id: @auction.id
    end
    assert_redirected_to auctions_path
    assert_equal('Auction deleted!', flash[:success])
  end

  test "shouldn't destroy already destroyed auction" do
    @auction = auctions(:one)
    @auction.delete
    assert_difference('Auction.count', 0) do
      delete :destroy, id: @auction.id
    end
    assert_redirected_to auctions_path
    assert_match(/Couldn't delete auction with id/, flash[:danger])
  end

end
