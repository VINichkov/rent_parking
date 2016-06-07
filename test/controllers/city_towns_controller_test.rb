require 'test_helper'

class CityTownsControllerTest < ActionController::TestCase
  setup do
    @city_town = city_towns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:city_towns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create city_town" do
    assert_difference('CityTown.count') do
      post :create, city_town: { area: @city_town.area, name: @city_town.name }
    end

    assert_redirected_to city_town_path(assigns(:city_town))
  end

  test "should show city_town" do
    get :show, id: @city_town
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @city_town
    assert_response :success
  end

  test "should update city_town" do
    patch :update, id: @city_town, city_town: { area: @city_town.area, name: @city_town.name }
    assert_redirected_to city_town_path(assigns(:city_town))
  end

  test "should destroy city_town" do
    assert_difference('CityTown.count', -1) do
      delete :destroy, id: @city_town
    end

    assert_redirected_to city_towns_path
  end
end
