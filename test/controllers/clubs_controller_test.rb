# frozen_string_literal: true

require 'test_helper'

class ClubsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club = clubs(:sokol)
  end

  test 'should get index' do
    get clubs_url
    assert_response :success
  end

  # test "should get new" do
  #   get new_club_url
  #   assert_response :success
  # end
  #
  # test "should create club" do
  #   assert_difference("Club.count") do
  #     post clubs_url, params: { club: {  } }
  #   end
  #
  #   assert_redirected_to club_url(Club.last)
  # end
  #
  # test "should show club" do
  #   get club_url(@club)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_club_url(@club)
  #   assert_response :success
  # end
end
