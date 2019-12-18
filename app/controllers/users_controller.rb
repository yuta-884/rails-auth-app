class UsersController < ApplicationController
  before_action :authenticate

  def retire
  end

  def destroy
    if current_user.destroy
      reset_session
      flash[:success] = "退会完了しました"
      redirect_to root_path
    else
      render :retire
    end
  end
end
