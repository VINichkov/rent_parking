require 'test_helper'

class ParkingsControllerTest < ActionController::TestCase
  setup do
    @parking = parkings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parkings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parking" do
    assert_difference('Parking.count') do
      post :create, parking: { accessible: @parking.accessible, adress: @parking.adress, covered: @parking.covered, descriptions: @parking.descriptions, langitude: @parking.langitude, latitude: @parking.latitude, name: @parking.name, open24: @parking.open24, overnight: @parking.overnight, price: @parking.price, restrictions: @parking.restrictions, sitestaff: @parking.sitestaff, typerent: @parking.typerent, user_id: @parking.user_id, valet: @parking.valet }
    end

    assert_redirected_to parking_path(assigns(:parking))
  end

  test "should show parking" do
    get :show, id: @parking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parking
    assert_response :success
  end

  test "should update parking" do
    patch :update, id: @parking, parking: { accessible: @parking.accessible, adress: @parking.adress, covered: @parking.covered, descriptions: @parking.descriptions, langitude: @parking.langitude, latitude: @parking.latitude, name: @parking.name, open24: @parking.open24, overnight: @parking.overnight, price: @parking.price, restrictions: @parking.restrictions, sitestaff: @parking.sitestaff, typerent: @parking.typerent, user_id: @parking.user_id, valet: @parking.valet }
    assert_redirected_to parking_path(assigns(:parking))
  end

  test "should destroy parking" do
    assert_difference('Parking.count', -1) do
      delete :destroy, id: @parking
    end

    assert_redirected_to parkings_path
  end
end
