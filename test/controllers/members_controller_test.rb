require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get members_index_url
    assert_response :success
  end

  test "should get create" do
    get members_create_url
    assert_response :success
  end

  test "should get new" do
    get members_new_url
    assert_response :success
  end

end
