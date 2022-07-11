# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :selected_day

  private

  # Use callbacks to share common setup or constraints between actions.
  def selected_day
    @selected_day = params[:selected_day] ? params[:selected_day].to_date : Date.tomorrow
  end

  # Use callbacks to share common setup or constraints between actions.
  def notice_with_button(value)
    "Tournament saved! #{view_context.button_tag('Set in calendar', class: 'btn btn-primary btn-sm', value: value,
                                                                    data: { controller: 'hello', action: 'click->hello#selectKind' })}"
  end
end
