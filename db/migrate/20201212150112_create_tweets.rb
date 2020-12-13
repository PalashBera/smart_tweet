class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :message,  null: false, limit: 250
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
