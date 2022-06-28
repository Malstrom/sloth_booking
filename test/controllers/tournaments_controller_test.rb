# frozen_string_literal: true

require 'test_helper'

class TournamentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club = clubs(:sokol)
    @tournament = tournaments(:first_tournament)
    @tomorrow = Date.tomorrow
  end

  test 'should create tournament' do
    assert_difference('Tournament.count') do
      post club_tournaments_url(@club),
           params: { tournament: { price: @tournament.price, rating: @tournament.rating, day: @tomorrow } }
    end
  end

  test 'should update tournament' do
    patch club_tournament_url(@club, @tournament), params: { tournament: { rating: '700' } }
    assert_equal('700', Tournament.find(@tournament.id).rating)
  end

  test 'should destroy tournament' do
    assert_difference('Tournament.count', -1) do
      delete club_tournament_url(@club, @tournament)
    end
  end
end
