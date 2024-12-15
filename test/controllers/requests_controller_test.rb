require "test_helper"

class RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm" do
    get requests_confirm_url
    assert_response :success
  end

  test "should get remove" do
    get requests_remove_url
    assert_response :success
  end

  test "should get cancel" do
    get requests_cancel_url
    assert_response :success
  end
end
