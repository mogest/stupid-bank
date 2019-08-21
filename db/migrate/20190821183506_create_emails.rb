class CreateEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails do |t|
      t.integer :sender_user_id, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
