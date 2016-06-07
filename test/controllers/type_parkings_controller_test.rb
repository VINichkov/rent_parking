require 'test_helper'

class TypeParkingsControllerTest < ActionController::TestCase
  setup do
    @type_parking = type_parkings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:type_parkings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create type_parking" do
    assert_difference('TypeParking.count') do
      post :create, type_parking: { Name: @type_parking.Name }
    end

    assert_redirected_to type_parking_path(assigns(:type_parking))
  end

  test "should show type_parking" do
    get :show, id: @type_parking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @type_parking
    assert_response :success
  end

  test "should update type_parking" do
    patch :update, id: @type_parking, type_parking: { Name: @type_parking.Name }
    assert_redirected_to type_parking_path(assigns(:type_parking))
  end

  test "should destroy type_parking" do
    assert_difference('TypeParking.count', -1) do
      delete :destroy, id: @type_parking
    end

    assert_redirected_to type_parkings_path
  end
end
