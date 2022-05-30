require "application_system_test_case"

class TimecellsTest < ApplicationSystemTestCase
  setup do
    @timecell = timecells(:one)
  end

  test "visiting the index" do
    visit timecells_url
    assert_selector "h1", text: "Timecells"
  end

  test "should create timecell" do
    visit timecells_url
    click_on "New timecell"

    fill_in "Gametable", with: @timecell.gametable_id
    fill_in "Kind", with: @timecell.kind
    fill_in "Time", with: @timecell.time
    fill_in "Tournament rating", with: @timecell.tournament_rating
    fill_in "Value", with: @timecell.value
    click_on "Create Timecell"

    assert_text "Timecell was successfully created"
    click_on "Back"
  end

  test "should update Timecell" do
    visit timecell_url(@timecell)
    click_on "Edit this timecell", match: :first

    fill_in "Gametable", with: @timecell.gametable_id
    fill_in "Kind", with: @timecell.kind
    fill_in "Time", with: @timecell.time
    fill_in "Tournament rating", with: @timecell.tournament_rating
    fill_in "Value", with: @timecell.value
    click_on "Update Timecell"

    assert_text "Timecell was successfully updated"
    click_on "Back"
  end

  test "should destroy Timecell" do
    visit timecell_url(@timecell)
    click_on "Destroy this timecell", match: :first

    assert_text "Timecell was successfully destroyed"
  end
end
