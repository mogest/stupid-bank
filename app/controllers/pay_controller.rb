class PayController < ApplicationController
  before_action :ensure_logged_in
  layout 'user'

  Pay = Struct.new(:from_account_id, :to_account_number, :amount, :their_message, :your_message)

  def new
    @pay = Pay.new
    render_new
  end

  def create
    # BUG : using floats for amounts
    @pay = Pay.new(params[:from_account_id], params[:to_account_number], params[:amount].to_f, params[:their_message], params[:your_message])

    from_account = current_user.accounts.find_by(id: params[:from_account_id])
    to_account = Account.find_by(account_number: @pay.to_account_number)

    if @pay.amount < 0
      flash.now.alert = 'Payment must be more than $0'
      render_new
      return
    end

    service = TransferMoney.new(
      from_account, to_account, @pay.amount,
      their_message: @pay.their_message,
      your_message: @pay.your_message
    )

    if service.call
      redirect_to accounts_path, notice: 'Payment complete.'
    else
      flash.now.alert = service.error
      render_new
    end
  end

  private

  def render_new
    @accounts = current_user.accounts
    @account_options = @accounts.order(:account_number).map do |account|
      ["#{account.description} (#{helpers.number_to_currency account.balance})", account.id]
    end

    render 'new'
  end
end
