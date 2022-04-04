require "test_helper"

class InvitationControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get invitation_show_url
    assert_response :success
  end
end
