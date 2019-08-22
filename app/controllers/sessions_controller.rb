class SessionsController < ApplicationController
  def create
    user = User.find_by(id: params[:id], pin: params[:pin])
    if user
      log_in_user!(user)
      redirect_to accounts_path
    else
      redirect_to root_path, alert: 'Incorrect login details.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
