require "test_helper"

class Api::V1::TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_tickets_create_url
    assert_response :success
  end
end
