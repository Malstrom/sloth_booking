# frozen_string_literal: true

require 'application_system_test_case'

class TournamentsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers # Rails >= 5

  setup do
    @user = users(:client)
    sign_in @user
    @new_tournament = tournaments(:new_tournament)
    @tournament_assigned = tournaments(:first_tournament)
    @tournament_not_assigned = tournaments(:tournament_not_assigned)
  end

  test 'should create tournament' do
    visit root_path
    click_on 'newTournament'

    fill_in 'Rating', with: @new_tournament.rating
    fill_in 'Price', with: @new_tournament.price

    click_on 'Save tournament'

    assert_text 'Tournament saved!'
  end

  test 'should update tournament' do
    visit root_path
    click_on "tournament_#{@tournament_not_assigned.id}_open_collapse", match: :first

    fill_in 'Rating', with: 340

    click_on 'Update Tournament'

    assert_text 'Tournament updated'
  end

  test 'should destroy tournament' do
    visit root_path
    click_on "tournament_#{@tournament_not_assigned.id}_open_collapse", match: :first
    click_on "tournament_#{@tournament_not_assigned.id}_delete", match: :first

    assert_text 'Tournament deleted'
  end
end
