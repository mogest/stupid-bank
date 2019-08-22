class CreateTxns < ActiveRecord::Migration[6.0]
  def change
    create_table :txns do |t|
      t.integer :account_id, null: false, index: true

      t.datetime :transaction_at, null: false
      t.string :description, null: false
      t.float :amount, null: false

      t.timestamps
    end
  end
end
