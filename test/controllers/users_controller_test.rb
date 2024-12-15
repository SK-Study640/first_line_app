require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get pending" do
    get users_pending_url
    assert_response :success
  end

  test "should get incoming" do
    get users_incoming_url
    assert_response :success
  end

  test "should get registered" do
    get users_registered_url
    assert_response :success
  end
end
