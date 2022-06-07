require "application_system_test_case"

class TrainingsTest < ApplicationSystemTestCase
  setup do
    @new_training = trainings(:new_training)
    @training_assigned = trainings(:first_training)
    @training_not_assigned = trainings(:training_not_assigned)
  end

  test "should create training" do
    visit root_path
    click_on "newTraining"

    fill_in "Name", with: @new_training.name
    fill_in "Price", with: @new_training.price
    fill_in "Trainer", with: @new_training.trainer

    click_on "Save training"

    assert_text "Training saved!"
  end

  test "should update Training" do
    visit root_path
    click_on "training_#{@training_not_assigned.id}_open_collapse", match: :first

    fill_in "Name", with: "test"
    fill_in "Trainer", with: "new trainer"

    click_on "Update Training"

    assert_text "Training updated"
  end

  test "should destroy Training" do
    visit root_path
    click_on "training_#{@training_not_assigned.id}_open_collapse", match: :first
    click_on "training_#{@training_not_assigned.id}_delete", match: :first

    assert_text "Training deleted"
  end

  test "should not destroy Training assigned to a slot" do
    visit root_path
    click_on "training_#{@training_assigned.id}_open_collapse", match: :first
    click_on "training_#{@training_assigned.id}_delete", match: :first

    assert_text "Can't delete tournament assigned to a slot"
  end
end
