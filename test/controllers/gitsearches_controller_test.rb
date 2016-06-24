require 'test_helper'

class GitsearchesControllerTest < ActionController::TestCase

  test "should get index" do
    get(:index, {'gh_name' => "timpwbaker"})
    assert_response :success
  end

  test "should get json_object" do
    get(:index, {'gh_name' => "timpwbaker"})
    assert_not_nil assigns(:github_json_object)
  end

  test "should get create numbers and languages arrays" do
    get(:index, {'gh_name' => "timpwbaker"})
    assert_not_nil assigns(:numbers)
    assert_not_nil assigns(:languages)
  end

  test "should get create final sentence list of languages" do
    get(:index, {'gh_name' => "timpwbaker"})
    assert_not_nil assigns(:primary_languages)
  end



end
