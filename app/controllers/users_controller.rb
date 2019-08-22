class UsersController < ApplicationController
  def create
    @user = User.new(
      name: params[:user][:name],
      pin: rand(10000).to_s.rjust(4, '0')
    )

    if !@user.save
      redirect_to root_path, alert: 'Invalid name.'
    else
      account = @user.accounts.create!(
        account_number: "99-#{@user.id.to_s.rjust(7, '0')}-00",
        description: 'Daily account',
      )

      account.txns.create!(
        transaction_at: Time.zone.now,
        description: 'Initial deposit',
        amount: 500
      )

      @user.accounts.create!(
        account_number: "99-#{@user.id.to_s.rjust(7, '0')}-01",
        description: 'Savings account',
      )

      log_in_user!(@user)
    end
  end
end
