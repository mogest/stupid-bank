class TransferMoney
  attr_reader :from_account, :to_account, :amount
  attr_reader :their_message, :your_message
  attr_reader :error

  def initialize(from_account, to_account, amount, their_message: nil, your_message: nil)
    @from_account = from_account
    @to_account = to_account
    @their_message = their_message
    @your_message = your_message
    @amount = amount
  end

  def call
    # VULN : no validation that amount is positive
    # VULN : no validation that amount doesn't have more than 2d.p.

    if from_account.nil?
      @error = 'From account not set.'
      return
    elsif to_account.nil?
      @error = 'To account not set or not found.'
      return
    elsif from_account.balance < amount
      @error = 'Not enough money in source account.'
      return
    end

    # VULN : not atomic
    to_account.txns.create!(
      transaction_at: Time.zone.now,
      description: their_message.present? ? their_message : "Transfer from #{from_account.account_number}",
      amount: amount
    )

    from_account.txns.create!(
      transaction_at: Time.zone.now,
      description: your_message.present? ? your_message : "Transfer to #{from_account.account_number}",
      amount: -amount
    )

    true
  end
end
