class AccountsController < ApplicationController
  before_action :ensure_logged_in
  layout 'user'

  def index
    @accounts = current_user.accounts.order(:account_number)
  end

  def show
    # VULN : should restrict to current_user accounts
    @account = Account.find(params[:id])
  end

  def update
    account = current_user.accounts.find(params[:id])

    # VULN : SQL injection
    sql = "UPDATE accounts SET description = '#{params[:account][:description]}' WHERE id = #{account.id}"

    Account.connection.execute(sql)

    redirect_to account
  end
end
