require "test_helper"

class TimecellsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timecell = timecells(:one)
  end

  test "should get index" do
    get timecells_url
    assert_response :success
  end

  test "should get new" do
    get new_timecell_url
    assert_response :success
  end

  test "should create timecell" do
    assert_difference("Timecell.count") do
      post timecells_url, params: { timecell: { gametable_id: @timecell.gametable_id, kind: @timecell.kind, time: @timecell.time, tournament_rating: @timecell.tournament_rating, value: @timecell.value } }
    end

    assert_redirected_to timecell_url(Timecell.last)
  end

  test "should show timecell" do
    get timecell_url(@timecell)
    assert_response :success
  end

  test "should get edit" do
    get edit_timecell_url(@timecell)
    assert_response :success
  end

  test "should update timecell" do
    patch timecell_url(@timecell), params: { timecell: { gametable_id: @timecell.gametable_id, kind: @timecell.kind, time: @timecell.time, tournament_rating: @timecell.tournament_rating, value: @timecell.value } }
    assert_redirected_to timecell_url(@timecell)
  end

  test "should destroy timecell" do
    assert_difference("Timecell.count", -1) do
      delete timecell_url(@timecell)
    end

    assert_redirected_to timecells_url
  end
end
