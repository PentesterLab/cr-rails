require 'test_helper'

class StoredfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @storedfile = storedfiles(:one)
  end

  test "should get index" do
    get storedfiles_url
    assert_response :success
  end

  test "should get new" do
    get new_storedfile_url
    assert_response :success
  end

  test "should create storedfile" do
    assert_difference('Storedfile.count') do
      post storedfiles_url, params: { storedfile: { data: @storedfile.data, name: @storedfile.name, todo_id: @storedfile.todo_id } }
    end

    assert_redirected_to storedfile_url(Storedfile.last)
  end

  test "should show storedfile" do
    get storedfile_url(@storedfile)
    assert_response :success
  end

  test "should get edit" do
    get edit_storedfile_url(@storedfile)
    assert_response :success
  end

  test "should update storedfile" do
    patch storedfile_url(@storedfile), params: { storedfile: { data: @storedfile.data, name: @storedfile.name, todo_id: @storedfile.todo_id } }
    assert_redirected_to storedfile_url(@storedfile)
  end

  test "should destroy storedfile" do
    assert_difference('Storedfile.count', -1) do
      delete storedfile_url(@storedfile)
    end

    assert_redirected_to storedfiles_url
  end
end
