class CreatePublicTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :public_tokens do |t|
      t.string :token
      t.datetime :expires

      t.timestamps
    end
    add_index :public_tokens, :token, unique: true
  end
end
