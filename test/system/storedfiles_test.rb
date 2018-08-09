require "application_system_test_case"

class StoredfilesTest < ApplicationSystemTestCase
  setup do
    @storedfile = storedfiles(:one)
  end

  test "visiting the index" do
    visit storedfiles_url
    assert_selector "h1", text: "Storedfiles"
  end

  test "creating a Storedfile" do
    visit storedfiles_url
    click_on "New Storedfile"

    fill_in "Data", with: @storedfile.data
    fill_in "Name", with: @storedfile.name
    fill_in "Todo", with: @storedfile.todo_id
    click_on "Create Storedfile"

    assert_text "Storedfile was successfully created"
    click_on "Back"
  end

  test "updating a Storedfile" do
    visit storedfiles_url
    click_on "Edit", match: :first

    fill_in "Data", with: @storedfile.data
    fill_in "Name", with: @storedfile.name
    fill_in "Todo", with: @storedfile.todo_id
    click_on "Update Storedfile"

    assert_text "Storedfile was successfully updated"
    click_on "Back"
  end

  test "destroying a Storedfile" do
    visit storedfiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Storedfile was successfully destroyed"
  end
end
