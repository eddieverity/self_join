class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender
      t.references :recipient
      t.text :content

      t.timestamps null: false
    end
    add_foreign_key(:messages, :users, column: :sender_id)
    add_foreign_key(:messages, :users, column: :recipient_id)
  end
end
