# frozen_string_literal: true

require 'test_helper'

class TrainingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club = clubs(:sokol)
    @training = trainings(:first_training)
    @tomorrow = Date.tomorrow
  end

  test 'should create training' do
    assert_difference('Training.count') do
      post club_trainings_url(@club),
           params: { training: { price: @training.price, trainer: @training.trainer, day: @tomorrow } }
    end
  end

  test 'should update training' do
    patch club_training_url(@club, @training), params: { training: { trainer: 'updated' } }
    assert_equal('updated', Training.find(@training.id).trainer)
  end

  test 'should destroy training' do
    assert_difference('Training.count', -1) do
      delete club_training_url(@club, @training)
    end
  end
end
