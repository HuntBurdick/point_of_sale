require 'test_helper'

class SaleItemsControllerTest < ActionController::TestCase
  setup do
    @sale_item = sale_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale_item" do
    assert_difference('SaleItem.count') do
      post :create, sale_item: {  }
    end

    assert_redirected_to sale_item_path(assigns(:sale_item))
  end

  test "should show sale_item" do
    get :show, id: @sale_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sale_item
    assert_response :success
  end

  test "should update sale_item" do
    put :update, id: @sale_item, sale_item: {  }
    assert_redirected_to sale_item_path(assigns(:sale_item))
  end

  test "should destroy sale_item" do
    assert_difference('SaleItem.count', -1) do
      delete :destroy, id: @sale_item
    end

    assert_redirected_to sale_items_path
  end
end
