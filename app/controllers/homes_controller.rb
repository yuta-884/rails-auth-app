class HomesController < ApplicationController
  def index
    @q = Event.page(params[:page]).per(10).order(:start_time).ransack(search_params)

    @events = @q.result
  end

  private

    def search_params
      params.require(:q).permit(:name_cont, :start_time_gteq)
    rescue
      { start_time_gteq: Time.zone.now }
    end
end
