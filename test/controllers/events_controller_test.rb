# require "test_helper"
#
# class EventsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @event = events(:one)
#     @club = clubs(:sokol)
#   end
#
#   test "should get index" do
#     get club_events_url(@club)
#     assert_response :success
#   end
#
#   test "should get new" do
#     get new_club_event_url(@club)
#     assert_response :success
#   end
#
#   test "should create event" do
#     assert_difference("Event.count") do
#       post club_events_url(@club), params: { event: { club_id: @event.club_id, email: @event.email, name: @event.name, phone: @event.phone } }
#     end
#
#     assert_redirected_to root_path
#   end
#
#   test "should show event" do
#     get club_event_url(@club, @event)
#     assert_response :success
#   end
#
#   test "should get edit" do
#     get edit_club_event_url(@club, @event)
#     assert_response :success
#   end
#
#   test "should update event" do
#     patch club_event_url(@club, @event), params: { event: { club_id: @event.club_id, email: @event.email, name: @event.name, phone: @event.phone } }
#     assert_redirected_to root_path
#   end
#
#   test "should destroy event" do
#     assert_difference("Event.count", -1) do
#       delete club_event_url(@club, @event)
#     end
#
#     assert_redirected_to club_events_url(@club)
#   end
# end
