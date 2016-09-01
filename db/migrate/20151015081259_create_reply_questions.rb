class CreateReplyQuestions < ActiveRecord::Migration
  def change
    create_table :reply_questions do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :body  
      t.timestamps null: false
    end
  end
end
