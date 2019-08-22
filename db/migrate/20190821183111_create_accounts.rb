class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.integer :user_id, null: false, index: true
      t.string :account_number, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
