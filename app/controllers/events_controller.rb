class EventsController < ApplicationController
  before_action :authenticate, except: :show

  def show
    @event = Event.find(params[:id])
    @ticket = current_user && current_user.tickets.find_by(event_id: params[:id])
    @tickets = @event.tickets.includes(:user).order(:created_at)
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "作成しました"
      redirect_to @event
    else
      render :new
    end
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update(event_params)
      flash[:success] = "更新しました"
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy!
    flash[:danger] = "削除しました"
    redirect_to root_path
  end

  private

    def event_params
      params.require(:event).permit(:name, :place,
                                :content, :start_time, :end_time)
    end
end
