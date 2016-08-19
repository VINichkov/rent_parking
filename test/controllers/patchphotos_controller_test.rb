require 'test_helper'

class PatchphotosControllerTest < ActionController::TestCase
  setup do
    @patchphoto = patchphotos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:patchphotos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create patchphoto" do
    assert_difference('Patchphoto.count') do
      post :create, patchphoto: { parking_id: @patchphoto.parking_id, patch: @patchphoto.patch }
    end

    assert_redirected_to patchphoto_path(assigns(:patchphoto))
  end

  test "should show patchphoto" do
    get :show, id: @patchphoto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @patchphoto
    assert_response :success
  end

  test "should update patchphoto" do
    patch :update, id: @patchphoto, patchphoto: { parking_id: @patchphoto.parking_id, patch: @patchphoto.patch }
    assert_redirected_to patchphoto_path(assigns(:patchphoto))
  end

  test "should destroy patchphoto" do
    assert_difference('Patchphoto.count', -1) do
      delete :destroy, id: @patchphoto
    end

    assert_redirected_to patchphotos_path
  end
end
