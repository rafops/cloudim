require 'test_helper'

class DbInstancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @db_instance = db_instances(:one)
  end

  test "should get index" do
    get db_instances_url
    assert_response :success
  end

  test "should get new" do
    get new_db_instance_url
    assert_response :success
  end

  test "should create db_instance" do
    assert_difference('DbInstance.count') do
      post db_instances_url, params: { db_instance: { name: @db_instance.name } }
    end

    assert_redirected_to db_instance_url(DbInstance.last)
  end

  test "should show db_instance" do
    get db_instance_url(@db_instance)
    assert_response :success
  end

  test "should get edit" do
    get edit_db_instance_url(@db_instance)
    assert_response :success
  end

  test "should update db_instance" do
    patch db_instance_url(@db_instance), params: { db_instance: { name: @db_instance.name } }
    assert_redirected_to db_instance_url(@db_instance)
  end

  test "should destroy db_instance" do
    assert_difference('DbInstance.count', -1) do
      delete db_instance_url(@db_instance)
    end

    assert_redirected_to db_instances_url
  end
end
