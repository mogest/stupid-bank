class TransfersController < ApplicationController
  before_action :ensure_logged_in
  layout 'user'

  def new
    @accounts = current_user.accounts
    @account_options = @accounts.order(:account_number).map do |account|
      ["#{account.description} (#{helpers.number_to_currency account.balance})", account.id]
    end
  end

  def create
    from_account = current_user.accounts.find_by(id: params[:from])
    to_account = current_user.accounts.find_by(id: params[:to])

    amount = params[:amount].to_f

    service = TransferMoney.new(from_account, to_account, amount)
    if service.call
      redirect_to accounts_path, notice: 'Transfer complete.'
    else
      redirect_to new_transfers_path, alert: service.error
    end
  end
end
