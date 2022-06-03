# require "application_system_test_case"
#
# class SlotsTest < ApplicationSystemTestCase
#   setup do
#     @slot = slots(:one)
#   end
#
#   test "visiting the index" do
#     visit slots_url
#     assert_selector "h1", text: "Slots"
#   end
#
#   test "should create slot" do
#     visit slots_url
#     click_on "New slot"
#
#     fill_in "Bookable", with: @slot.bookable_id
#     fill_in "Bookable type", with: @slot.bookable_type
#     fill_in "Gametable", with: @slot.gametable_id
#     fill_in "Price", with: @slot.price
#     fill_in "Time", with: @slot.time
#     click_on "Create Slot"
#
#     assert_text "Slot was successfully created"
#     click_on "Back"
#   end
#
#   test "should update Slot" do
#     visit slot_url(@slot)
#     click_on "Edit this slot", match: :first
#
#     fill_in "Bookable", with: @slot.bookable_id
#     fill_in "Bookable type", with: @slot.bookable_type
#     fill_in "Gametable", with: @slot.gametable_id
#     fill_in "Price", with: @slot.price
#     fill_in "Time", with: @slot.time
#     click_on "Update Slot"
#
#     assert_text "Slot was successfully updated"
#     click_on "Back"
#   end
#
#   test "should destroy Slot" do
#     visit slot_url(@slot)
#     click_on "Destroy this slot", match: :first
#
#     assert_text "Slot was successfully destroyed"
#   end
# end
