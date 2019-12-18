class TicketsController < ApplicationController
  before_action :authenticate

  def new
    raise ActionController::RoutingError, "ログイン状態で TicketsController#new にアクセス"
  end

  def create
    @ticket = current_user.tickets.build do |t|
      t.event_id = params[:event_id]
      t.comment = params[:ticket][:comment]
    end
    if @ticket.save
      flash[:success] = "このイベントに参加表明しました"
      head 201
    else
      render status: 422, json: { messages: @ticket.errors.full_messages }
    end
  end

  def destroy
    @ticket = current_user.tickets.find_by!(event_id: params[:id])
    @ticket.destroy!
    flash[:danger] = "このイベントの参加をキャンセルしました"
    redirect_to event_path(@ticket.event_id)
  end
end
