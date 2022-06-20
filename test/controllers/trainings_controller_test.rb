# frozen_string_literal: true
# require "test_helper"
#
# class TrainingsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @training = trainings(:one)
#   end
#
#   test "should get index" do
#     get trainings_url
#     assert_response :success
#   end
#
#   test "should get new" do
#     get new_training_url
#     assert_response :success
#   end
#
#   test "should create training" do
#     assert_difference("Training.count") do
#       post trainings_url, params: { training: { ends_at: @training.ends_at, name: @training.name, price: @training.price, starts_at: @training.starts_at, trainer: @training.trainer } }
#     end
#
#     assert_redirected_to training_url(Training.last)
#   end
#
#   test "should show training" do
#     get training_url(@training)
#     assert_response :success
#   end
#
#   test "should get edit" do
#     get edit_training_url(@training)
#     assert_response :success
#   end
#
#   test "should update training" do
#     patch training_url(@training), params: { training: { ends_at: @training.ends_at, name: @training.name, price: @training.price, starts_at: @training.starts_at, trainer: @training.trainer } }
#     assert_redirected_to training_url(@training)
#   end
#
#   test "should destroy training" do
#     assert_difference("Training.count", -1) do
#       delete training_url(@training)
#     end
#
#     assert_redirected_to trainings_url
#   end
# end
