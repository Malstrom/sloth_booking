# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :selected_day

  private

  # Use callbacks to share common setup or constraints between actions.
  def selected_day
    @selected_day = params[:selected_day] ? params[:selected_day].to_date : Date.today
  end
end
