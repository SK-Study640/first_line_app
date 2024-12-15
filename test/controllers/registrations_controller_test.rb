require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get registrations_new_url
    assert_response :success
  end

  test "should get confirm" do
    get registrations_confirm_url
    assert_response :success
  end

  test "should get complete" do
    get registrations_complete_url
    assert_response :success
  end
end
