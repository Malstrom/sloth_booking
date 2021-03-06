# frozen_string_literal: true

require 'application_system_test_case'

class TrainingsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers # Rails >= 5

  setup do
    @user = users(:client)
    sign_in @user
    @new_training = trainings(:new_training)
    @training_assigned = trainings(:first_training)
    @training_not_assigned = trainings(:training_not_assigned)
  end

  test 'should create training' do
    visit root_path
    click_on 'newTraining'

    fill_in 'Price', with: @new_training.price
    fill_in 'Trainer', with: @new_training.trainer

    click_on 'Save training'

    assert_text 'Training saved!'
  end

  test 'should update Training' do
    visit root_path
    click_on "training_#{@training_not_assigned.id}_open_collapse", match: :first

    fill_in 'Trainer', with: 'new trainer'

    click_on 'Update Training'

    assert_text 'Training updated'
  end

  test 'should destroy Training' do
    visit root_path
    click_on "training_#{@training_not_assigned.id}_open_collapse", match: :first
    click_on "training_#{@training_not_assigned.id}_delete", match: :first

    assert_text 'Training deleted'
  end
end
