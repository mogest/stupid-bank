class PinController < ApplicationController
  before_action :ensure_logged_in
  layout 'user'

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.pin = params[:pin]

    if @user.save
      redirect_to accounts_path, notice: 'PIN number updated.'
    else
      headers['X-XSS-Protection'] = '0'
      render 'edit'
    end
  end
end
