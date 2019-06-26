require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get images_top_url
    assert_response :success
  end

end
