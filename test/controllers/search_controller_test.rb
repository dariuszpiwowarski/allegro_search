require 'test_helper'

class SearchControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get search" do
    get :search, category_id: '', query: 'some query'
    assert_response :success
  end

  test "shouldn't get search with empty query" do
    get :search, query: ''
    assert_response :error
  end

end
