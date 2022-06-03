require "application_system_test_case"

class TimetablesTest < ApplicationSystemTestCase
  setup do
  end

  test "visiting the index" do
    visit timetable_index_url
  end
  #
  # test "should create training" do
  #   visit trainings_url
  #   click_on "New training"
  #
  #   fill_in "Ends at", with: @training.ends_at
  #   fill_in "Name", with: @training.name
  #   fill_in "Price", with: @training.price
  #   fill_in "Starts at", with: @training.starts_at
  #   fill_in "Trainer", with: @training.trainer
  #   click_on "Create Training"
  #
  #   assert_text "Training was successfully created"
  #   click_on "Back"
  # end
  #
  # test "should update Training" do
  #   visit training_url(@training)
  #   click_on "Edit this training", match: :first
  #
  #   fill_in "Ends at", with: @training.ends_at
  #   fill_in "Name", with: @training.name
  #   fill_in "Price", with: @training.price
  #   fill_in "Starts at", with: @training.starts_at
  #   fill_in "Trainer", with: @training.trainer
  #   click_on "Update Training"
  #
  #   assert_text "Training was successfully updated"
  #   click_on "Back"
  # end
  #
  # test "should destroy Training" do
  #   visit training_url(@training)
  #   click_on "Destroy this training", match: :first
  #
  #   assert_text "Training was successfully destroyed"
  # end
end
